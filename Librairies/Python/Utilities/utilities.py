# -*- coding: utf-8 -*-
"""
Created on Mon Aug  1 10:23:16 2022

@author: YB263935
"""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                                    UTILITIES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

#Imports
import numpy as np
import pandas as pd
import tkinter as tk
from tkinter import filedialog
import os
import pickle
from PyPDF2 import PdfFileReader, PdfFileWriter, PdfFileMerger
from os import walk
from pathlib import Path

#Sauvegarder / récuperer des fichiers ou leur chemin absolu 
def getAFilesPath(window_title = None, filetypes  = [('All files','*.*')]) :
    
    """Renvoie le chemin vers un fichier"""
    
    root = tk.Tk()
    root.withdraw()
    path = filedialog.askopenfile(title = window_title, filetypes=filetypes)
    return(path.name)

def getFilesPaths(window_title = None) :
    
    """Renvoie les chemins respectifs de plusieurs fichiers dans une liste"""
    
    root = tk.Tk()
    root.withdraw()
    path = filedialog.askopenfilenames(parent = root, title = window_title)
    return(path)

def getADirsPath(window_title = None):
    
    """Renvoie le chemin vers un dossier"""
    
    root = tk.Tk()
    root.withdraw()
    path = filedialog.askdirectory(title = window_title)
    return(path)    

def create_folder(name):
    
    """ create a folder """
    
    if not os.path.exists(name):
        os.makedirs(name)
        
def save_as_pickle(name_pickle_out, structure_to_store):
    
    """Enregistre un DataFrame en format pickel"""
    
    output = open(name_pickle_out, 'wb')
    pickle.dump(structure_to_store, output)
    output.close()
    
def read_pickle(input_file):
    
    """Ouvre un pickle en format dataframe"""
    
    dictload = pickle.load(open(input_file, 'rb'))
    return dictload

def getAFilesPathToSave(window_title = None, filetypes  = [('All files','*.*')]) :
    
    """Renvoie un chemin pour un fichier à sauvegarder"""
    
    root = tk.Tk()
    root.withdraw()
    path = filedialog.asksaveasfile(title = window_title, filetypes=filetypes)
    return(path.name)

def files_name_to_list(path):
    
    """ Renvoie une liste contenant les noms des fichiers excels des essais de
    Devenir"""
    
    listeFichiers = [] #Instancie la liste des noms de fichiers
    
    for (files_path, sousRepertoires, fichiers) in walk(path): #Ajoute les noms
        listeFichiers.extend(fichiers)
        
    for i in range(0,len(listeFichiers)) : 
        listeFichiers[i] = path + '/' + listeFichiers[i]
        

    return(listeFichiers) #Retourne la liste des noms et le chemin absolu


#Modifier des pdf

def extractFromPdf():
    
    """Créé un pdf à partir de certaines pages (dont les numéros sont donnés
    par l'utilisateur) d'un autre pdf"""
    
    path_original_pdf = getAFilesPath() #Chemin absolu vers le pdf source
    original_pdf = PdfFileReader(str(path_original_pdf)) #Obtention fichier pdf
    #number_pages = original_pdf.getNumPages() #Nombre maximal de pages du pdf source
    output_pdf_path = getAFilesPathToSave() #Chemin absolu vers le pdf à enregistrer
    list_pages_to_extract = input('Veuillez renseigner les pages que vous voulez extraire du document original dans un format similaire à l exemple suivant  : 1 2 5 3 \n')
    
    #Création d'une liste des pages désirées de type nombre entiers
    list_pages_to_extract = list_pages_to_extract.split(' ') 
    for i in range(0, len(list_pages_to_extract)) : list_pages_to_extract[i] = int(list_pages_to_extract[i])
    pdf_writer = PdfFileWriter() #Création d'un fichier pdf de sortie
    
    #Récupération des pages désirées du pdf source dans le pdf de sortie
    for page_num in list_pages_to_extract : pdf_writer.addPage(original_pdf.getPage(page_num))
    
    #Enregistrement du fichier pdf de sortie dans le répertoire désiré
    with open(output_pdf_path,'wb') as out:
            pdf_writer.write(out)
    return()

def mergePdf():
    
    """Créer un pdf à partir de n pdf"""
    
    paths = getFilesPaths("Chemins vers les pdfs à fusionner")
    merge_file = PdfFileMerger()
    for path in paths:
        merge_file.append(PdfFileReader(path, 'rb'))
    output_pdf_path = getAFilesPathToSave() #Chemin absolu vers le pdf à enregistrer
    merge_file.write(output_pdf_path)
    return()
    

                


	

	

    
