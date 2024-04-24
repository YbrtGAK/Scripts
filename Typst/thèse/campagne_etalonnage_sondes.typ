#import "@local/math_lib:1.0.0" : *

#set heading(numbering: "1.")
#show heading.where(level:1) : it => align(center,it)
#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}




#{
set text(size:15pt)
set align(center)

  
  [*Campagne d'étalonnage des thermocouples et des capteurs de pression du banc expérimental "ébullition convective"* \ *Avril 2024*]
}

#pagebreak()
#outline(indent:auto, title:[Sommaire])
#pagebreak()

= Les thermocouples
== Liste du matériel

#table(
  columns: 2,
  stroke: (x: none),
  align: horizon,
  [☒], [Close cabin door],
  [☐], [Start engines],
  [☐], [Radio tower],
  [☐], [Push back],
)
#image("\Figures\schéma de principe.png")

== Protocole expérimental
== Résulats

#pagebreak()
= Les capteurs de pression
== Liste du matériel
== Protocole expérimental
== Résulats