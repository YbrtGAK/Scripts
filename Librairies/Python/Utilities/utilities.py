# -*- coding: utf-8 -*-
"""
Created on Tue May 21 10:19:06 2024

@author: yberton
"""

"""This script is a toolkit of small helpful function. A former version already
exist that shall replace this one"""

#imports
import os
import tkinter as tk
from tkinter import filedialog

def getADirPath(): 
    root = tk.Tk()
    root.withdraw()
     
    return(filedialog.askdirectory())
    