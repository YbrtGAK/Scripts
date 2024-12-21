# -*- coding: utf-8 -*-
"""
Created on Thu Dec 19 11:40:11 2024

@author: yberton
"""

"""Interactive window for 2D data display"""

#Imports
# System
import sys
# PyQt 
from PyQt5.QtWidgets import QCheckBox, QVBoxLayout, QWidget, QApplication, \
QPushButton, QLabel, QMainWindow, QScrollArea, QHBoxLayout, QComboBox, QSpinBox,\
QColorDialog, QLineEdit, QListWidget, QListWidgetItem
from pyqt_checkbox_list_widget.checkBoxListWidget import CheckBoxListWidget
from PyQt5.QtCore import Qt, QCoreApplication
# Graphs with matplotlib
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas,\
    NavigationToolbar2QT
import matplotlib.pyplot as plt
# Data management with pandas
import pandas as pd

class ColumnSettings(QWidget):
    """Widget pour gérer les paramètres d'une colonne (case, nom, taille, type, couleur, points)."""

    def __init__(self, column_name, update_callback, default_color):
        super().__init__()
        self.column_name = column_name
        self.update_callback = update_callback
        self.checked = False
        self.settings = {
            "size": 2,
            "plot_type": "Line",
            "color": default_color,
            "marker": "o"  # Point par défaut pour Scatter
        }

        # Layout principal pour aligner les widgets horizontalement
        layout = QHBoxLayout()
        layout.setSpacing(5)
        layout.setAlignment(Qt.AlignLeft)

        # Case à cocher
        self.checkbox = QCheckBox()
        self.checkbox.setChecked(self.checked)
        self.checkbox.stateChanged.connect(self.on_checkbox_changed)
        layout.addWidget(self.checkbox)

        # Nom de la colonne
        self.label = QLabel(column_name)
        layout.addWidget(self.label)

        # Taille de la courbe
        self.size_spinbox = QSpinBox()
        self.size_spinbox.setRange(1, 20)
        self.size_spinbox.setValue(self.settings["size"])
        self.size_spinbox.valueChanged.connect(self.on_size_changed)
        layout.addWidget(self.size_spinbox)

        # Type de tracé (Line ou Scatter)
        self.plot_type_combobox = QComboBox()
        self.plot_type_combobox.addItems(["Line", "Scatter"])
        self.plot_type_combobox.setCurrentText(self.settings["plot_type"])
        self.plot_type_combobox.currentTextChanged.connect(self.on_plot_type_changed)
        layout.addWidget(self.plot_type_combobox)

        # Choix du type de point pour Scatter
        self.marker_combobox = QComboBox()
        self.marker_combobox.addItems(["o", "s", "^", "D", "x"])  # Cercle, carré, triangle, losange, croix
        self.marker_combobox.setCurrentText(self.settings["marker"])
        self.marker_combobox.currentTextChanged.connect(self.on_marker_changed)
        self.marker_combobox.hide()  # Caché par défaut
        layout.addWidget(self.marker_combobox)

        # Bouton pour choisir la couleur
        self.color_button = QPushButton()
        self.color_button.setStyleSheet(f"background-color: {self.settings['color']}")
        self.color_button.clicked.connect(self.on_color_changed)
        layout.addWidget(self.color_button)

        self.setLayout(layout)

    def on_checkbox_changed(self, state):
        self.checked = state == Qt.Checked
        self.update_callback()

    def on_size_changed(self, value):
        self.settings["size"] = value
        self.update_callback()

    def on_plot_type_changed(self, value):
        self.settings["plot_type"] = value
        if value == "Scatter":
            self.marker_combobox.show()  # Affiche le choix du type de point
        else:
            self.marker_combobox.hide()  # Cache le choix du type de point
        self.update_callback()

    def on_marker_changed(self, value):
        self.settings["marker"] = value
        self.update_callback()

    def on_color_changed(self):
        color = QColorDialog.getColor()
        if color.isValid():
            self.settings["color"] = color.name()
            self.color_button.setStyleSheet(f"background-color: {color.name()}")
            self.update_callback()

class InteractiveGraph(QMainWindow):
    """Fenêtre principale avec graphique interactif."""

    def __init__(self, dataframe, windows_title="Graphique"):
        super().__init__()
        self.df = dataframe
        self.setWindowTitle(windows_title)
        self.setGeometry(100, 100, 1000, 700)

        self.main_widget = QWidget()
        self.layout = QVBoxLayout(self.main_widget)

        # Matplotlib
        self.figure = plt.figure()
        self.canvas = FigureCanvas(self.figure)
        self.toolbar = NavigationToolbar2QT(self.canvas, self)
        self.layout.addWidget(self.toolbar)
        self.layout.addWidget(self.canvas)
        self.show_grid = False
        self.x_label = "Temps [s]"
        self.y_label = "Y-axis"
        self.y2_label = "Second Y-axis"
        self.use_secondary_y = False

        # Layout des contrôles supérieurs
        controls_layout = QHBoxLayout()
        controls_layout.setSpacing(10)
        controls_layout.setAlignment(Qt.AlignLeft)

        # Case pour afficher la grille
        self.grid_checkbox = QCheckBox("Show Grid")
        #self.grid_checkbox.stateChanged.connect(self.toggle_grid)
        controls_layout.addWidget(self.grid_checkbox)

        # Case pour activer la seconde ordonnée
        self.secondary_y_checkbox = QCheckBox("Second Ordinate")
        #self.secondary_y_checkbox.stateChanged.connect(self.toggle_secondary_y)
        controls_layout.addWidget(self.secondary_y_checkbox)

        # Champ pour le label X
        self.x_label_edit = QLineEdit(self.x_label)
        self.x_label_edit.setPlaceholderText("X-axis Label")
        #self.x_label_edit.textChanged.connect(self.update_x_label)
        controls_layout.addWidget(QLabel("X label"))
        controls_layout.addWidget(self.x_label_edit)

        # Champ pour le label Y
        self.y_label_edit = QLineEdit(self.y_label)
        self.y_label_edit.setPlaceholderText("Y-axis Label")
        #self.y_label_edit.textChanged.connect(self.update_y_label)
        controls_layout.addWidget(QLabel("Y label:"))
        controls_layout.addWidget(self.y_label_edit)

        # Champ pour le label Y2
        self.y2_label_edit = QLineEdit(self.y2_label)
        self.y2_label_edit.setPlaceholderText("Y2-axis label")
        #self.y2_label_edit.textChanged.connect(self.update_y2_label)
        self.y2_label_edit.hide()
        controls_layout.addWidget(QLabel("Y2 Label:"))
        controls_layout.addWidget(self.y2_label_edit)

        self.layout.addLayout(controls_layout)

        # Liste des colonnes avec paramètres
        self.column_settings_widgets = []
        self.scroll_area = QScrollArea()
        self.scroll_area.setWidgetResizable(True)
        self.scroll_content = QWidget()
        self.scroll_layout = QVBoxLayout(self.scroll_content)
        self.scroll_layout.setSpacing(0)  # Réduction de l'espacement vertical

        # Génération de couleurs automatiques
        color_palette = plt.cm.tab10.colors  # Palette par défaut Matplotlib
        num_colors = len(color_palette)
        for i, column in enumerate(self.df.columns):
            default_color = self.rgb_to_hex(color_palette[i % num_colors])
            #widget = ColumnSettings(column, self.update_plot, default_color)
            #self.column_settings_widgets.append(widget)
            #self.scroll_layout.addWidget(widget)

        self.scroll_content.setLayout(self.scroll_layout)
        self.scroll_area.setWidget(self.scroll_content)
        self.layout.addWidget(self.scroll_area)

        self.setCentralWidget(self.main_widget)
        #self.update_plot()



    def rgb_to_hex(self, rgb):
        """Convertit une couleur RGB en chaîne hexadécimale."""
        return '#{:02x}{:02x}{:02x}'.format(int(rgb[0] * 255), int(rgb[1] * 255), int(rgb[2] * 255))
'''
    def toggle_grid(self):
        """Active/désactive la grille."""
        self.show_grid = self.grid_checkbox.isChecked()
        self.update_plot()

    def toggle_secondary_y(self):
        """Active/désactive le second axe Y."""
        self.use_secondary_y = self.secondary_y_checkbox.isChecked()
        self.y2_label_edit.setVisible(self.use_secondary_y)
        self.update_plot()

    def update_x_label(self, label):
        """Met à jour le label de l'axe X."""
        self.x_label = label
        self.update_plot()

    def update_y_label(self, label):
        """Met à jour le label de l'axe Y."""
        self.y_label = label
        self.update_plot()

    def update_y2_label(self, label):
        """Met à jour le label de l'axe Y2."""
        self.y2_label = label
        self.update_plot()

    def update_plot(self):
        """Met à jour le graphique."""
        n_checked_widgets = 0
        self.figure.clear()
        ax = self.figure.add_subplot(111)

        for widget in self.column_settings_widgets:
            if widget.checked:
                n_checked_widgets += 1
                settings = widget.settings
                column_name = widget.column_name
                if settings["plot_type"] == "Line":
                    ax.plot(
                        self.df.index, self.df[column_name],
                        label=column_name, color=settings["color"],
                        linewidth=settings["size"]
                    )
                elif settings["plot_type"] == "Scatter":
                    ax.scatter(
                        self.df.index, self.df[column_name],
                        label=column_name, color=settings["color"],
                        s=settings["size"],
                        marker=settings["marker"]
                    )

        ax.set_xlabel(self.x_label)
        ax.set_ylabel(self.y_label)

        if self.use_secondary_y:
            ax2 = ax.twinx()
            ax2.set_ylabel(self.y2_label)

        ax.grid(self.show_grid)
        if n_checked_widgets > 0 :
            ax.legend()
        self.canvas.draw()
'''

def df_interactive_plot(df, windows_title="Graphique"):
    """Lance la fenêtre d'affichage interactif."""
    app = QApplication(sys.argv)
    main_window = InteractiveGraph(df, windows_title)
    main_window.show()
    app.exec_()
    
if __name__ == "__main__" :
    
    d = {'col1': [0, 1, 2, 3], 'col2': [0, -1, -2, -3]}
    df = pd.DataFrame(data=d, index=[0, 1, 2, 3])
    df_interactive_plot(df, "In building app ;p")