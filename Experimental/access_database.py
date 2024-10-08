# -*- coding: utf-8 -*-
"""
Created on Thu Sep  5 16:00:21 2024

@author: yberton
"""

from grist_api import GristDocAPI
import os
import numpy as np

API_GRIST_KEY = "fe01234bda320fe94daa3bca04b7a7d45923eca2" #Key toward your account
SERVER = "http://localhost:47478/o/docs" #Your org goes here
DOC_ID = "8ebAS5cQeT9R3xEpnVavLR"   #Document id goes here

#Get data from Grist's database sheet
inventory = GristDocAPI(DOC_ID, server=SERVER, api_key=API_GRIST_KEY)


#Test get in dict
dictionnaire = {}
L_thermocouple_channels = [e.__getattribute__("Canal") for e in inventory.fetch_table("Thermocouples")]
for channel in dictionnaire : 
    data = inventory.fetch_table("Thermocouples", filters={"Canal" : channel})[0]
    if data.__getattribute__("Etalonnage") != "False" :
        dictionnaire[data.__getattribute__("Canal")] = [float(e) for e in data.__getattribute__("Etalonnage").split(',')]
    
dictionnaire_funs = {}
for key in dictionnaire : 
    dictionnaire_funs[key] = lambda T : dictionnaire[key][0]*T + dictionnaire[key][1]
    
###############################################################################
#                                   
###############################################################################

T_mes = np.linspace(0,150,20)
T_corr = dictionnaire_funs[209](T_mes)

