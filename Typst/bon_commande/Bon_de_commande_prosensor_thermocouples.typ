#import "@local/bon_commande_template:1.0.1" : *

#show: bdc(
//Entrées utilisateur
 nom_fournisseur : "ICMF 2025",
 tel_fournisseur : "N/A",
 mail_fournisseur : "icmf@toulouse-inp.fr",

 L_produits : (
  (nom : [Frais de réservation \ pour l'ICMF 2025 [étudiant]], Qte:1, prixHT:500-83.33),  
  (nom : "Dîner de Gala", Qte:1, prixHT:90-15),
))