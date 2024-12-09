# -*- coding: utf-8 -*-
"""
Created on Thue Dec  03/12/2024

@author: YB263935
"""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                        Gestion des fichiers textes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

#imports
from path import getAFilesPathToSave

def get_a_list_in_txt_file(l : list):

    with open(getAFilesPathToSave(), 'w') as output :
        for row in l:
            output.write(str(row) + '\n')

if __name__ == "__main__":
    get_a_list_in_txt_file([113,115,118,120,105,114,112,102,109,117,202,203,204,205,206,207,208,209,210,212,213,214,215,216,217,218,219,220,222,223,224,225,226,227,228,229,230,232])