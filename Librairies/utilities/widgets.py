# -*- coding: utf-8 -*-
"""
Created on Mon Aug  1 10:23:16 2022

@author: YB263935
"""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                                    Widgets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Widgets classes to go faster
import sys
from PyQt5.QtWidgets import QCheckBox, QVBoxLayout, QWidget, QApplication, QPushButton, QLabel
from pyqt_checkbox_list_widget.checkBoxListWidget import CheckBoxListWidget
from PyQt5.QtCore import Qt, QCoreApplication

class Widget(QWidget):

    def __init__(self,title, lst):
        super().__init__()
        self.__initUi(title, lst)

    def __initUi(self, title, lst):
        self.title = QLabel(title)
        self.title.setAlignment(Qt.AlignCenter)
        self.allCheckBox = QCheckBox('Check all')
        self.checked_items = []
        self.checkBoxListWidget = CheckBoxListWidget()
        self.checkBoxListWidget.addItems(lst)
        self.allCheckBox.stateChanged.connect(self.checkBoxListWidget.toggleState)
        self.button = QPushButton("Save the list")
        self.button.clicked.connect(self.save_the_list)
        self.lay = QVBoxLayout()
        self.lay.addWidget(self.title)
        self.lay.addWidget(self.allCheckBox)
        self.lay.addWidget(self.checkBoxListWidget)
        self.lay.addWidget(self.button)
        self.setLayout(self.lay)
    
    def save_the_list(self):
        for i in range(self.checkBoxListWidget.count()):
            item = self.checkBoxListWidget.item(i)
            if item.checkState() == 2:  # 2 means "Checked"
                self.checked_items.append(item.text())
            QCoreApplication.instance().quit()
        
        # Ici, tu peux manipuler la liste `checked_items` comme tu veux
        # Par exemple, tu peux l'enregistrer dans un fichier ou l'utiliser ailleurs
        
    
def getElementFromWidgetList(title,lst : []):
    
    app = QApplication(sys.argv)
    widget = Widget(title,lst)
    widget.show()
    app.exec_()
    return(widget.checked_items)
    


                


	

	

    
