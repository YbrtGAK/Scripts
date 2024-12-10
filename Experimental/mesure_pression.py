# -*- coding: utf-8 -*-
"""
Created on Thu Nov  7 11:14:17 2024

@author: yberton
"""

#Imports (librairies)
from utilities.data.h5 import h5py_to_dataframe
from utilities.data.lvm import lvm_to_df
from utilities.path import getAFilesPath
import pandas as pd
import numpy as np

#Acquisition de données
df_V = h5py_to_dataframe(getAFilesPath(),'Scan000','Detector000','NavAxes','Data0D',['CH00'])[0]
#Tableau des fonctions de passage courant - tension
fconv = lambda I,a,b : (I*a*1000 + b)/1000
fconv_dp = lambda I, a, b : (I*a*1000 + b)/10e5


#Traitement des données par les lois d'étalonnage

# Passage des données de tension (V) à courant (A)
R = 50# Résitance électrique du pdt
df_A = df_V/R # Passage tension - courant

dictionnaire_pressions = {
#   "102" :  fconv(df_A['102'], 1873.651651, -7494.33857),
    "112" :  fconv(df_A['112'], 125.126253, -508.79921 + 0.5087868145033482*1000 ),
    # + 0.5087868145033482*1000 est présent en tant qu'offset pour
    #corriger la valeur de pression obtenue par le capteur 112
    "113" :  fconv(df_A['113'], 2190.335909, -8820.69099),
    "114" :  fconv_dp(df_A['114'],311.0563359, -1131.90832 ),
    #Le capteur 114 est étalonné en Pa, contrairement à tous les autres qui
    #le sont en hPa, fconv_dp permet de passer ses coefficient a et b en hPa
    "115" :  fconv(df_A['115'], 2185.320017, -8709.65057),
    "118" :  fconv(df_A['118'], 1873.651651, -7494.33857),
    "120" :  fconv(df_A['120'], 1873.651651, -7494.33857)

    }

%matplotlib qt

#Acquisition des mesures de pression calculées dans un dataframe df_bar
df_bar = pd.DataFrame(dictionnaire_pressions)

#Affichage des graphiques
#Graphique avec toutes les pressions
df_bar.plot()

#Filtrage pour ne visualiser que les pressions absolues
df_Pabs = df_bar.filter(['113','115', '118', '120'])
df_Pabs.plot(grid=True)



