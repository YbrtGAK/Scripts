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

"""""""""""""""""""""""""""""""""Fichiers lvm"""""""""""""""""""""""""""""""""

def lvm_to_df(lvm_file_path, skiprows=22):
    
    """Converti un fichier lvm en dataframe"""
    #Note : La longueur de l'en-tête, fixée à 22, est un paramètre modifiable
    
    return(pd.read_csv(lvm_file_path, sep='\t', on_bad_lines='skip',
                     skiprows=skiprows, decimal=','))

