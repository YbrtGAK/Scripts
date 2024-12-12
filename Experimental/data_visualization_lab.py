import sys
import pandas as pd
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QVBoxLayout, QWidget, QScrollArea,
    QHBoxLayout, QLabel, QComboBox, QPushButton, QColorDialog, QSpinBox, QCheckBox
)
from PyQt5.QtCore import Qt
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas, NavigationToolbar2QT
import matplotlib.pyplot as plt
from pyqt_checkbox_list_widget import CheckBoxListWidget
from utilities.data.lvm import lvm_to_df
from utilities.path import getAFilesPath

class interactive_graph(QMainWindow):
    def __init__(self, dataframe, windows_title="Graphique"):
        super().__init__()
        self.df = dataframe
        self.selected_columns = list(self.df.columns)
        self.show_grid = False  # Option pour afficher la grille

        self.setWindowTitle(windows_title)
        self.setGeometry(100, 100, 1000, 700)

        self.main_widget = QWidget()
        self.layout = QVBoxLayout(self.main_widget)

        # Graphique Matplotlib
        self.figure = plt.figure()
        self.canvas = FigureCanvas(self.figure)
        self.toolbar = NavigationToolbar2QT(self.canvas, self)
        self.layout.addWidget(self.toolbar)
        self.layout.addWidget(self.canvas)

        # Bouton pour ouvrir la fenêtre de personnalisation
        customize_button = QPushButton("Customize Plot")
        customize_button.clicked.connect(self.open_customize_window)
        self.layout.addWidget(customize_button)

        # CheckBox pour afficher ou non la grille
        self.grid_checkbox = QCheckBox("Show Grid")
        self.grid_checkbox.stateChanged.connect(self.toggle_grid)
        self.layout.addWidget(self.grid_checkbox)

        # CheckBoxListWidget pour gérer les colonnes
        self.checkbox_list = CheckBoxListWidget()
        self.checkbox_list.addItems(self.df.columns)
        self.checkbox_list.selectAll()
        self.checkbox_list.itemChanged.connect(self.update_plot)

        # Zone défilante pour la liste de colonnes
        self.scroll = QScrollArea()
        self.scroll.setWidgetResizable(True)
        self.scroll.setWidget(self.checkbox_list)
        self.layout.addWidget(self.scroll)

        self.setCentralWidget(self.main_widget)
        self.update_plot()

    def toggle_grid(self):
        """Active ou désactive l'affichage de la grille."""
        self.show_grid = self.grid_checkbox.isChecked()
        self.update_plot()

    def update_plot(self):
        self.selected_columns = [
            self.checkbox_list.item(i).text()
            for i in range(self.checkbox_list.count())
            if self.checkbox_list.item(i).checkState() == Qt.Checked
        ]
        
        if len(self.selected_columns) > 0 : 
            self.unit = self.selected_columns[0].split(" ")[-1]
        else : self.unit = "[-]"

        # Effacer l'ancien graphique
        self.figure.clear()
        ax = self.figure.add_subplot(111)
        ax.set_xlabel("Samples [-]")
        ax.set_ylabel(self.unit)

        # Tracer les colonnes sélectionnées
        if hasattr(self, "customize_window"):
            self.customize_window.apply_changes()
        else:
            for col in self.selected_columns:
                ax.plot(self.df.index, self.df[col], label=col)

        # Appliquer la grille
        ax.grid(self.show_grid)

        ax.legend()
        self.canvas.draw()

    def open_customize_window(self):
        """Ouvre une fenêtre pour personnaliser les courbes."""
        self.customize_window = CustomizeWindow(self.df, self.selected_columns, self)
        self.customize_window.show()


class CustomizeWindow(QWidget):
    def __init__(self, dataframe, selected_columns, parent=None):
        super().__init__()
        self.df = dataframe
        self.selected_columns = selected_columns
        self.parent = parent

        self.setWindowTitle("Customize Plot")
        self.setGeometry(200, 200, 400, 400)

        # Dictionnaire partagé pour les paramètres globaux
        if not hasattr(self.parent, "column_settings"):
            self.parent.column_settings = {}
        
        self.column_settings = self.parent.column_settings

        # Ajouter les réglages par défaut pour les nouvelles colonnes
        for col in self.selected_columns:
            if col not in self.column_settings:
                self.column_settings[col] = {
                    "plot_type": "Line",  # Valeur par défaut
                    "color": "#000000",  # Couleur par défaut (noir)
                    "size": 2,           # Taille par défaut
                }

        self.layout = QVBoxLayout()

        # Crée ou met à jour les widgets pour chaque colonne sélectionnée
        self.create_widgets()

        # Bouton pour appliquer les changements
        apply_button = QPushButton("Apply")
        apply_button.clicked.connect(self.apply_changes)
        self.layout.addWidget(apply_button)

        self.setLayout(self.layout)

    def create_widgets(self):
        """Crée les widgets pour chaque colonne sélectionnée."""
        # Efface les widgets existants avant de recréer
        while self.layout.count() > 0:
            widget = self.layout.takeAt(0).widget()
            if widget:
                widget.deleteLater()

        for col in self.selected_columns:
            col_label = QLabel(f"Settings for {col}:")
            col_label.setAlignment(Qt.AlignLeft)
            self.layout.addWidget(col_label)

            # Type de tracé
            plot_type = QComboBox()
            plot_type.addItems(["Line", "Scatter"])
            plot_type.setCurrentText(self.column_settings[col]["plot_type"])
            plot_type.currentTextChanged.connect(lambda value, c=col: self.update_plot_type(c, value))
            self.layout.addWidget(plot_type)

            # Couleur
            color_button = QPushButton("Choose Color")
            color_button.setStyleSheet(f"background-color: {self.column_settings[col]['color']}")
            color_button.clicked.connect(lambda _, c=col: self.choose_color(c, color_button))
            self.layout.addWidget(color_button)

            # Taille
            size_spinbox = QSpinBox()
            size_spinbox.setMinimum(1)
            size_spinbox.setMaximum(20)
            size_spinbox.setValue(self.column_settings[col]["size"])
            size_spinbox.valueChanged.connect(lambda value, c=col: self.update_size(c, value))
            self.layout.addWidget(size_spinbox)

    def update_plot_type(self, col, value):
        """Met à jour le type de tracé d'une colonne."""
        self.column_settings[col]["plot_type"] = value

    def choose_color(self, col, button):
        """Choisir une couleur pour une courbe et mettre à jour le bouton."""
        color = QColorDialog.getColor()
        if color.isValid():
            self.column_settings[col]["color"] = color.name()
            button.setStyleSheet(f"background-color: {color.name()}")

    def update_size(self, col, value):
        """Met à jour la taille de la courbe pour une colonne."""
        self.column_settings[col]["size"] = value

    def apply_changes(self):
        """Applique les changements au graphique principal."""
        self.parent.figure.clear()
        ax = self.parent.figure.add_subplot(111)

        for col in self.parent.selected_columns:
            if col in self.column_settings:
                settings = self.column_settings[col]
                plot_type = settings["plot_type"]
                color = settings["color"]
                size = settings["size"]

                if plot_type == "Line":
                    ax.plot(self.df.index, self.df[col], label=col, color=color, linewidth=size)
                elif plot_type == "Scatter":
                    ax.scatter(self.df.index, self.df[col], label=col, color=color, s=size)
                    
        # Réappliquer l'état de la grille
        ax.grid(self.parent.show_grid)
        
        if len(self.selected_columns) > 0 : 
            self.unit = self.selected_columns[0].split(" ")[-1]
        else : self.unit = "[-]"

        ax.set_xlabel("Samples [-]")
        ax.set_ylabel(self.unit)
        ax.legend()
        self.parent.canvas.draw()
        self.close()


def df_interactive_plot(df, windows_title="Graphique"):

    app = QApplication(sys.argv)
    main_window = interactive_graph(df,windows_title)
    main_window.show()
    app.exec_()
        

df = lvm_to_df(getAFilesPath())
df_Pabs = df.filter(['115 - P_reservoir [bars]', '118 - P_TS_in [bars]', '120 - P_pump_in [bars]'])
df_interactive_plot(df_Pabs)
