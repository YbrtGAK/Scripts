"""
17/05/2024 - This script aims to calibrate thermocouples

@author: Yann BERTON
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

#You need to have the following architecture :    
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

M = [] #Initialization of the matrix of the measurements
LfoldersPath = [e[0] for e in os.walk(getADirPath())] #Get the directories path
del(LfoldersPath[0]) #Delete first element (parent directory path)
subDirNames = next(os.walk(getADirPath()))[1] #Get subdirectories names
for path in LfoldersPath : #Get the measurement files path
    M.append(os.listdir(path))

    
Ldf = [] # Initialization of the list of the dataframes
#Get data from each folder
#skiprows : number of lines to ignore from the file (withdraw header). To be adapted to each measure file ! 
for i in range(len(M)) :
    dfs = [pd.read_csv(LfoldersPath[i] + '/' + file,sep='\t', on_bad_lines='skip',skiprows=22) for file in M[i]] #Skiprow : withdraw header
    Ldf.append(pd.concat(dfs)) #For a given temperature, concat the dataframes in a single one
    
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                            Measures treatments
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Ldf_treated = [] #Initialization of treated list of dataframes 
LTmean = [] #Initialization of Tmean array

for i in range(len(Ldf)): #Going through all the dataframes for each temperature test
    df = Ldf[i] # Get the dataframe
    T = subDirNames[i] #Get the temperature value (serve no purpose in the code)
    
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
index = [float(e) for e in subDirNames]
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
        y = np.array(df_mean[col].values) #Same
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
fcost = lambda y,x,a,b : y - a*x - b


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
        
    #Display of the 3 temperatures in place
    phi = (1+5**0.5)/2 #Golden number to size graphs
    Tmax = df_mean.index[-1] #For graph scaling purposes, get T max
    
    #3 Subplots graph initialization
    fig, axs = plt.subplots(3, constrained_layout=True, figsize=(2*3,2*3*phi))
    
    #State box proprieties to display the fitting function expression
    props = dict(boxstyle='round', facecolor='wheat', alpha=0.5)
    
    #Plot the first thermocouple's fit
    #Plot the measured temperature by the thermocouple
    axs[0].scatter(df_mean.index, df_mean.iloc[:,0],color='b', label = df_mean.columns[0])
    #Plot the fitted function's curve
    axs[0].plot(T_abs_fit, T_fit[0], color='b', label = 'Trend line')
    #Place a text box in bottom right in axis coords
    axs[0].text(0.65, 0.1, textstr[0], transform=axs[0].transAxes, fontsize=10,
            verticalalignment='baseline', bbox=props)
    
    #Plot the second thermocouple's fit
    axs[1].scatter(df_mean.index, df_mean.iloc[:,1],color='r', label = df_mean.columns[1])
    axs[1].plot(T_abs_fit, T_fit[1], color='r', label = 'Trend line')
    axs[1].text(0.65, 0.1, textstr[1], transform=axs[1].transAxes, fontsize=10,
            verticalalignment='baseline', bbox=props)
    
    #Plot the third thermocouple's fit
    axs[2].scatter(df_mean.index, df_mean.iloc[:,2],color='g', label = df_mean.columns[2])
    axs[2].plot(T_abs_fit, T_fit[2], color='g', label = 'Trend line')
    axs[2].text(0.65, 0.1, textstr[2], transform=axs[2].transAxes, fontsize=10,
            verticalalignment='baseline', bbox=props)
    
    #Action to do for all subplots/thermocouple analysis
    for ax in axs : 
        ax.set_xlabel('Targeted temperature [°C]') #Set x label
        ax.set_ylabel('Measured temperature [°C]') #Set y label
        ax.plot(df_mean.index,df_mean.index,'--k',linewidth=2, label=r'$id_E$') #Display identity function's curve
        ax.legend() #Display legend
        ax.grid() #Display a grid
        
    
    
