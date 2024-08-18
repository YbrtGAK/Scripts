# -*- coding: utf-8 -*-
"""
Created on Wed Jul 24 11:04:33 2024

@author: yberton
"""

import sys
from PyQt5.QtWidgets import (QApplication, QWidget, QLabel, QLineEdit, QTextEdit, QComboBox,
                             QVBoxLayout, QHBoxLayout, QFormLayout, QPushButton, QFileDialog,
                             QListWidget, QAbstractItemView, QTabWidget)
from PyQt5.QtCore import Qt

class ReportApp(QWidget):
    def __init__(self):
        super().__init__()

        self.initUI()

    def initUI(self):
        # Main layout
        mainLayout = QVBoxLayout()

        # Select width
        self.setFixedWidth(550)

        # Create tab widget
        self.tabs = QTabWidget()
        
        # First tab - CSV Import
        self.tab1 = QWidget()
        self.tab1Layout = QVBoxLayout()

        importLabel = QLabel("Importation des données expérimentales")
        self.tab1Layout.addWidget(importLabel)

        self.csvImportButton = QPushButton("Importer un fichier CSV")
        self.csvImportButton.clicked.connect(self.importCSV)
        self.tab1Layout.addWidget(self.csvImportButton)
        
        self.csvFileLabel = QLabel("")
        self.tab1Layout.addWidget(self.csvFileLabel)
        
        self.nextTabButton = QPushButton("Passer au formulaire")
        self.nextTabButton.clicked.connect(self.goToFormTab)
        
        # 1st tab - Add a spacer to push the button to the bottom
        self.tab1Layout.addStretch(1)
        self.tab1Layout.addWidget(self.nextTabButton)
        
        self.tab1.setLayout(self.tab1Layout)

        # Second tab - Form
        self.tab2 = QWidget()
        self.tab2Layout = QVBoxLayout()

        # Second tab - Title
        titleLabel = QLabel("Titre:")
        self.titleEdit = QLineEdit()
        self.tab2Layout.addWidget(titleLabel)
        self.tab2Layout.addWidget(self.titleEdit)

        # Second tab - Author
        authorLabel = QLabel("Nom de l'auteur:")
        self.authorEdit = QLineEdit()
        self.authorEdit.setMaximumWidth(200)  # Adjust width as needed
        self.tab2Layout.addWidget(authorLabel)
        self.tab2Layout.addWidget(self.authorEdit)

        # Second tab - Objective
        objectiveLabel = QLabel("Objectif du document:")
        self.objectiveEdit = QTextEdit()
        self.tab2Layout.addWidget(objectiveLabel)
        self.tab2Layout.addWidget(self.objectiveEdit)

        # Second tab - Acquisition software
        softwareLabel = QLabel("Logiciel d'acquisition:")
        self.softwareComboBox = QComboBox()
        self.softwareComboBox.addItems(["Software A", "Software B", "Software C"])
        self.tab2Layout.addWidget(softwareLabel)
        self.tab2Layout.addWidget(self.softwareComboBox)

        # Second tab - Titles layout
        titlesLayout = QHBoxLayout()

        evapTitleLayout = QHBoxLayout()
        evapLabel = QLabel("Données pour l'évaporateur:")
        evapLabel.setAlignment(Qt.AlignCenter)
        evapTitleLayout.addStretch()
        evapTitleLayout.addWidget(evapLabel)
        evapTitleLayout.addStretch()

        preheaterTitleLayout = QHBoxLayout()
        preheaterLabel = QLabel("Données du pré-chauffeur:")
        preheaterLabel.setAlignment(Qt.AlignCenter)
        preheaterTitleLayout.addStretch()
        preheaterTitleLayout.addWidget(preheaterLabel)
        preheaterTitleLayout.addStretch()

        fluidTitleLayout = QHBoxLayout()
        fluidLabel = QLabel("Données du fluide:")
        fluidLabel.setAlignment(Qt.AlignCenter)
        fluidTitleLayout.addStretch()
        fluidTitleLayout.addWidget(fluidLabel)
        fluidTitleLayout.addStretch()

        titlesLayout.addLayout(evapTitleLayout)
        titlesLayout.addLayout(preheaterTitleLayout)
        titlesLayout.addLayout(fluidTitleLayout)

        self.tab2Layout.addLayout(titlesLayout)

        # Second tab - Evaporator data
        evapFormLayout = QFormLayout()
        self.LEdit = QLineEdit()
        self.LEdit.setMaximumWidth(100)
        evapFormLayout.addRow("L:", self.LEdit)

        self.RaEdit = QLineEdit()
        self.RaEdit.setMaximumWidth(100)
        evapFormLayout.addRow("Ra:", self.RaEdit)

        self.numEdit = QLineEdit()
        self.numEdit.setMaximumWidth(100)
        evapFormLayout.addRow("n°:", self.numEdit)

        self.qEdit = QLineEdit()
        self.qEdit.setMaximumWidth(100)
        evapFormLayout.addRow("q̇:", self.qEdit)

        # Second tab - Preheater data
        preheaterFormLayout = QFormLayout()
        self.preL = QLineEdit()
        self.preL.setMaximumWidth(100)
        preheaterFormLayout.addRow("L:", self.preL)

        self.preQ = QLineEdit()
        self.preQ.setMaximumWidth(100)
        preheaterFormLayout.addRow('q̇:', self.preQ)

        # Second tab - Fluid data
        fluidFormLayout = QFormLayout()
        self.natureComboBox = QComboBox()
        self.natureComboBox.setMaximumWidth(100)
        self.natureComboBox.addItems(["Fluide 1", "Fluide 2", "Fluide 3"])
        fluidFormLayout.addRow("Nature:", self.natureComboBox)

        self.stateEdit = QLineEdit()
        self.stateEdit.setMaximumWidth(100)
        fluidFormLayout.addRow("Etat:", self.stateEdit)

        self.mEdit = QLineEdit()
        self.mEdit.setMaximumWidth(100)
        fluidFormLayout.addRow("ṁ:", self.mEdit)

        # Second tab - Combine all three layouts horizontally
        dataLayout = QHBoxLayout()
        dataLayout.addLayout(evapFormLayout)
        dataLayout.addLayout(preheaterFormLayout)
        dataLayout.addLayout(fluidFormLayout)

        self.tab2Layout.addLayout(dataLayout)

        # Second tab - Fixed variables
        fixedLabel = QLabel("Grandeurs fixées:")
        self.fixedListWidget = QListWidget()
        self.fixedListWidget.setSelectionMode(QAbstractItemView.MultiSelection)
        self.fixedListWidget.addItems(["Variable A", "Variable B", "Variable C", "Variable D", "Variable E"])
        self.fixedListWidget.setMaximumWidth(150)  # Adjust width as needed
        self.fixedListWidget.itemSelectionChanged.connect(self.updateSelectedFixedVariables)

        # Second tab - Selected fixed variables display
        self.selectedFixedLabel = QLabel("Grandeurs sélectionnées:")
        self.selectedFixedListWidget = QListWidget()
        self.selectedFixedListWidget.setMaximumWidth(150)  # Adjust width as needed

        # Second tab - Layout for fixed variables and selected display
        fixedLayout = QVBoxLayout()
        fixedLayout.addWidget(fixedLabel)
        fixedLayout.addWidget(self.fixedListWidget)

        selectedFixedLayout = QVBoxLayout()
        selectedFixedLayout.addWidget(self.selectedFixedLabel)
        selectedFixedLayout.addWidget(self.selectedFixedListWidget)

        # Second tab - Combine both layouts horizontally
        fixedVariablesLayout = QHBoxLayout()
        fixedVariablesLayout.addLayout(fixedLayout)
        fixedVariablesLayout.addLayout(selectedFixedLayout)

        self.tab2Layout.addLayout(fixedVariablesLayout)

        # Second tab - Image upload
        imageLabel = QLabel("Importer des fichiers images:")
        self.imageButton = QPushButton("Importer des images")
        self.imageButton.clicked.connect(self.importImages)
        self.imageLabel = QLabel("")
        self.tab2Layout.addWidget(imageLabel)
        self.tab2Layout.addWidget(self.imageButton)
        self.tab2Layout.addWidget(self.imageLabel)

        # Second tab - Remark
        remarkLabel = QLabel("Remarque:")
        self.remarkEdit = QTextEdit()
        self.tab2Layout.addWidget(remarkLabel)
        self.tab2Layout.addWidget(self.remarkEdit)

        # Second tab - Submit Button
        submitButton = QPushButton("Générer le rapport")
        submitButton.clicked.connect(self.generateReport)
        self.tab2Layout.addWidget(submitButton)

        self.tab2.setLayout(self.tab2Layout)

        # Add tabs to tab widget
        self.tabs.addTab(self.tab1, "Importer CSV")
        self.tabs.addTab(self.tab2, "Formulaire")

        mainLayout.addWidget(self.tabs)
        self.setLayout(mainLayout)
        self.setWindowTitle("Créateur de Rapport")
        self.show()

    def importCSV(self):
        options = QFileDialog.Options()
        files, _ = QFileDialog.getOpenFileNames(self, "QFileDialog.getOpenFileNames()", "", "CSV Files (*.csv);;All Files (*)", options=options)
        if files:
            self.csvFileLabel.setText("\n".join(files))

    def saveCSV(self):
        options = QFileDialog.Options()
        files, _ = QFileDialog.getSaveFileName(self, "QFileDialog.getSaveFileName()", "", "txt Files (*.txt);;All Files (*)", options=options)
        if files:
            return(files)
            #self.csvFileLabel.setText("\n".join(files))

    def goToFormTab(self):
        self.tabs.setCurrentIndex(1)

    def importImages(self):
        options = QFileDialog.Options()
        files, _ = QFileDialog.getOpenFileNames(self, "QFileDialog.getOpenFileNames()", "", "Images (*.png *.xpm *.jpg);;All Files (*)", options=options)
        if files:
            self.imageLabel.setText("\n".join(files))

    def updateSelectedFixedVariables(self):
        self.selectedFixedListWidget.clear()
        selectedItems = self.fixedListWidget.selectedItems()
        for item in selectedItems:
            self.selectedFixedListWidget.addItem(item.text())

    def generateReport(self):
        title = self.titleEdit.text()
        author = self.authorEdit.text()
        objective = self.objectiveEdit.toPlainText()
        software = self.softwareComboBox.currentText()
        L = self.LEdit.text()
        Ra = self.RaEdit.text()
        num = self.numEdit.text()
        q = self.qEdit.text()
        preL = self.preL.text()
        preQ = self.preQ.text()
        nature = self.natureComboBox.currentText()
        state = self.stateEdit.text()
        m = self.mEdit.text()
        fixed = [item.text() for item in self.fixedListWidget.selectedItems()]
        images = self.imageLabel.text().split("\n")
        remark = self.remarkEdit.toPlainText()
        
        report = f"""
        Titre: {title}
        Nom de l'auteur: {author}
        Objectif du document: {objective}
        Logiciel d'acquisition: {software}

        Données pour l'évaporateur:
        L: {L}
        Ra: {Ra}
        n°: {num}
        q: {q}

        Données du pré-chauffeur:
        L: {preL}
        q: {preQ}

        Données du fluide:
        Nature: {nature}
        Etat: {state}
        m: {m}

        Grandeurs fixées: {fixed}

        Images: {",".join(images)}

        Remarque: {remark}
        """
        
        self.path = self.saveCSV()
        print(self.path)

        with open(self.path, "w", encoding = 'utf8') as file:
            file.write(report)
        
        print("Rapport généré avec succès!")

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = ReportApp()
    sys.exit(app.exec_())
