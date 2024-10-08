# -*- coding: utf-8 -*-
"""
Created on Tue Sep 10 16:42:01 2024

@author: yberton

"""
"""This script aims to extract convective boiling bench's data from h5 file
                             into dataframe"""
                                 
#Imports
from h5py_to_dataframe import h5py_to_dataframe
from utilities import getAFilesPath


df = h5py_to_dataframe(getAFilesPath(),'Scan000','Detector000','NavAxes','Data0D',['CH00'])[0]

df.plot()
c = df.columns

df_filtered = df.drop(["201","215", "226", "227", "217", "218"], axis=1)
