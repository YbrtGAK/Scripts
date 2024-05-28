#import "@local/bon_commande_template:1.0.1" : *

#show: bdc(
//Entrées utilisateur
 nom_fournisseur : "CETIAT - Madame Maelle NICOLAS",
 tel_fournisseur : "33.(0)6.17.06.96.20",
 mail_fournisseur : "metrologie@cetiat.fr",

 L_produits : (
  (nom : "Etalonnage PA23 KELLER p1 (0 - 30 bars)", Qte : "1", prixHT : 189),
  (nom : "Etalonnage PA23 KELLER p1 (0-35 bars)", Qte : "3", prixHT : 189),
  (nom : "Etalonnage PD23 KELLER p1 (0-5 bars)", Qte : "1", prixHT : 189),
  (nom : "Etalonnage 3051 Emmerson Rosemount p2 (0-2 bars)", Qte : "1", prixHT : 315),
  (nom : "Etalonnage 3051 Emmerson Rosemount p2 (0-50 mbars)", Qte : "1", prixHT : 315),
)
)
