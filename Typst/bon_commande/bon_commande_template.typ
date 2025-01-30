#import "@preview/tablex:0.0.6": tablex, colspanx, rowspanx, cellx

#let bdc(
  //Entrées utilisateur
 nom_fournisseur : "Fournisseur",
 tel_fournisseur : "00.00.00.00.00",
 mail_fournisseur : "fournisseur.nom@insa-lyon.fr",

 nom_demandeur : "Yann BERTON",
 tel_demandeur : "+33.(0)7.83.77.07.46",
 mail_demandeur : "yann.berton@insa-lyon.fr",

 L_produits : (
  (nom : "Désignation n°1", Qte : "1", prixHT : 1),
  (nom : "Frais de port", Qte : "1", prixHT : 0),
)
) = {

set page(margin:(top:1cm,bottom:0.5cm,left:0.5cm,right:0.5cm))
import "@preview/tablex:0.0.6": tablex, colspanx, rowspanx, cellx
let cent(it) = align(center)[#it]

//Place le logo
grid(
  columns:(auto,auto),
 h(2cm),  image("logo_cethil.png", width:4.63cm, height:1.3cm) 
)

//Calule le montant HT et le montant TCC globaux
let it = 1
while it <= L_produits.len() {
  (L_produits.at(it - 1).montantHT = calc.round(float(L_produits.at(it - 1).Qte)*float(L_produits.at(it - 1).prixHT), digits: 2))

  (L_produits.at(it - 1).montantTTC = calc.round(L_produits.at(it - 1).montantHT*1.1,digits:2))

  (L_produits.at(it - 1).montantTVA = calc.round(L_produits.at(it - 1).montantTTC - L_produits.at(it - 1).montantHT,digits:2)) 
  (L_produits.at(it - 1).prixHT = calc.round(float(L_produits.at(it - 1).prixHT), digits: 2) )
  
  it = it + 1}
let LmontantHT = ()
let LmontantTTC = ()
let LmontantTVA = ()
let globMontantHT = 0
let globMontantTTC = 0
let globMontantTVA = 0

//On ajoute ces infos également dans des listes
for e in L_produits {
  LmontantHT.push(e.montantHT)
  LmontantTTC.push(e.montantTTC)
  LmontantTVA.push(e.montantTVA)
  globMontantHT = globMontantHT + e.montantHT
  globMontantTTC = globMontantTTC + e.montantTTC
  globMontantTVA = globMontantTVA + e.montantTVA
}
{
globMontantHT = calc.round(globMontantHT,digits:2)  
globMontantTTC = calc.round(globMontantTTC, digits:2) 
globMontantTVA = calc.round(globMontantTVA, digits:2) 
}
//On ajoute un produit appelé "total" avec les valeurs totales
L_produits.push((nom : "Total", Qte : "/", prixHT : "/", montantHT:[*#globMontantHT €*], montantTTC : [*#globMontantTTC €*], montantTVA : [*#globMontantTVA €*]))

//Texte en rouge et en gras
{
 set text(font:"Times", fill:red,size:18pt)
 show : it => cent[#it]
 [*BON DE COMMANDE \ À remettre au secrétariat*] 
}
//Tableau

//Cellule Fournisseur / Demandeur 
let cell_db = cellx(colspan: 2,rowspan:2)[
#{
set text(size:14pt)
show: it => underline(it)
[_*FOURNISSEUR :*_  ]
h(8pt)
}
#nom_fournisseur \
\
Tél : #tel_fournisseur \
Mail : #mail_fournisseur \
\
#{
set text(size:14pt)
show: it => underline(it)
[_*DEMANDEUR :*_  ]
h(8pt)
}
#nom_demandeur \
\
Tél : #tel_demandeur \
Mail : #mail_demandeur \
\
]

//Grande cellule
let i=1
let Lmontant = ()
let Tab = {
  
tablex(
columns : L_produits.at(1).len(),
rows :  L_produits.len() + 1,
align:center+horizon,
map-rows: (row, cells) => cells.map(c =>
    if c == none {
      c  // keeping 'none' is important
    }
    else if c.x==0 and c.y==0{
      (..c, content: [Désignation])
    }
    else if c.x==1 and c.y==0{
      (..c, content: [Quantité \ [-]])
    }
    else if c.x==2 and c.y==0{
      (..c, content: [Prix HT \ [€/unité]])
    }
    else if c.x==3 and c.y==0{
      (..c, content: [Montant HT \ [€]])
    }
    else if c.x==4 and c.y==0{
      (..c, content: [Montant TVA \ [€]])
    }
    else if c.x==5 and c.y==0{
      (..c, content: [Montant TTC \ [€]])
    }
    else if c.y>0 and c.x==0{
      (..c, content: [#L_produits.at(c.y - 1).nom])
    }
    else if c.y>0 and c.x==1{
      (..c, content: [#L_produits.at(c.y - 1).Qte])
    }
    else if c.y>0 and c.x==2{
      (..c, content: [#L_produits.at(c.y - 1).prixHT])
    }
    else if c.y>0 and c.x==3{
      (..c, content: [#L_produits.at(c.y - 1).montantHT])
    }
    else if c.y>0 and c.x==4{
      (..c, content: [#L_produits.at(c.y - 1).montantTVA])
    }
    else if c.y>0 and c.x==5{
      (..c, content: [#L_produits.at(c.y - 1).montantTTC])
    }
    else {
      (..c, content: {
        [R] 
      [#row]
    })}),)}

let rect = rect(width:220pt,height:110pt)[#align(center+top)[#text(fill:red,size:12pt, font:"Times")[*SIGNATURE DU RESPONSABLE*]]]
    
let grd_cell = cellx(colspan: 3)[
\
#show ".": ","
#cent[#Tab]
#align(bottom + center, rect)

\

]

{
tablex(
  columns: (5.4cm,1fr,1fr),
  rows:(auto,1.7cm,4cm,15cm),
  colspanx(3)[#text(size:20pt)[#cent[*A REMPLIR PAR LE PERMANENT :*]]],
  text(size:14pt)[*Date : * #datetime.today().day()/#datetime.today().month()/#datetime.today().year()], cell_db, 
  text(size:12pt)[*DEPENSE A \ PRENDRE SUR LE \ CONTRAT : *],
  grd_cell, 

)
  
}
  
  }



