# -*- coding: utf-8 -*-
"""
Created on Mon Dec 16 20:56:21 2024

@author: yberton
"""

from PyQt5.QtWidgets import QApplication, QListWidget, QListWidgetItem, QVBoxLayout, QWidget
from PyQt5.QtCore import Qt
import sys

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

if __name__ == "__main__":
    app = QApplication(sys.argv)

    # Example input list
    items = ["Apple", "Banana", "Cherry", "Date", "Elderberry"]

    window = SortableListWidget(items)
    window.show()

    sys.exit(app.exec_())
