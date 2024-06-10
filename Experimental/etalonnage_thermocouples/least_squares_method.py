# -*- coding: utf-8 -*-
"""
Created on Fri Jun  7 16:39:04 2024

@author: yberton
"""

# Import
import numpy as np

# List initialization
L_theo = [] # List of theoretical/true values
L_exp = [] # List of experimental values 

# Functions' declaration
y = lambda x,a,b : a*x + b # Linear function declaration
theta = lambda Trk,Tk : Tk - Trk 



# Variables of interest
Trk = 20 # [°C]
T = 20.27 # [°C]

