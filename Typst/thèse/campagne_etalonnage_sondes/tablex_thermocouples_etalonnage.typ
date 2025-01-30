#import "@preview/tablex:0.0.8" : tablex, cellx

// Définir un style conditionnel pour les cellules d’une ligne
#let style_conditional = (indice) => {
  if indice.starts_with("T") {
    blue.lighten(85%)
  } else if indice.starts_with("F") {
    red.lighten(85%)
  } else {
    none
  }
}

// Création du tableau avec condition de style sur la colonne "Indice"
#tablex(
  columns: (auto, 2.4cm, 4cm, 4cm, auto),
  align: horizon+center,
  map-cells: cell => {
  if cell.y > 0 {  // Ignorer la première ligne d'en-tête
    let indice = tablex.cell(cell.y, 1).body.text
    let fill_color = style_conditional(indice)
    cellx(fill: fill_color, inset: 0pt, cell)
  } else {
    cellx(cell)  // Garder l'en-tête sans changement
  }
  },
  "Canal", "Indice", "Localisation", "Référence", "Calibré",
  "201", "FRTD1", "Loc", "Homemade (Omega®)", "☐",
  "202", "TC1", "Homemade (Omega®)", "Homemade (Omega®)", "☐",
  "203", "FC1", "Homemade (Omega®)", "Homemade (Omega®)", "☐"
  // Applique la couleur de fond en fonction de la valeur dans la colonne "Indice"
)
