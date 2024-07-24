# -*- coding: utf-8 -*-
"""
Created on Wed Jul 24 11:04:33 2024

@author: yberton
"""

import sys
from PyQt5.QtWidgets import (QApplication, QWidget, QLabel, QLineEdit, QTextEdit, QComboBox,
                             QVBoxLayout, QHBoxLayout, QFormLayout, QPushButton, QFileDialog, QListWidget, QAbstractItemView)
from PyQt5.QtCore import Qt

class ReportApp(QWidget):
    def __init__(self):
        super().__init__()

        self.initUI()

    def initUI(self):
        # Main layout
        mainLayout = QVBoxLayout()

        # Title
        titleLabel = QLabel("Titre:")
        self.titleEdit = QLineEdit()
        mainLayout.addWidget(titleLabel)
        mainLayout.addWidget(self.titleEdit)

        # Author
        authorLabel = QLabel("Nom de l'auteur:")
        self.authorEdit = QLineEdit()
        self.authorEdit.setMaximumWidth(200)  # Adjust width as needed
        mainLayout.addWidget(authorLabel)
        mainLayout.addWidget(self.authorEdit)

        # Objective
        objectiveLabel = QLabel("Objectif du document:")
        self.objectiveEdit = QTextEdit()
        mainLayout.addWidget(objectiveLabel)
        mainLayout.addWidget(self.objectiveEdit)

        # Acquisition software
        softwareLabel = QLabel("Logiciel d'acquisition:")
        self.softwareComboBox = QComboBox()
        self.softwareComboBox.addItems(["Software A", "Software B", "Software C"])
        mainLayout.addWidget(softwareLabel)
        mainLayout.addWidget(self.softwareComboBox)

        # Titles layout
        titlesLayout = QHBoxLayout()

        evapTitleLayout = QHBoxLayout()
        evapLabel = QLabel("Données pour l'évaporateur:")
        evapLabel.setAlignment(Qt.AlignCenter)
        evapTitleLayout.addStretch()
        evapTitleLayout.addWidget(evapLabel)
        evapTitleLayout.addStretch()

        fluidTitleLayout = QHBoxLayout()
        fluidLabel = QLabel("Données du fluide:")
        fluidLabel.setAlignment(Qt.AlignCenter)
        fluidTitleLayout.addStretch()
        fluidTitleLayout.addWidget(fluidLabel)
        fluidTitleLayout.addStretch()

        titlesLayout.addLayout(evapTitleLayout)
        titlesLayout.addLayout(fluidTitleLayout)

        mainLayout.addLayout(titlesLayout)

        # Evaporator data
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

        # Fluid data
        fluidFormLayout = QFormLayout()
        self.natureEdit = QLineEdit()
        self.natureEdit.setMaximumWidth(100)
        fluidFormLayout.addRow("Nature:", self.natureEdit)

        self.stateEdit = QLineEdit()
        self.stateEdit.setMaximumWidth(100)
        fluidFormLayout.addRow("Etat:", self.stateEdit)

        # Combine both layouts horizontally
        dataLayout = QHBoxLayout()
        dataLayout.addLayout(evapFormLayout)
        dataLayout.addLayout(fluidFormLayout)

        mainLayout.addLayout(dataLayout)

        # Fixed variables
        fixedLabel = QLabel("Grandeurs fixées:")
        self.fixedListWidget = QListWidget()
        self.fixedListWidget.setSelectionMode(QAbstractItemView.MultiSelection)
        self.fixedListWidget.addItems(["Variable A", "Variable B", "Variable C", "Variable D", "Variable E"])
        self.fixedListWidget.setMaximumWidth(150)  # Adjust width as needed
        self.fixedListWidget.itemSelectionChanged.connect(self.updateSelectedFixedVariables)

        # Selected fixed variables display
        self.selectedFixedLabel = QLabel("Grandeurs sélectionnées:")
        self.selectedFixedListWidget = QListWidget()
        self.selectedFixedListWidget.setMaximumWidth(150)  # Adjust width as needed

        # Layout for fixed variables and selected display
        fixedLayout = QVBoxLayout()
        fixedLayout.addWidget(fixedLabel)
        fixedLayout.addWidget(self.fixedListWidget)

        selectedFixedLayout = QVBoxLayout()
        selectedFixedLayout.addWidget(self.selectedFixedLabel)
        selectedFixedLayout.addWidget(self.selectedFixedListWidget)

        # Combine both layouts horizontally
        fixedVariablesLayout = QHBoxLayout()
        fixedVariablesLayout.addLayout(fixedLayout)
        fixedVariablesLayout.addLayout(selectedFixedLayout)

        mainLayout.addLayout(fixedVariablesLayout)

        # Image upload
        imageLabel = QLabel("Importer des fichiers images:")
        self.imageButton = QPushButton("Importer des images")
        self.imageButton.clicked.connect(self.importImages)
        self.imageLabel = QLabel("")
        mainLayout.addWidget(imageLabel)
        mainLayout.addWidget(self.imageButton)
        mainLayout.addWidget(self.imageLabel)

        # Remark
        remarkLabel = QLabel("Remarque:")
        self.remarkEdit = QTextEdit()
        mainLayout.addWidget(remarkLabel)
        mainLayout.addWidget(self.remarkEdit)

        # Submit Button
        submitButton = QPushButton("Générer le rapport")
        submitButton.clicked.connect(self.generateReport)
        mainLayout.addWidget(submitButton)

        self.setLayout(mainLayout)
        self.setWindowTitle("Créateur de Rapport")
        self.show()

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
        nature = self.natureEdit.text()
        state = self.stateEdit.text()
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
        
        Données du fluide:
        Nature: {nature}
        Etat: {state}
        
        Grandeurs fixées: {fixed}
        
        Images importées: {", ".join(images)}
        
        Remarque: {remark}
        """
        
        with open("rapport.txt", "w") as file:
            file.write(report)
        
        print("Rapport généré avec succès!")

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = ReportApp()
    sys.exit(app.exec_())
