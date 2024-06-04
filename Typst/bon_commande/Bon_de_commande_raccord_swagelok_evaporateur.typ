#import "@local/bon_commande_template:1.0.1" : *

#show: bdc(
//Entrées utilisateur
 nom_fournisseur : "SWAGELOK - Xavier Chautard",
 tel_fournisseur : "+33 6 82 46 05 84",
 mail_fournisseur : "xavier.chautard@swagelok.com",

 L_produits : (
  (nom : "SS-6M0-6 - UNION DOUBLE INOX EN 6 MM SWAGELOK", Qte : "3", prixHT :16.50),
  (nom : "SS-6M0-SET - JEU DE BAGUES AV/AR INOX 316 EN 6MM OD", Qte : "40", prixHT : 2.82),
  (nom : "SS-6M2-1 - ECROU - INOX 316 6 MM OD", Qte : "40", prixHT : 2.85),
  (nom : "Frais de port", Qte:"1", prixHT:28.00)
)
)
