#import "@local/bon_commande_template:1.0.1" : *

#show: bdc(
//Entrées utilisateur
 nom_fournisseur : "DELL - Mathilde Mercier",
 tel_fournisseur : "N/A",
 mail_fournisseur : "Mathilde.Mercier@Dell.com",

 L_produits : (
  (nom : "Precision 3680 Tour CTO Basique ", Qte : "1", prixHT :1765.68),
  (nom: "Contribution environnementale", Qte:"1", prixHT:1.32),
  (nom : "Frais de port", Qte:"0", prixHT:0)
)
)
