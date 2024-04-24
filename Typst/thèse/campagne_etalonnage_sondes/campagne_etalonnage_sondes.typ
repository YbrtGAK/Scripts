#import "@local/math_lib:1.0.0" : *

#set text(fill: black)
#set heading(numbering: "1.")
#show heading.where(level:1) : it => align(left,it) + v(10pt)
#show heading.where(level:2) : it =>  it + v(8pt)
#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}

#set figure(kind:image)
#show figure.where(kind:table): it=> {
set figure.caption(position:top)
show figure.caption : strong
it
}
#show table.cell.where(y: 0): it => {
set text(weight: "bold")
it
}
#{
set text(size:15pt)
set align(center)

  
  [*Campagne d'étalonnage des thermocouples et des capteurs de pression du banc expérimental "ébullition convective"* \ *Avril 2024*]
}

#pagebreak()
#outline(indent:auto, title:[Sommaire])
#pagebreak()
= Le banc d'essai

Le schéma de principe du banc d'essai est donné en  @schema_principe_banc. Les indices utilisés pour identifier les thermocouples et les transmetteurs de pression qui y sont utilisés servent de référence tout au long du document. Tout autre document technique rédigé par mes soins fera référence à ces mêmes indices.

#{
set figure.caption(position:top)

}
#figure(
  align(center,table(inset:0pt,image("/Figures/schéma de principe.png",width:14cm),
  stroke:1pt)),
  kind:image,
  numbering: "1",
  supplement: "Figure",
  caption:  [Schéma de principe du banc d'essai \ ébullition convective]
         ) <schema_principe_banc>

Ce document a plusieurs objectifs : 
1. Identifier clairement l'instrumentation du banc,
2. Définir une méthodologie pour étalonner les capteurs :
  - Par soucis de répétabilité,
  - Par soucis de traçabilité des évolutions du banc.
3. Garder une trace des résultats obtenus.

#pagebreak()
= Les thermocouples
== Liste du matériel
//Mise en forme du tableau
//Mise en forme des bordures
#set table(stroke: (x, y) => (
  top: if y == 0 or y==1 { 2pt } else { 1pt },
  bottom: if y == 0 {2pt} else {1pt}
))

//Mise en forme de surlignage bleu pour les capteurs de la section test

//Instanciation d'un objet état --> permet d'évaluer le contenu d'une cellule
#let current-col = state("current-col", "")

//Régle évaluée en une celulle : si celle-ci commence par la lettre T, alors toute les cellules de sa ligne sont surlignées en bleu
#show table.cell.where(fill: none): it => context {
  if current-col.at(here()).clusters().first() == "T" {
    box(
      fill: blue.lighten(85%),
      stroke : (top:0.4pt, bottom:0.4pt),
      width: 102%,
      outset: -0pt,
      it
    )
  } else {
    it
  }
}
//Applique la règle précédente sur les cellule de la première colonne uniquement
#show table.cell.where(fill: none, x: 0): it => {
  current-col.update(it.body.text)
  it
}

#figure(
  table(
  columns:(auto,2.4cm,4cm,4cm,auto,auto),
  align: horizon+center,
 [Indice], [Keithley's \ Channel],  [Type], [Localisation], [Immergé],[Calibré],
  [A1.1], [234], [Homemade (Omega®)], [Pre-heater inlet],[☐],[☒],
[A1.2], [202],[K405 (Prosensor®)],[Pre-heater inlet], [☒],[☒],
  [T1],[219],[Homemade (Omega®)],[Pre-heater surface 1],[☐],[☐],
  [T2],[208],[Homemade (Omega®)],[Pre-heater surface 2],[☐],[☐],
  [T3],[220],[Homemade (Omega®)],[Pre-heater surface 3],[☐],[☐],
  [T4],[218],[Homemade (Omega®)],[Pre-heater surface 4],[☐],[☐],
  [T5], [216, 237, 238],[Homemade (Omega®)],[Test section inlet],[☐],[☒],
  [T6], [225],[K405 (Prosensor®)],[Test section inlet],[☒],[☒],
  [T7], [212],[Homemade (Omega®)],[Tube wall 1 top],[☐],[☒],
  [T8], [239],[Homemade (Omega®)],[Tube wall 1 middle],[☐],[☒],
  [T9], [223],[Homemade (Omega®)],[Tube wall 1 bottom],[☐],[☒],
  [T10], [209],[Homemade (Omega®)],[Tube wall 2 top],[☐],[☒],
  [T11], [224],[Homemade (Omega®)],[Tube wall 2 middle ],[☐],[☒],
  [T12], [233],[Homemade (Omega®)],[Tube wall 2 bottom],[☐],[☒],
  [T13], [203],[Homemade (Omega®)],[Tube wall 3 top],[☐],[☒],
  [T14], [228],[Homemade (Omega®)],[Tube wall 3 middle ],[☐],[☒],
  [T15], [235],[Homemade (Omega®)],[Tube wall 3 bottom],[☐],[☒],
  [T16], [217],[Homemade (Omega®)],[CHF#footnote[Critical Heat Flux] top],[☐],[☒],
  [T17], [222],[Homemade (Omega®)],[CHF bottom],[☐],[☒],
  [T18.1], [207, 226, 232],[Homemade (Omega®)],[Test section outlet],[☐],[☒],
  [T18.2], [230],[K405 (Prosensor®)],[Test section outlet],[☒],[☒],
  [A3], [240],[Homemade (Omega®)],[Pump inlet],[☐],[☐],
  [A4], [206],[Homemade (Omega®)],[Tank up],[☐],[☐],
  [A5], [205],[Homemade (Omega®)],[Tank Down],[☐],[☐],
  [O1], [204],[Homemade (Omega®)],[Ambient],[☐],[☒],
  [O2.1], [201],[PT100],[Cold junction],[☐],[☐],
  [O2.2], [211],[PT100],[Cold junction],[☐],[☐],
  [O2.3], [221],[PT100],[Cold junction],[☐],[☐],
  [O2.3], [231],[PT100],[Cold junction],[☐],[☐],
  )
  ,
  numbering: "1",
  kind:table,
  supplement: [Tableau],
  caption: [Inventaire des thermocouples (type K)] + v(2pt)
)
#{
set text(size:8pt)
v(-10pt) 
[Blue higlight #so Test section's sensor]

}
== Protocole expérimental
== Résulats

#pagebreak()
= Les capteurs de pression

== Liste du matériel
== Protocole expérimental
== Résulats