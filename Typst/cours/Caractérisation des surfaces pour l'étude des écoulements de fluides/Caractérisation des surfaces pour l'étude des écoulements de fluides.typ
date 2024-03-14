
//Importation du template
#import "@local/math_lib:1.0.0" : *
#import "@local/paper_course_template:1.0.0" : *

#show: course.with(
  title: [Caractérisation des surfaces pour l'étude des écoulements de fluides],
  field : [Cours de Mécanique],
  author: "Yann Berton",
)

//Définition de fonctions
#let vol = text(8pt)[V]
#let rouge(it) = text(fill:red,it)

//Régles de mise en forme des équations
//Par défaut, ne pas numéroter les équations
#set math.equation(numbering:none)
//Si elles sont numérotées/référencées, les encadrer
#show math.equation.where(numbering: "(1)") : it => grid(
  columns : (1fr,3fr,1fr),
  [],
  math.equation(block : true)[#rect(inset:10pt)[#it.body]],
  align(right + horizon, "(" + str(counter( math.equation).at(it.location()).first())+ ")"))

= Introduction

Idées : 
- Monophasique : Moody & Nikuradse
    - Expérimentations, diagramme #sym.arrow  rugosité relative
- Diphasique : Kandlikar, Karayiannis
    - Travaux en cours, besoins de nouvelles définition

= Etat de surface

Considérons un tube en acier inoxydable de dimension ∅$$6x∅3mm.
On illustre ci-dessous son état de surface : 

#figure(image("Illustrations\Profil_SS_unfiltered.png"),
 caption :[Profil non filtré de la surface intérieure d'un tube en acier inoxydable \ ∅$$6x∅2mm (mesure au microscope confocal, Cut-off = Traverse length)])

On propose de définir des grandeurs pour la caractériser. On travaille sur une longueur d'étude de 200 $mu m$  : 

#figure(image("Illustrations\Profil_SS_unfiltered_zoom.png"),
 caption :[Profil non filtré de la surface intérieure d'un tube en acier inoxydable \ ∅$$6x∅2mm (mesure au microscope confocal, Cut-off = 200 $mu m$)])

= Mouillabilité

