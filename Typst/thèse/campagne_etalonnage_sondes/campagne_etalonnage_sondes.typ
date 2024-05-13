#import "@local/math_lib:1.0.0" : *

#set text(fill: black)
#set heading(numbering: "1.")
#let r(it) = text(fill:red,it)
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

Le schéma de principe du banc d'essai est donné en  @schema_principe_banc. La section de test est quant à elle détaillée en @schema_section_test. Elle comprend : Le pré-chauffeur#footnote[Dénomminé preheater dans ce document], l'évaporateur, le tube de visualisation, ainsi que les appareils de mesures (thermocouples, transmetteurs de pression, caméra à image rapide). Les indices utilisés pour identifier ces derniers servent de référence tout au long du document. Tout autre document technique rédigé dans le cadre de ma thèse y fera référence. On distingue : 
- $"A"_i$ : Auxiliary (Thermocouples)
- $"T"_i$ : Test section (Thermocouples)
- $"TP"_i$ : Test section (Pressure sensors)
- $"O"_i$ : Others

#{
set figure.caption(position:top)

}
#figure(
  align(center,table(inset:0pt,image("/Figures/schéma de principe.png",width:14cm),
  stroke:1pt)),
  kind:image,
  numbering: "1",
  supplement: "Figure",
  caption:  [Schéma de principe du banc d'essai \ "Ebullition Convective"]
         ) <schema_principe_banc>

#figure(
  align(center,table(inset:0pt,image("\Figures\schéma de principe - section test.png",width:8.5cm),
  stroke:2pt)),
  kind:image,
  numbering: "1",
  supplement: "Figure",
  caption:  [Schéma de principe de la section d'essai \ (Auteur : Daniel Marchetto, modifié)]
         ) <schema_section_test>

Ce document a plusieurs objectifs : 
1. Identifier clairement l'instrumentation du banc,
2. Définir une méthodologie pour étalonner les capteurs :
  - Par soucis de répétabilité,
  - Par soucis de traçabilité des évolutions du banc.
3. Afin de sauvegarder les résultats obtenus.

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
      height: auto,
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
  [Indice], [Canal #footnote[Fait références aux canaux du Keithley]],  [Référence], [Localisation], [Immergé],[Calibré],
  [A1], [202],[K405 (Prosensor®)],[Preheater inlet], [☒],[☒],
  [A2], [234], [Homemade (Omega®)], [Preheater inlet],[☐],[☒],
  [T1],[219],[Homemade (Omega®)],[Preheater surface 1],[☐],[☐],
  [T2],[208],[Homemade (Omega®)],[Preheater surface 2],[☐],[☐],
  [T3],[220],[Homemade (Omega®)],[Preheater surface 3],[☐],[☐],
  [T4],[218],[Homemade (Omega®)],[Preheater surface 4],[☐],[☐],
  [T5], [212],[K405 (Prosensor®)],[Preheater outlet],[☒],[☐],
  [T6], [216, 237, 238],[Homemade (Omega®)],[Evaporator inlet],[☐],[☒],
  [T7], [225],[K405 (Prosensor®)],[Evaporator inlet],[☒],[☒],
  [T8], [212],[Homemade (Omega®)],[Tube wall 1 top],[☐],[☒],
  [T9], [239],[Homemade (Omega®)],[Tube wall 1 middle],[☐],[☒],
  [T10], [223],[Homemade (Omega®)],[Tube wall 1 bottom],[☐],[☒],
  [T11], [209],[Homemade (Omega®)],[Tube wall 2 top],[☐],[☒],
  [T12], [224],[Homemade (Omega®)],[Tube wall 2 middle ],[☐],[☒],
  [T13], [233],[Homemade (Omega®)],[Tube wall 2 bottom],[☐],[☒],
  [T14], [203],[Homemade (Omega®)],[Tube wall 3 top],[☐],[☒],
  [T15], [228],[Homemade (Omega®)],[Tube wall 3 middle ],[☐],[☒],
  [T16], [235],[Homemade (Omega®)],[Tube wall 3 bottom],[☐],[☒],
  [T17], [217],[Homemade (Omega®)],[CHF#footnote[Critical Heat Flux] top],[☐],[☒],
  [T18], [222],[Homemade (Omega®)],[CHF bottom],[☐],[☒],
  [T19.1], [207, 226, 232],[Homemade (Omega®)],[Evaporator outlet],[☐],[☒],
  [T19.2], [230],[K405 (Prosensor®)],[Evaporator outlet],[☒],[☒],
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
[Les capteurs surlignés en bleu sont situés dans la section test du banc \ 
Les indices du type $X_(i,j)$ font référence à un des capteurs j qui réalisent une mesure au même point matériel i.] 

}
== Protocole expérimental
== Résulats

#pagebreak()
= Les capteurs de pression

== Liste du matériel
#figure(
  table(
  columns:(auto,auto,4.7cm,3.08cm,auto,2.6cm,auto),
  align: horizon+center,
  [Indice], [Canal],  [Référence], [Localisation],[Type], [Plage de fonctionnement],[Calibré],
  [TP1],[118],[Keller PA23],[Evaporator inlet],[$P_abs$],[0-30 bars],[☐],
  [TP2],[102],[Keller PD-23],[Evaporator],[$Delta P$],[0-5 bars],[☐],
  [TP3],[112],[Emmerson Rosemount 3051],[Evaporator] ,[$Delta P$],[0-2 bars],[☐],
  [TP4],[114],[Emmerson Rosemount 3051],[Evaporator] ,[$Delta P$],[0-50 mbars],[☐],
  [TP5],[113],[Keller PA23],[Evaporator outlet],[$P_abs$],[0-35 bars],[☐],
  [AP1],[120],[Keller PA23],[Pump inlet],[$P_abs$],[0-35 bars],[☐],
  [AP2],[115],[Keller PA23],[Tank],[$P_abs$],[0-35 bars],[☐],
  )
  )
  #{
set text(size:8pt)
v(-10pt) 
[Les transmetteurs de pression Keller admettent une limite maximale de température de 100°C, limitant l'utilisation du banc au-delà de cette valeur.]}
== Protocole expérimental
== Résulats

= Autres matériels
== Liste du matériel

#figure(
  table(
  columns:(auto,auto,auto,auto,auto,auto,auto),
  align: horizon+center,
  [Indice], [Canal],  [Référence], [Localisation],[Type], [Plage de fonctionnement],[Calibré],
  [TOX2],[117],[N/A],[Preheater],[U correction],[N/A],[☒],
  [OX1],[109],[N/A],[Preheater],[U correction],[N/A],[☒],
  [OX2],[105],[Micromotion 1700 Emerson],[Auxilliaire],[Coriolis Mass flow meter],[0 - 108 kg/h],[☒],
  )
  )