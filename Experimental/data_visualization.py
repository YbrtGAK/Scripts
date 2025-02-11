# -*- coding: utf-8 -*-
"""
Created on Mon Dec  9 11:20:28 2024

@author: yberton

Title : data_visualization.py
goal : Simple script to visualize the data from the convective boiling bench
"""

#Imports
from utilities.path import getAFilesPath
from utilities.data.lvm import lvm_to_df
from utilities.widgets import df_interactive_plot

#Get the data
df = lvm_to_df(getAFilesPath())
df_Pabs = df.filter(['115 - P_reservoir [bars]', '118 - P_TS_in [bars]', '120 - P_pump_in [bars]'])

#Plot the data
df_interactive_plot(df_Pabs, "Mesures des fuites")
 
df_Pabs = df_Pabs[df_Pabs.index > 2660]
df_Pabs.max() - df_Pabs.min()
(df_Pabs.index.max() - df_Pabs.index.min())*10/3600
