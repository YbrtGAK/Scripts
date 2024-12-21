# -*- coding: utf-8 -*-
"""
Created on Mon Aug  1 10:23:16 2022

@author: YB263935
"""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                                    Widgets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Widgets classes and GUI programs

#Imports
# System
import sys
# PyQt 
from PyQt5.QtWidgets import QCheckBox, QVBoxLayout, QWidget, QApplication, \
QPushButton, QLabel, QMainWindow, QScrollArea, QHBoxLayout, QComboBox, QSpinBox,\
QColorDialog, QLineEdit, QListWidget, QListWidgetItem, QSizePolicy, QSpacerItem
from pyqt_checkbox_list_widget.checkBoxListWidget import CheckBoxListWidget
from PyQt5.QtCore import Qt, QCoreApplication
# Graphs with matplotlib
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas,\
    NavigationToolbar2QT
import matplotlib.pyplot as plt
# Data management with pandas
import pandas as pd

#Customs list

#Checkbox list

class Checkbox_list(QWidget):

    def __init__(self,title="title", lst=["A","B","C","D","E"]):
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

class SortableListWidget(QWidget):
    def __init__(self, items):
        super().__init__()
        
        self.setWindowTitle("Sortable List Widget")
        self.setGeometry(100, 100, 300, 400)
        
        # Layout
        layout = QVBoxLayout()
        self.setLayout(layout)
        
        # List Widget
        self.list_widget = QListWidget()
        self.list_widget.setDragDropMode(QListWidget.InternalMove)
        
        # Populate List Widget
        for i, item in enumerate(items):
            list_item = QListWidgetItem(f"{i + 1}. {item}")
            self.list_widget.addItem(list_item)
        
        # Connect signal to update indices
        self.list_widget.model().rowsMoved.connect(self.update_indices)
        
        layout.addWidget(self.list_widget)

    def update_indices(self):
        """Update the order numbers after items are reordered."""
        for i in range(self.list_widget.count()):
            item = self.list_widget.item(i)
            text = item.text().split(". ", 1)[-1]  # Keep only the text after the number
            item.setText(f"{i + 1}. {text}")
            
class MultiSortableListsWidget(QWidget):
    def __init__(self, items=["A","B","C","D","E"], list_labels = ["Liste 1","Liste 2", "Liste 3"]):
        super().__init__()
        
        self.setWindowTitle("Multi Sortable Lists Widget")
        self.setGeometry(100, 100, 800, 400)
        
        # Main Layout
        self.main_layout = QVBoxLayout()
        self.setLayout(self.main_layout)
        
        # Checkbox for third list
        self.checkbox_layout = QVBoxLayout()
        self.checkbox = QCheckBox("Enable Third List")
        self.checkbox.stateChanged.connect(self.toggle_third_list)
        self.checkbox_layout.addWidget(self.checkbox)
        self.main_layout.addLayout(self.checkbox_layout)
        
        # List Widgets Container
        
        self.lists = []
        self.list_main_layout = QHBoxLayout()
        self.list_layouts = []
        self.list_labels = list_labels
        
        # Create first two lists
        for index in range(2):
            self.add_list(index, items if index == 0 else [])

        # Create the third list layout in advance (always initialized)
        self.third_list_layout = QVBoxLayout()
        self.third_list_label = QLabel(self.list_labels[2])
        self.third_list_widget = QListWidget()
        self.third_list_widget.setDragDropMode(QListWidget.DragDrop)
        self.third_list_widget.setDefaultDropAction(Qt.MoveAction)
        self.third_list_widget.setDragEnabled(True)
        self.third_list_widget.setAcceptDrops(True)
        self.third_list_widget.setDropIndicatorShown(True)
        self.third_list_widget.setFixedHeight(300)  # Fix the height to match other lists


        self.third_list_widget.model().rowsMoved.connect(self.update_indices)
        self.third_list_widget.model().rowsInserted.connect(self.update_indices)
        self.third_list_widget.model().rowsRemoved.connect(self.update_indices)

        self.third_list_layout.addWidget(self.third_list_label)
        self.third_list_layout.addWidget(self.third_list_widget)
        self.list_main_layout.addLayout(self.third_list_layout)

        # Hide third list initially
        self.third_list_label.hide()
        self.third_list_widget.hide()

        # Set fixed size for all lists
        for list_widget in self.lists:
            list_widget.setFixedHeight(300)
            list_widget.setFixedWidth(180)
        self.third_list_widget.setFixedHeight(300)
        self.third_list_widget.setFixedWidth(180)

        # Spacer to ensure consistent spacing
        #self.spacer = QSpacerItem(20, 40, QSizePolicy.Minimum, QSizePolicy.Expanding)
        #for layout in self.list_layouts:
        #    layout.addItem(self.spacer)
        #self.third_list_layout.addItem(self.spacer)
        
        # Spacer to take the place of the third list when hidden
        self.third_list_spacer = QSpacerItem(243,300,QSizePolicy.Minimum,QSizePolicy.Expanding)
        self.third_list_layout.addItem(self.third_list_spacer)
        
        # Add list layout to the main layout
        self.main_layout.addLayout(self.list_main_layout)

    def add_list(self, index, items):
        layout = QVBoxLayout()
        label = QLabel(self.list_labels[index])
        
        list_widget = QListWidget()
        list_widget.setDragDropMode(QListWidget.DragDrop)
        list_widget.setDefaultDropAction(Qt.MoveAction)
        list_widget.setDragEnabled(True)
        list_widget.setAcceptDrops(True)
        list_widget.setDropIndicatorShown(True)
        list_widget.setFixedHeight(300)  # Fix the height for consistency
        
        for i, item in enumerate(items):
            list_item = QListWidgetItem(f"{i + 1}. {item}")
            list_widget.addItem(list_item)
        
        list_widget.model().rowsMoved.connect(self.update_indices)
        list_widget.model().rowsInserted.connect(self.update_indices)
        list_widget.model().rowsRemoved.connect(self.update_indices)
        
        self.lists.append(list_widget)
        self.list_layouts.append(layout)
        layout.addWidget(label)
        layout.addWidget(list_widget)
        self.list_main_layout.addLayout(layout)

    def toggle_third_list(self, state):
        """Enable or disable the third list dynamically."""
        if state == Qt.Checked:
            # Show third list
            self.third_list_layout.removeItem(self.third_list_spacer)
            self.third_list_label.show()
            self.third_list_widget.show()
        else:
            # Move items back to List 1 and hide the third list
            while self.third_list_widget.count():
                item = self.third_list_widget.takeItem(0)
                self.lists[0].addItem(item)
            
            self.third_list_label.hide()
            self.third_list_widget.hide()
            self.third_list_spacer = QSpacerItem(243,300,QSizePolicy.Minimum,QSizePolicy.Expanding)
            self.third_list_layout.addItem(self.third_list_spacer)
        
        self.update_indices()

    def update_indices(self):
        """Update the order numbers in all lists."""
        all_lists = self.lists + [self.third_list_widget]
        for list_widget in all_lists:
            if list_widget.isVisible():
                for i in range(list_widget.count()):
                    item = list_widget.item(i)
                    text = item.text().split(". ", 1)[-1]  # Keep only the text after the number
                    item.setText(f"{i + 1}. {text}")
                    
def three_sortable_lists(items=["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grapes", "Honeydew", "Kiwi"]) : 
    """Dumb test"""
    app = QApplication(sys.argv)
    window = MultiSortableListsWidget(items)
    window.show()
    sys.exit(app.exec_())

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
        self.grid_checkbox.stateChanged.connect(self.toggle_grid)
        controls_layout.addWidget(self.grid_checkbox)

        # Case pour activer la seconde ordonnée
        self.secondary_y_checkbox = QCheckBox("Second Ordinate")
        self.secondary_y_checkbox.stateChanged.connect(self.toggle_secondary_y)
        controls_layout.addWidget(self.secondary_y_checkbox)

        # Champ pour le label X
        self.x_label_edit = QLineEdit(self.x_label)
        self.x_label_edit.setPlaceholderText("X-axis Label")
        self.x_label_edit.textChanged.connect(self.update_x_label)
        controls_layout.addWidget(QLabel("X label"))
        controls_layout.addWidget(self.x_label_edit)

        # Champ pour le label Y
        self.y_label_edit = QLineEdit(self.y_label)
        self.y_label_edit.setPlaceholderText("Y-axis Label")
        self.y_label_edit.textChanged.connect(self.update_y_label)
        controls_layout.addWidget(QLabel("Y label:"))
        controls_layout.addWidget(self.y_label_edit)

        # Champ pour le label Y2
        self.y2_label_edit = QLineEdit(self.y2_label)
        self.y2_label_edit.setPlaceholderText("Y2-axis label")
        self.y2_label_edit.textChanged.connect(self.update_y2_label)
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
            widget = ColumnSettings(column, self.update_plot, default_color)
            self.column_settings_widgets.append(widget)
            self.scroll_layout.addWidget(widget)

        self.scroll_content.setLayout(self.scroll_layout)
        self.scroll_area.setWidget(self.scroll_content)
        self.layout.addWidget(self.scroll_area)

        self.setCentralWidget(self.main_widget)
        self.update_plot()

    def rgb_to_hex(self, rgb):
        """Convertit une couleur RGB en chaîne hexadécimale."""
        return '#{:02x}{:02x}{:02x}'.format(int(rgb[0] * 255), int(rgb[1] * 255), int(rgb[2] * 255))

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


def df_interactive_plot(df, windows_title="Graphique"):
    """Lance la fenêtre d'affichage interactif."""
    app = QApplication(sys.argv)
    main_window = InteractiveGraph(df, windows_title)
    main_window.show()
    app.exec_()
    
def test_the_widget(widget):
    app = QApplication(sys.argv)
    main_window = widget()
    main_window.show()
    app.exec_()