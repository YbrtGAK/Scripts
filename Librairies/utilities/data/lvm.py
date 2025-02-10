# -*- coding: utf-8 -*-
"""
Created on Tue Nov 12 11:44:44 2024

@author: yberton
"""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                       Gestion des fichiers de données
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
#Convertir en dataframe des fichiers de mesures, tracer des courbes, modifier
#des fichiers de données type lvm

#imports
import pandas as pd
from datetime import datetime, timedelta


"""""""""""""""""""""""""""""""""Fichiers lvm"""""""""""""""""""""""""""""""""

def lvm_to_df(lvm_file_path, skiprows=22):
    
    """Convertit un fichier lvm en dataframe"""
    #Note : La longueur de l'en-tête, fixée à 22, est un paramètre modifiable
    
    header = pd.read_csv(lvm_file_path, sep='\t',on_bad_lines='skip', decimal=',', encoding='unicode_escape')
    t_start = header.iloc[9,1].split(':')[0] + ":" + header.iloc[9,1].split(':')[1] + \
        ":" + header.iloc[9,1].split(':')[2].split(',')[0] + '.' + \
            ''.join([header.iloc[9,1].split(':')[2].split(',')[1][i] for i in range(5)]) 
    d_start = datetime.strptime(header.iloc[8,1] + ' ' + t_start,'%Y/%m/%d %H:%M:%S.%f')
    df = pd.read_csv(lvm_file_path, sep='\t', on_bad_lines='skip', 
                            skiprows=skiprows, decimal=',',
                            encoding='unicode_escape')
    df.index = [d_start + timedelta(seconds = i*10) for i in df.index]
    return df


