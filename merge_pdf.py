# -*- coding: utf-8 -*-
"""
Created on Tue Dec 19 14:56:28 2023

@author: yberton
"""

from pypdf import PdfMerger
from tkinter import filedialog


fs = filedialog.askopenfiles()


pdfs = [f for f in fs]

merger = PdfMerger()

for pdf in pdfs:
    merger.append(pdf)

merger.write(filedialog.asksaveasfilename())
merger.close()