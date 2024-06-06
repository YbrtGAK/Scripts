# -*- coding: utf-8 -*-
"""
Created on Tue Jun  4 16:13:50 2024

@author: Y.Berton
"""

#Imports
import pandas as pd #Library for tables and statistic operations
import matplotlib.pyplot as plt #Library for graphs

#Libraries for file exploring
import os 
import tkinter as tk  #Note : no mandotory, if you don't want to install tk package
from tkinter import filedialog #give the paths manually
from utilities import getAFilesPath 

import numpy as np #Library for vectorial objects
from sklearn.linear_model import LinearRegression #Library for machine learning tools
from scipy.optimize import least_squares

#Flags

#Choose to display graphs
disp_graph = True #Display graph if true : not necessary for the calibration

one_file_per_temp = False 
#If true, you need to have the following architecture :    
"""
main folder
        - Tcons_1
            - Tcons_1a.lvm
            - Tcons_1b.lvm
            - [...]
        - Tcons_2
            - [...]
        - Tcons_3
            - [...]
        - [...]
"""
#If false, just point to your csv file (or lvm, or txt)


#File exploring function
def getADirPath(): 
    root = tk.Tk()
    root.withdraw()
     
    return(filedialog.askdirectory())

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                         Get the data in DataFrames
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

file_path = getAFilesPath()
df = pd.read_csv(file_path, sep='\t', on_bad_lines='skip',skiprows=22, decimal=',')
df = df.filter(['T_PH_in (wall)', 'T_PH_surf3', 'T_PH_surf4', 'T_PH_surf2'])
   
"""Dumb check
%matplotlib qt5
df.plot()
fig, axs = plt.subplots(2,2)
axs[0][0].scatter(df.index, df.iloc[:,0], label=df.columns[0],s=0.1)
axs[0][1].scatter(df.index, df.iloc[:,1], label=df.columns[1],s=0.1)
axs[1][0].scatter(df.index, df.iloc[:,2], label=df.columns[2],s=0.1)
axs[1][1].scatter(df.index, df.iloc[:,3], label=df.columns[3],s=0.1)
for ax in axs :
    for a in ax :
        a.legend()
        a.grid()
"""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                            Measures treatments
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
#The idea here is to get rid of the transition state in between a change of the calibration
#bench's temperature of reference
#In order to do so, a standart deviation calculus is calculated for each temperature value
#over the four last values
#If it is under a certain value to be defined by the user, then the measure is erased

###############Let's make sure that the steady state was reached###############

df = df[df.index < 2200] #Cut the experimental data corresponding to the end of the calibration
df_raw = df.copy() #We save the raw value in a unbinded dataframe

#Get the temperature used for the calibration from user
LT = [15,30,45,60,75,90,105,120] #Temperatures used for the calibration

#We find in between temp in order to split the dataframe in several ones for a giver reference temmperature
LT_to_sort = [(LT[i] + LT[i+1])/2 for i in range(0,7)]

#Now we sort them. Here, the first column (corresponding to the "first" thermocouple)
#is used in order to split df. Make sure it is not broken before using it for this task.
#It is broken ? Change the indice 0 with another one to avoid issues.

Ldfs = [] #Initializing list of dataframe
for Tmax in LT_to_sort : 
    df_left = df[df.iloc[:,0] < Tmax] #Cut data to add to the dataframe list
    df = df[df.iloc[:,0] >= Tmax] #Cut this data from df
    Ldfs.append(df_left) #Append the cut dataframe to the list of dataframe
Ldfs.append(df) #Finally, append the remaing data in df as the last dataframe of the list

Ldf_treated = [] #Initialization of treated list of dataframes 
LTmean = [] #Initialization of Tmean array

for i in range(len(Ldfs)): #Going through all the dataframes for each temperature test
    df = Ldfs[i] # Get the dataframe
    
    #Let's make sure that the steady state was reached
    df_std = df.rolling(4).std() #Get a standart deviation for each value according 4 of its previous ones
    cols = [col for col in df_std.columns] #get columns' names in a array
    new_cols = [col + '_std' for col in df_std.columns] #Create new cols names
    
    #Add the std values to the first dataframe
    for i in range(0, len(new_cols)):
        df[new_cols[i]] = df_std[cols[i]]
        
    #Delete the lines where std < 0.1 (why ? fixd after evaluation)     
    for i in range(int(len(df.columns)/2), int(len(df.columns))):
        df = df[df.iloc[:,i] < 0.1]
        
    Tmean = []    
    #Get the average value
    for i in range(0,int(len(df.columns)/2)):
        Tmean.append(df.iloc[:,i].mean())
        
    #Add the treated dataframe to a list
    Ldf_treated.append(df)
    
    #Add the mean temperature to a list
    LTmean.append(Tmean)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                                Calibration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

#Creation of a dictionnary with the mean temperatures
index = LT
columns = cols
data = LTmean

#Creation of a dataframe from the dictionnary
df_mean = pd.DataFrame(index = index, columns = columns, data=data)
df_mean.sort_index(axis = 0, ascending = True, inplace=True) #Sort the dataframe per value

#Linear regression function
def linear_regression(df_mean) : 
    La, Lb, Lr_sq = [], [], [] #Empty list initialization
    for col in df_mean.columns:
        x = np.array(df_mean.index.values).reshape((-1,1)) #Shape array for regression purposes
        y = np.array(df_mean.index.values - df_mean[col].values) #Same
        model = LinearRegression().fit(x,y) #Linear regression 
        La.append(model.coef_) #Get the slope coefficient (a)
        Lb.append(model.intercept_) #Get the coefficient of interception (b)
        Lr_sq.append(model.score(x, y)) #Get the R² value
    return(La,Lb,Lr_sq)

#Linear regression for all column in df_mean
La,Lb,Lr_sq = linear_regression(df_mean)

#Fitting function
f_lin = lambda x,a,b : a*x + b

#Least squared method
yexp = np.array([line[0] for line in LTmean])
ytheo = np.array(LT)
fcost = lambda coeff : ytheo - coeff[0]*yexp - coeff[1]

#Exemple avec thermocouple 1
coeff_0 = np.array([La[0][0], Lb[0]])
res = least_squares(fcost, coeff_0)
new_coeff = res.x


print(fcost(coeff_0))
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                               Display graphs 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if disp_graph : 
    textstr = [] #Initialization of the labels' list
    T_fit=[] #Initialization of the fitted temperature list
    T_abs_fit = np.linspace(df_mean.index[0], df_mean.index[-1], 100) #Horizontal axis to plot the fitted function's curve
    
    #For each thermocouple, get the fitted values from the evaluation of T_abs_fit
    for i in range(len(La)):
        T_fit.append(f_lin(T_abs_fit,La[i], Lb[i])) #Evaluation
        if Lb[i] <=0 : #Cases for esthetic display purposes
            textstr.append('\n'.join((r'y = %.5f.x - %.5f '%(La[i], abs(Lb[i])), #Regression label creation
                                      r'R² = %f'%( Lr_sq[i]))))
        else : 
            textstr.append('\n'.join((r'y = %.5f.x + %.5f '%(La[i], Lb[i]), #Regression label creation
                                      r'R² = %f'%( Lr_sq[i]))))
    T_fit.append(f_lin(T_abs_fit, new_coeff[0], new_coeff[1]))
        
    #Display of the 3 temperatures in place
    phi = (1+5**0.5)/2 #Golden number to size graphs
    Tmax = df_mean.index[-1] #For graph scaling purposes, get T max
    
    #3 Subplots graph initialization
    fig, axs = plt.subplots(2,2, constrained_layout=True, figsize=(2*3*phi,2*3))
    
    #State box proprieties to display the fitting function expression
    props = dict(boxstyle='round', facecolor='wheat', alpha=0.5)
    
    #Plot the first thermocouple's fit
    #Plot the measured temperature by the thermocouple
    axs[0][0].scatter(df_mean.index, df_mean.iloc[:,0],color='b', label = df_mean.columns[0])
    #Plot the fitted function's curve
    axs[0][0].plot(T_abs_fit, T_fit[-1], color='b', label = 'Reg trend line')
    #Place a text box in bottom right in axis coords
    axs[0][0].text(0.55, 0.1, textstr[0], transform=axs[0][0].transAxes, fontsize=10,
            verticalalignment='baseline', bbox=props)
    
    #Plot the second thermocouple's fit
    axs[0][1].scatter(df_mean.index, df_mean.iloc[:,1],color='r', label = df_mean.columns[1])
    axs[0][1].plot(T_abs_fit, T_fit[1], color='r', label = 'Trend line')
    axs[0][1].text(0.55, 0.1, textstr[1], transform=axs[0][1].transAxes, fontsize=10,
            verticalalignment='baseline', bbox=props)
    
    #Plot the third thermocouple's fit
    axs[1][0].scatter(df_mean.index, df_mean.iloc[:,2],color='g', label = df_mean.columns[2])
    axs[1][0].plot(T_abs_fit, T_fit[2], color='g', label = 'Trend line')
    axs[1][0].text(0.55, 0.1, textstr[2], transform=axs[1][0].transAxes, fontsize=10,
            verticalalignment='baseline', bbox=props)
    
    #Plot the fourth thermocouple's fit
    axs[1][1].scatter(df_mean.index, df_mean.iloc[:,3],color='purple', label = df_mean.columns[3])
    axs[1][1].plot(T_abs_fit, T_fit[3], color='purple', label = 'Trend line')
    axs[1][1].text(0.55, 0.1, textstr[3], transform=axs[1][1].transAxes, fontsize=10,
            verticalalignment='baseline', bbox=props)
    
    
    #Action to do for all subplots/thermocouple analysis
    for ax in axs : 
        for a in ax:
            a.set_xlabel('Targeted temperature [°C]') #Set x label
            a.set_ylabel('Measured temperature [°C]') #Set y label
            a.plot(df_mean.index,df_mean.index,'--k',linewidth=2, label=r'$id_E$') #Display identity function's curve
            a.legend() #Display legend
            a.grid() #Display a grid


Ttest = [e[0] for e in LTmean]
Ttest2 = [e[-1] for e in LTmean]

