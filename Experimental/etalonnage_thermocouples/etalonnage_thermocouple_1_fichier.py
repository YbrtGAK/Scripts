# -*- coding: utf-8 -*-
"""
Created on Tue Jun  4 16:13:50 2024

@author: Y.Berton
"""

# Imports
import pandas as pd  # Library for tables and statistic operations
import matplotlib.pyplot as plt  # Library for graphs

# Libraries for file exploring
import os
import tkinter as tk  # Note : no mandotory, if you don't want to install tk package
from tkinter import filedialog  # give the paths manually
from utilities.path import getAFilesPath, getADirsPath, getAFilesPathToSave
from utilities.data.lvm import  lvm_to_df
from utilities.data. h5 import h5py_to_dataframe 
from utilities.widgets import getElementFromWidgetList

import numpy as np  # Library for vectorial objects
# Library for machine learning tools
from scipy import stats
from sklearn.metrics import mean_squared_error
from scipy.optimize import least_squares

# Flags
# Choose to display graphs
save_graph = True # Save the graph
save_excel = True #Save the fitting laws in an excel file

#Visual check to see if the thermocouples work properly
def check_sensor_channel_matching(df):
    df_std = df.std()
    return(df_std[df_std > 1])
    

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                         Get the data in DataFrames
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
path = getAFilesPath()
fmt = path.split('/')[-1].split('.')[-1]

match fmt :
    case "h5" : 
        df = h5py_to_dataframe(path,'Scan000','Detector000','NavAxes','Data0D',['CH00'])[0]
    case "lvm" :
        df = lvm_to_df(path)
    case _ :
        print("Format unrecognized, please check your file :/")
     
%matplotlib qt5
df = df[df.index <= "11-23-2024"]
    
df.plot()

df_std = df.std()
df_raw = df_filtered = df.copy()  # We save the raw value in a unbinded dataframe
df_filtered = df.filter(getElementFromWidgetList("Keithley Channels", list(df_filtered.columns.values)))

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                            Measures treatments
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# The idea here is to get rid of the transition period in between two calibration points
# In order to do so, a standart deviation calculus is realized for each temperature value over the four last values
# If it is under a certain value to be defined by the user, then the measure is erased

###############Let's make sure that the steady state was reached###############

#Get the serie time step
dt = df.index[1] - df.index[0]
dt = dt.seconds + dt.microseconds*10e-6 + dt.nanoseconds*10e-9 # [seconds]
t_step = 40 # Time step for steady state conditions in the rolling(std) method of df [seconds]

# Cut the experimental data corresponding to the end of the calibration

df_filtered.plot()
#df_filtered = df_filtered[df_filtered.index < 2250]

# Get the temperature used for the calibration from user
# Temperatures used for the calibration
LT = [15 + i*15 for i in range(0,8)]

# We find in between temp in order to split the dataframe in several ones for a giver reference temmperature
LT_to_sort = [(LT[i] + LT[i+1])/2 for i in range(0, 7)]
df_to_sort = df_filtered.copy()

# Now we sort them. Here, the first column (cor ponding to the "first" thermocouple)
# is used in order to split df. Make sure it is not broken before using it for this task.
# It is broken ? Change the indice 0 with another one to avoid issues.

Ldfs = []  # Initializing list of dataframe
for Tmax in LT_to_sort:
    df_left = df_to_sort[df_to_sort.iloc[:, 0] < Tmax]  # Cut data to add to the dataframe list
    df_to_sort = df_to_sort[df_to_sort.iloc[:, 0] >= Tmax]  # Cut this data from df
    Ldfs.append(df_left)  # Append the cut dataframe to the list of dataframe
# Finally, append the remaing data in df as the last dataframe of the list
Ldfs.append(df_to_sort)

Ldf_treated = []  # Initialization of treated list of dataframes
LTmean = []  # Initialization of Tmean array

std_lim = 0.01
std_buff = std_lim
Lstd= []
for i in range(len(Ldfs)):  # Going through all the dataframes for each temperature test
    df = Ldfs[i]  # Get the dataframe

    # Let's make sure that the steady state was reached
    # Get a standart deviation for a period set by the user through t_step
    df_std = df.rolling(round(t_step/dt)).std()
    cols = [col for col in df_std.columns]  # get columns' names in a array
    # Create new cols names
    new_cols = [col + '_std' for col in df_std.columns]

    # Add the std values to the first dataframe
    for i in range(0, len(new_cols)):
        df[new_cols[i]] = df_std[cols[i]]

    # Delete the lines where std < std_lim
    for i in range(int(len(df.columns)/2), int(len(df.columns))):
        std_buff = std_lim
        df_buff = df[df.iloc[:, i] < std_lim]
        while len(df_buff) <= 10:
            std_buff += 0.01
            df_buff = df[df.iloc[:, i] < std_buff] 
        df = df_buff.copy()
        Lstd.append(std_buff)
            
    Tmean = []
    # Get the average value
    for i in range(0, int(len(df.columns)/2)):
        Tmean.append(df.iloc[:, i].mean())

    # Add the treated dataframe to a list
    Ldf_treated.append(df)

    # Add the mean temperature to a list
    LTmean.append(Tmean)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                                Calibration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

# Creation of a dictionnary with the mean temperatures
index = LT
columns = cols
data = LTmean

# Creation of a dataframe from the dictionnary
df_mean = pd.DataFrame(index=index, columns=columns, data=data)
# Sort the dataframe per value
df_mean.sort_index(axis=0, ascending=True, inplace=True)

# Fitting function
def f_lin(x, a, b): return a*x + b

# Least squared method
def lst_sqrs(LTmean, LT):
    Lnew_coeff = []
    ytheo = np.array(LT)
    def fcost(coeff): return ytheo - f_lin(yexp,coeff[0],coeff[1])
    for i in range(0, len(LTmean[0])):
        yexp = np.array([line[i] for line in LTmean])
        coeff_0 = np.array([1, 0])
        res = least_squares(fcost, coeff_0, method='trf')
        Lnew_coeff.append((res.x[0], res.x[1]))
    return(Lnew_coeff)

Lnew_coeff = lst_sqrs(LTmean, LT)

#Root mean square error 
T_fit = []  #Initialization of the fitted temperature list

T_abs_fit = np.linspace(df_mean.index[0], df_mean.index[-1], 100) # Abscissa for calibration's evaluation
L_RMSE = [] #Initialization of the Root Mean Squared Error  list
for i in range(len(Lnew_coeff)) : 
    T_fit.append(f_lin(df_mean.index, Lnew_coeff[i][0], Lnew_coeff[i][1])) # Get the predicted temperature
    L_RMSE.append(mean_squared_error(df_mean.index,T_fit[-1], squared=False)) #


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                               Display graphs 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
#%matplotlib qt5

textstr = []  #Initialization of the labels' list


# For each thermocouple, get the fitted values from the evaluation of T_abs_fit
for i in range(len(Lnew_coeff)):
    
    if Lnew_coeff[i][1] <= 0:  # Cases for esthetic display purposes
        textstr.append('\n'.join((r'$T_{pred}$ = %.5f.$T_{mes}$ - %.5f ' % (Lnew_coeff[i][0], abs(Lnew_coeff[i][1])),  # Regression label creation
                                  'RMSE = %.3e [°C]' % (L_RMSE[i]))))
    else:
        textstr.append('\n'.join((r'$T_{pred}$ = %.5f.$T_{mes}$ + %.5f ' % (Lnew_coeff[i][0], Lnew_coeff[i][1]),  # Regression label creation
                                  'RMSE = %.3e [°C]' % (L_RMSE[i]))))

# Display of the 3 temperatures in place
phi = (1+5**0.5)/2  # Golden number to size graphs
Tmax = df_mean.index[-1]  # For graph scaling purposes, get T max

# 3 Subplots graph initialization
if len(Lnew_coeff) % 2 == 0 : nrow = int(len(Lnew_coeff)/2)
else : nrow = int(len(Lnew_coeff)/2) + 1
fig1, axs = plt.subplots(
    nrow, 2,constrained_layout=True, figsize=(12,12*phi))

# State box proprieties to display the fitting function expression
props = dict(boxstyle='round', facecolor='wheat', alpha=0.5)

# Color list
Lcolor = ['b','r','g','purple','orange','pink', 'brown', 'yellow', 'blue', 'grey', 'cyan', 'salmon', 'forestgreen']

if len(Lnew_coeff) == 2 : 
    
    axs[0].scatter(df_mean.index, df_mean.iloc[:, 0],
                      color=Lcolor[0], label= r'$T_{mes}$ (' +df_mean.columns[0] + ')')
    axs[0].plot(df_mean.index, T_fit[0], color=Lcolor[0], label=r'$T_{corrected}$')
    axs[0].text(0.55, 0.1, textstr[0], transform=axs[0].transAxes, fontsize=10,
                   verticalalignment='baseline', bbox=props)
    axs[1].scatter(df_mean.index, df_mean.iloc[:, 1],
                      color=Lcolor[1], label= r'$T_{mes}$ (' +df_mean.columns[1] + ')')
    axs[1].plot(df_mean.index, T_fit[1], color=Lcolor[1], label=r'$T_{corrected}$')
    axs[1].text(1.55, 1.1, textstr[1], transform=axs[1].transAxes, fontsize=10,
                   verticalalignment='baseline', bbox=props)
    
    for a in axs:
        a.set_xlabel('Targeted temperature [°C]')  # Set x label
        a.set_ylabel('Measured temperature [°C]')  # Set y label
        a.plot(df_mean.index, df_mean.index, '--k', linewidth=2,
               label=r'$id_E$')  # Display identity function's curve
        a.legend()  # Display legend
        a.grid()  # Display a grid
    
else : 
    for i in range(len(Lnew_coeff)):
        if i%2 == 0 :
            irow = int(i/2)
            icol = 0
        else :
            icol = 1
            irow = i - int(i/2) - 1
    
        axs[irow][icol].scatter(df_mean.index, df_mean.iloc[:, i],
                          color=Lcolor[i], label= r'$T_{mes}$ (' +df_mean.columns[i] + ')')
        axs[irow][icol].plot(df_mean.index, T_fit[i], color=Lcolor[i], label=r'$T_{corrected}$')
        axs[irow][icol].text(0.55, 0.1, textstr[i], transform=axs[irow][icol].transAxes, fontsize=10,
                       verticalalignment='baseline', bbox=props)
    # Action to do for all subplots/thermocouple analysis
    for ax in axs:
        for a in ax:
            a.set_xlabel('Targeted temperature [°C]')  # Set x label
            a.set_ylabel('Measured temperature [°C]')  # Set y label
            a.plot(df_mean.index, df_mean.index, '--k', linewidth=2,
                   label=r'$id_E$')  # Display identity function's curve
            a.legend()  # Display legend
            a.grid()  # Display a grid

if save_graph : 
    fig1.savefig(getAFilesPathToSave())

if save_excel :
    La = [coeff[0] for coeff in Lnew_coeff]
    Lb = [coeff[1] for coeff in Lnew_coeff]
    
    data = {'a' : La, 'b' : Lb, 'RMSE [°C]' : L_RMSE}
    df_fit = pd.DataFrame.from_dict(data, orient="index",columns=df_mean.columns).T
    df_fit.to_csv(getAFilesPathToSave(), sep=';', header=True)

