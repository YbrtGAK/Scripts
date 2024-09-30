#import "@local/math_lib:1.0.0" : *
#import "@preview/tablex:0.0.8" : tablex, cellx, hlinex, vlinex, gridx, rowspanx


#set text(fill: black)
#set heading(numbering: "1.1.1.a")
#let r(it) = text(fill:red,it)
#show heading.where(level:1) : it => align(left,it) + v(10pt)
#show heading.where(level:2) : it =>  it + v(8pt)
#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}
#set math.equation(numbering:none)
#show math.equation.where(numbering: "(1)") : it => grid(
  columns : (1fr,auto,1fr),
  [],
  math.equation(block : true)[#block(stroke : black, clip:true, inset : 6pt)[#it.body]],
  h(20pt) + align(right + horizon, "(" + str(counter( math.equation).at(it.location()).first())+ ")"))

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

  
  [*Campagne d'étalonnage des thermocouples et des capteurs de pression du banc expérimental "ébullition convective"* \ *2024*]
}

#align(center+horizon,
  align(center,
  table(inset:5pt,image("Figures\chaine_acquisition_thermocouple.svg"))
)
)

#align(bottom + left, text(size:7pt)[Dans ce document, les températures mesurées sont distinguées des températures réelles par un apostrophe (ex : Si $T_1$ est la grandeur à mesurée, $T_1 '$ en est la mesure).])

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

#{}
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
== Protocole d'étalonnage

Le protocole d'étalonnage proposé répond aux normes et documents techniques en vigueur telles que :
- l'ISO 17025,
- Le guide technique COFRAC d'accréditation en température (LAB GTA08). 
Cette liste est non exhaustive. 

L'objectif de l'étalonnage est de proposer pour chaque thermocouple une loi de correction permettant de réduire au maximum l'incertitude sur la mesure. Cette incertitude peut être déterminée :
- A partir des incertitudes aléatoires (type A),
- A partir des incertitudes induites par l'instrumentation, la nature de la mesure et la propagation d'incertitude (type B),
- A partir de la méthode de Monte Carlo.

La @chaine_acquisition_thermocouple propose une schématisation de la chaîne d'acquisition du banc.  

  #figure(
 block(
  stroke:1pt,
  inset:5pt,(image("Figures\chaine_acquisition_thermocouple.svg",width:14cm))),
  kind:image,
  gap:8pt,
  numbering: "1",
  supplement: "Figure",
  caption:  [Schéma de la chaîne d'étalonnage]
         ) <chaine_acquisition_thermocouple>
        
La mesure de la température $T_c$ à l'aide d'un thermocouple est indirecte. Le fonctionnement de ce type de thermomètre n'est pas détaillé, le lecteur pourra se référer à #text(fill:red)[Citer un article d'explication du fonctionnement des thermocouples] la littérature. Elle provient de la mesure de deux tensions $U_"PT100"$ et $U_"ref"$ puis d'un traitement mathématique en 3 étapes via #text(fill:red,[deux tables de polynômes])#footnote(text(fill:red,[Vérifier si c'est pas trois vu que polynôme non inversible, le citer])). Ces opérations sont briévement décrites dans l'encart de la figure. On détaille la méthodologie ci-après.

=== Méthodologie d'étalonnage

Soient $Y$ la mesurande, $y$ son estimation et $u(y)$ l'écart-type de la mesure.
Les étapes de l'étalonnage des thermocouples sont listées ci-dessous : 

0. Au choix une méthode de calcul d'incertitude :
1. Calcul de l'incertitude de type A : 
  #math.equation(numbering : "(1)", supplement : "équation", block : true)[
  $
  u(mean(y)) = s(mean(y)) = sqrt((1)/(n.(n-1)).sum_(i=1)^(n)(y_i - mean(y))^2) = s(y)/sqrt(n)
  $] <incertitude_type_A>

  Cette incertitude peut être étendue pour obtenir un intervalle d'incertitude (à 95% par exemple). Notamment, la loi Student peut être utilisée (Se réféfer à la méthode GUM). Elle est utilisée lorsque les mesures sont directes et nombreuses (Environ $n > 30$ #footnote(text(fill:red,[Citer les travaux de JLBK]))).

2. Calcul de l'incertitude de type B :

  Dans le cas où la mesure ne peut être réalisée de nombreuses fois et/ou qu'elle est indirecte, l'incertitude de type B est déterminée : 

  2.1. Formalisation mathématique de la mesure $y = f(x_1,x_2,[...],x_n)$ avec $x_(i in [1;n])$ une mesure directe. On se ramene donc à un problème fonction des mesurandes "fondamentales" de la mesure. \
      #h(10pt) 2.1.1. Détermination de la distribution des incertitudes (normale, uniforme/rectangulaire, étalée). \ 
      #h(10pt) 2.1.2. Recensement des incertitudes des appareils de mesure et des tables polynomiales utilisées. \
      #h(10pt) 2.1.3. Propagation de l'incertitude : 
      
      #math.equation(numbering : "(1)", supplement : "équation", block : true)[
  $
  u(y)^2 = sum_(i=1)^n (u(x_i)^2. (derpt(f,x_i))^2) + 2.sum_(i=1)^(n-1)sum_(j=i+1)^(n)(u(x_i,x_j).(derpt(f,x_i)).(derpt(f,x_j)))
  $] <incertitude_type_B>

3. Calcul de l'incertitude par la méthode de Monte-Carlo (solution de référence) \
    3.1. Reprendre les étapes 2.1.1 et 2.1.2 \
    3.2. #r[Potasser le gros de la doc de UDMT]

=== Application du protocole d'étalonnage au banc d'essai

La détermination d'incertitude par Monte-Carlo a été choisi pour l'étalonnage des thermocouples. Ce choix s'explique par la nature indirecte de la mesure malgré le nombre élevé de mesures.

==== Formalisation mathématique de la mesure

Soit $"TC"'$ la mesure de la température chaude $"TC"$. \
En se référant à la @chaine_acquisition_thermocouple, exprimons $"TC"$ en fonction des mesures directes réalisées sur le banc (en gras dans l'image) : 
$
&U_"tot" = U_"correction" + bold(U_"thermocouple") \
so &U_"tot" = P_"K,E" (T_0 ' - T_"ref") +  bold(U_"thermocouple") \
$ <equation_callendar-Van_Dusen>

Avec : 
- $P_"K,E"$ le polynôme de conversion Fem - Température des thermocouples type K (Voire l'@polynome_thermocouple en annexe A),
- $T_0 '$ la mesure de la température de référence de la bôite de jonction,
- $T_"ref"$ la température de référence du multimètre (Keithley 27XX).  \

 La température de la soudure froide, $T_0 '$,  est lue à partir de la sonde PT100 de la boîte de jonction. Elle est également une mesure indirecte, la mesure intermédiaire étant la résistance électrique de la sonde (fonction de la température, voir @polynome_PT100 de Callendar-Van Dusen). 

#r[Egalement, des tables existent] \ 
On estime la température en évaluant la tension "totale" obtenue par le polynôme de @polynome_inverse_thermocouple.
$
&T_c ' =  P_"K,T" (P_"K,E" (bold(T_"0") - T_"ref") +  bold(U_"thermocouple"))\
$
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
  ),
  kind:table,
  supplement: [Tableau],
  caption : [Liste des transmetteurs de pression],
  )

  #{
set text(size:8pt)
v(-10pt) 
[Les transmetteurs de pression Keller admettent une limite maximale de température de 100°C, limitant l'utilisation du banc au-delà de cette valeur.]}
== Protocole expérimental
== Résulats

= Autres matériels
== Liste du matériel

#figure(kind:table,
  supplement: [Tableau],
  caption : [Liste du matériel auxillaire],
  table(
  columns:(auto,auto,auto,auto,auto,auto,auto),
  align: horizon+center,
  [Indice], [Canal],  [Référence], [Localisation],[Type], [Plage de fonctionnement],[Calibré],
  [TOX2],[117],[N/A],[Preheater],[U correction],[N/A],[☒],
  [OX1],[109],[N/A],[Preheater],[U correction],[N/A],[☒],
  [OX2],[105],[Micromotion 1700 Emerson],[Auxilliaire],[Coriolis Mass flow meter],[0 - 108 kg/h],[☒],
  )
  )


#pagebreak()
#heading(numbering:none)[Annexe]
#align(center,heading(numbering:none,level:2)[Annexe A : Fonctions de conversion pour thermocouple de type K #footnote[Source : NIST.gov] ])

#{
  set align(left)
  set text(size:10pt,weight:"bold")
  underline[_Equation Température [°C] #sym.arrow Fem [mV] : _]
}
#math.equation(numbering : "(1)", supplement : "équation", block : true)[$
T in [-270;0[ °C : &P_"K,E" (T) = sum_(i=0)^n (c_i. T^i)  \
T in [0;1372] °C : &P_"K,E"(T) = sum_(i=0)^n (c_i. T^i) + a_0. exp(a_1. (T- a_2)^2)
$] <polynome_thermocouple>

#{
show table.cell.where(fill: none, x: 0): it => it.default() 
figure(
  tablex(
    columns : (3.25cm,auto,auto),
    align:center,
    hlinex(start:0,end:3,stroke: black + 2pt),
    hlinex(start:0,end:3,stroke: black + 2pt,y:1),
    map-vlines: v => (..v, stroke: none),
    cellx(fill:gray.lighten(80%))[*Coefficients*],cellx(fill:gray.lighten(80%))[* [-270 ; 0] °C *], cellx(fill:gray.lighten(80%))[* [0 ; 1372] °C *],
    [$c_0$],[0.000000000000E-0],[-0.176004136860E-1],
    [$c_1$],[0.394501280250E-01],[0.389212049750E-01],
    [$c_2$],[0.236223735980E-04],[0.185587700320E-04],
    [$c_3$],[-0.328589067840E-06],[-0.994575928740E-07],
    [$c_4$],[-0.499048287770E-08],[0.318409457190E-09],
    [$c_5$],[-0.675090591730E-10],[-0.560728448890E-12],
    [$c_6$],[-0.574103274280E-12],[0.560750590590E-15],
    [$c_7$],[-0.310888728940E-14],[-0.320207200030E-18],
    [$c_8$],[-0.104516093650E-16],[0.971511471520E-22],
    [$c_9$],[-0.198892668780E-19],[-0.121047212750E-25],
    [$c_10$],[-0.163226974860E-22], [],
    [$a_0$], [], [0.118597600000E+00],
    [$a_1$], [], [-0.118343200000E-03],
    [$a_2$], [], [-0.118343200000E-03],
    ),
    caption :[Tableau des coefficients du polynôme T #sym.arrow Fem],
    kind:table,
    supplement: [Tableau],
)

} <tableau_coefficients_T-E>

#pagebreak()

#{
  set align(left)
  set text(size:10pt,weight:"bold")
  underline[_Equation Fem [mV] #sym.arrow Température [°C]: _]
}
#math.equation(numbering : "(1)", supplement : "équation", block : true)[$
P_"K,T" (E) = sum_(i=0)^n (d_i. E^i)  \
$] <polynome_inverse_thermocouple>

#{
show table.cell.where(fill: none, x: 0): it => it.default() 
figure(
  tablex(
    columns : (3.25cm,auto,auto, auto),
    align:center,
    hlinex(start:0,end:4,stroke: black + 2pt),
    hlinex(start:0,end:4,stroke: black + 2pt,y:1),
    hlinex(start:0,end:4,stroke: black + 2pt,y:11),
    hlinex(start:0,end:4,stroke: black + 2pt,y:12),
    map-vlines: v => (..v, stroke: none),
    cellx(fill:gray.lighten(80%),align:horizon+center)[*Coefficients*],cellx(fill:gray.lighten(80%))[* [-5.891 ; 0] mV \ [-200 ; 0] °C *], cellx(fill:gray.lighten(80%))[* [0 ; 20.644] mV \ [0 ; 500] °C *], cellx(fill:gray.lighten(80%))[* [20.644 ; 54.886] mV \ [500 ; 1372] °C *],
    [$d_0$],[0.0000000E+00],  [0.000000E+00], [-1.318058E+02],
    [$d_1$],[2.5173462E+01],  [2.508355E+01],  [4.830222E+01],
    [$d_2$],[-1.1662878E+00],  [7.860106E-02], [-1.646031E+00],
    [$d_3$],[-1.0833638E+00], [-2.503131E-01],  [5.464731E-02],
    [$d_4$],[-8.9773540E-01], [ 8.315270E-02], [-9.650715E-04],
    [$d_5$],[-3.7342377E-01], [-1.228034E-02],  [8.802193E-06],
    [$d_6$],[-8.6632643E-02],  [9.804036E-04], [-3.110810E-08],
    [$d_7$],[-1.0450598E-02], [-4.413030E-05],  [],
    [$d_8$],[-5.1920577E-04],  [1.057734E-06],  [],
    [$d_9$],[], [-1.052755E-08],  [],
    [*Erreur [°C]*],[[-0.02 ; 0.04]],[[-0.05 ; 0.04]],[[-0.05 ; 0.06]]
    ),
    caption :[Tableau des coefficients du polynôme inversé Fem #sym.arrow T],
    kind:table,
    supplement: [Tableau],
)

} <tableau_coefficients_E-T>

#pagebreak()
#align(center,heading(numbering:none,level:2)[Annexe B : Fonctions de conversion pour sonde PT100 #footnote[Source : Keithley 27XX User Manual]])

#{
  set align(left)
  set text(size:10pt,weight:"bold")
  underline[_Callendar-Van Dusen équations Température [°C] #sym.arrow Résistance [Ohm] : _]
}
#math.equation(numbering : "(1)", supplement : "équation", block : true)[$
&T in [-200;0[ #h(2pt) °C : R(T) =R_0.(1+A.T+B.T^2+C.T^3.(T-100))  \
&T in [0;630] #h(2pt) °C : R(T) =R_0.(1+A.T+B.T^2)
$] <polynome_PT100>
Avec $A,B,C in RR "définies comme suit" $: 
- $A = alpha. (1+(delta/100))$
- $B = -alpha. delta.(1e-4)$
- $C = -alpha. beta. (1e-8)$

#{
show table.cell.where(fill: none, x: 0): it => it.default() 
figure(
  tablex(
    columns : (auto,auto,auto,auto,auto,auto,auto),
    align:center,
    hlinex(start:0,end:7,stroke: black + 2pt),
    hlinex(start:0,end:7,stroke: black + 2pt,y:1),
    map-vlines: v => (..v, stroke: none),
    map-cells : c => (..c, align:horizon + center),
    cellx(fill:gray.lighten(80%))[*Type*],cellx(fill:gray.lighten(80%))[*Standard*], cellx(fill:gray.lighten(80%))[*Référence*],cellx(fill:gray.lighten(80%))[$bold(alpha #h(3pt) [°C])$],cellx(fill:gray.lighten(80%))[$bold(beta #h(3pt) [°C^(-2)])$],cellx(fill:gray.lighten(80%))[$bold(delta #h(3pt) [°C^(-4)])$], cellx(fill:gray.lighten(80%))[$bold(Omega "à " 0°C #h(3pt) ["Ohm"])$],

    cellx(rowspan:2,align:center+horizon)[PT100], cellx(rowspan:2,align:center+horizon)[ITS-90], [Keithley 27XX \ user manual#footnote[Source : NIST]], [0.003850], [0.10863], [1.49990], [100],
    [Valeurs du \ LabView#footnote[D'origine inconnue, elles étaient enregistrées tel quel dans la dernière version en la possession de l'auteur]], [0.003850], [0.111], [1.507], [100],
    [*Erreur [°C]*],cellx(colspan:6)[0.06],
    hlinex(start:0,end:7,stroke: black + 2pt,y:3),
    hlinex(start:0,end:7,stroke: black + 2pt,y:4),
    ),
    caption :[Tableau des coefficients du polynôme T #sym.arrow Fem],
    kind:table,
    supplement: [Tableau],
)
} 

