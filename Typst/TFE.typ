//Ce script a pour but de produire mon rapport de travail de fin d'Etudes

#let rouge = it => text(fill:red)[#it]

#set text(font: "Arial", size:11pt) //Choix de la police d'écriture
#set math.equation(numbering:none)

//Mise en forme des titres
#show heading.where(level: 1) : it => block(width: 100%)[
  #set align(left)
  #set text(18pt, weight: "regular")
  *#it*]

//Mise en forme des équations énumérées
#show math.equation.where(numbering: "(1)") : it => grid(
  columns : (1fr,3fr,1fr),
  [],
  math.equation(block : true)[#rect(inset:10pt)[#it.body]],
  align(right + horizon, "(" + str(counter( math.equation).at(it.location()).first())+ ")"))

//Mise en forme des références aux figures
#show ref: it => {
  let eq = figure
  let el = it.element
  if el != none and el.func() == eq {
    // Override equation references.
    "figure "
    numbering(
       el.numbering,
      ..counter(eq).at(el.location())
    )
  } else {
    // Other references as usual.
    it
  }
}

//Modification de l'affichage des listes
#set list(marker: ([•], [--], [\u{25CB}], [$->$], [\*]))

//Création de la variable titre
#let title = [
  Modélisation et optimisation technico-économique d'unités de production d'énergie bas-carbone sur sites industriels]

//************************************************************
//                         Page de garde
//************************************************************
#let page_de_garde(title) = [
 #set page(
  margin: (top: 2.5cm,left : 2.5cm,  bottom: 2.5cm, right:2.5cm),)
                            ]
                      
#let auteur = [Yann Berton]

#grid(
  columns: (1fr, 1fr),
  align(center)[
 #figure(image("Logo/page_de_garde.jpg",height: 2.25cm, width:7.12cm), numbering: none
  )
  #align(left)[#v(-20pt) #h(18pt) École Centrale de Lyon\ 
                         #h(18pt)TFE 2023] 
  ],
  align(center)[#v(14pt)
 #figure(image("Logo/absolicon.png", width: 7.12cm),
    numbering: none)
     #align(right)[#v(-8pt) Absolicon AB Solar Collector #h(12pt)\ Härnösand, Suède #h(12pt)] 
  ]
)
#align(center)[#text(size:14pt)[#v(30pt) *Rapport de Travail de Fin d'Études* #v(5pt)]]
#align(center)[#text(size:18pt)[#v(12pt) *#title* #v(3pt)]]
#align(center)[#emph(text(size:11pt)[#v(12pt) BERTON Yann  #v(3pt)])]
\
\
\
\
#figure(
  table(inset:0pt,image("Illustrations/Absolicon_Peroni.jpg",width: 15.88cm,height:7.94cm),stroke:3pt),
  numbering: none
         )
\
#align(left)[Fillière : Energie, Conception des Installations]
#align(center,rect(width:17.7cm)[#align(left)[Tuteurs : \
ECL : #h(120pt) CONSTANT Damien \
CEA : #h(119pt) LEFRANCOIS Florent \
Absolicon AB Solar Collector : #h(8pt) GAMBARDELLA Andrea
]])

#page_de_garde
#pagebreak()

#let validation_page_header = [
  #grid(
  columns: (1fr, 1fr),
  align(bottom)[
     #image("Logo/page_de_garde.jpg")],
  align(center + top)[
  #text(font:"Tahoma",fill:red,size:16pt)[#v(20pt) *Final Year Internship*]
  #text(font:"Tahoma",fill:red,size:14pt)[#v(7pt) Academic year 2022-2023]
  ]
)
]

//************************************************************
//                      Page de validation
//************************************************************

#let validation_page_header = [
  #grid(
  columns: (1fr, 1fr),
  align(bottom)[
     #image("Logo/page_de_garde.jpg")]
        ,
  align(center + top)[
  #text(font:"Tahoma",fill:red,size:16pt)[#v(20pt) *Final Year Internship*]
  #text(font:"Tahoma",fill:red,size:14pt)[#v(7pt) Academic year 2022-2023]
  ]
)
]

#let validation_page(title) = [

  #set text(font:"Tahoma")
  #set list(indent:0.63cm)
  
  #set page(
    margin: (top:5cm,left : 2.5cm,  bottom: 0.32cm, right:2.5cm),
    header: validation_page_header,
    header-ascent: 60%
          ) 
#text( size : 8pt)[This form should be inserted after the cover page of the FYI Report. It certifies that the Report has been validated by the firm and can be submitted as it stands to the Registrar’s Office of Ecole Centrale de Lyon. #v(8pt)]

#align(center)[#v(36pt) #underline(text(size:16pt)[*COMPANY VALIDATION OF FYI REPORT*]) #v(36pt)]
#underline(text(size:12pt)[Final Year Internship references])

#v(30pt)
Student’s name: BERTON Yann \ #v(10pt)
Report title: #title \ #v(10pt)
Firm: Absolicon AB Solar Collector \ #v(10pt)
Name of Company Tutor: GAMBARDELLA Andrea \ #v(10pt)
Name of School Tutor: CONSTANT Damien \ #v(10pt)

#line(length: 75%) \
#v(30pt)
#par(first-line-indent: 0.63cm,hanging-indent:0.63cm)[
The company acknowledges having read the report mentioned above and authorizes its transmission to the Ecole Centrale de Lyon. 

The company authorizes the distribution of the report on the catalog of the library of the Ecole Centrale de Lyon: 
- Information on the TFE (title – author – keywords – summary…) will be public 
- Access to the pdf report, upon authentication, will be limited to students and staff of the Ecole Centrale de Lyon.]
#v(20pt)
  #grid(
  columns: (1fr, 1fr),
  align(left)[
    #text()[
      Firm's representative \
    Name : GAMBARDELLA Andrea \
  Position : Innovation engineer]
  ],
    align(left)[
    #text()[
      #h(11pt) Date : \ 
    #h(11pt) Signature and stamp:  ]
  ]
      )
  ]
  
#validation_page(title)
#pagebreak()

//************************************************************
//                    En-tête et bas de page
//************************************************************

#let page_header = [
  #align(horizon + center)[#text(font:"Arial", size:9pt, fill:gray)[#title]]
]

#let page_footer = [
    #grid(
  columns: (1fr, 1fr, 1fr),

  align(
    left + horizon,
    image("Logo/header_ecl.jpg", width:50%))
  ,
  align(center+horizon, text(font:"Arial", size:9pt, fill:gray)[BERTON, Yann | TFE | 2023])
  ,
  align(right+horizon)[#text(font:"Arial", size:9pt, fill:gray)[#counter(page).display()]])
 ]

#set page(header : page_header,
footer :page_footer,
    margin: (top:2.5cm,left : 2.5cm,  bottom: 2.5cm, right:2.5cm))

    
//************************************************************
//                      Remerciements
//************************************************************
= *Remerciements*
\
 Associer des études en alternance et le monde de la recherche est assez peu commun. J'ai souhaité acquérir les compétences nécessaires pour être ingénieur tout en me formant aux méthodes de recherche, en thermique, et en programmation. Si j'ai pu choisir exactement la formation d'ingénieur qui me convenait, c'est grâce à la confiance que m'ont accordée mes encadrants,  tant du côté académique que professionnel.
 
 Ainsi, je souhaite remercier M.Constant de m'avoir accepté dans la formation et de m'avoir suivi pendant ces trois années. Merci de m'avoir guidé dans mon projet professionnel et d'avoir accueilli mon enthousiasme avec bienveillance.
 
 Merci à toi Florent de m'avoir laissé une liberté sans faille (même si cela implique le traitement via python de tous les résultats des manips abso du labo). Partager le bureau avec toi pendant deux ans et demi a été un réel plaisir. Merci de m'avoir appris le métier et de m'avoir permis de comprendre la réalité des installations.

 Thank you Andrea GAMBARDELLA for welcoming me in Absolicon. Our discussions on thermodynamic matter and computing were a real pleasure. And thank you for your gift, it was truely appreciated by my familly and I :). 

 Finalement je souhaite remercier mes collègues du CEA, notamment Bertrand pour m'avoir appris beaucoup de choses; de celles qui permettent une prise de recul entre théorie et pratique. En ce sens, merci Romain de m'avoir laissé câbler mon expérience sur les capteurs l'an dernier, j'étais aux anges. Merci Fabien pour toutes les discussions sur la musique, j'espère avoir pu lever quelques questionnements que tu avais sur les "djeuns". Merci à toi Fabio, pour les pauses cafés, pour m'avoir hébergé tant de fois, et pour les discussions sur le voyage et la science. Merci Simon de montrer qu'on peut rêver et réaliser, j'essaierai d'être à la hauteur de ta fougue. Egalement, merci à Nathalie et Cédric pour votre accueil et vos conseils. Merci à celles et ceux que je n'ai pas pu citer et qui ont participé.e.s à mon épanouissement ces trois dernières années.

 A titre plus personnel, je remercie M.Clément de m'avoir donné goût à la physique en seconde comme en terminale.
 
 Je remercie mes parents pour leur soutien inconditionnel, ma mère pour les petits moments dans la cuisine à parler de physique (le début de tout), mon père pour m'avoir transmis sa persévérance et sa curiosité. Merci de m'avoir permis de faire des études.

 Merci Loïc d'avoir relu toutes les fautes de mes rapports malgré les maths qui s'y immiscent. Un laborieux travail qui mérite enfin d'être récompensé.

 Je remercie mes amis Romain Guérin et Rémi Boire d'avoir vécu cette page de vie avec moi, chacun dans son école.

 Merci Malaury de m'avoir aidé à traverser les moments difficiles et permis d'en arriver là, je sais ce que je te dois.

 Enfin merci Sylvie et Antoine d'avoir toujours été là pour moi, sans concession. Je n'arriverai jamais à vous le rendre entièrement.

 Je dédis ce rapport à Guillaume.


#pagebreak()

//************************************************************
//                     Résumé/Abstract
//************************************************************
#heading(outlined:false)[*Résumé*]
Ce rapport présente la simulation développée pour Absolicon AB Solar Collector dans le cadre de ce stage de fin d'études. Également, il dresse une méthodologie de dimensionnement d'une unité de production d'énergie bas-carbone. Une méthode mono-objective simple est tout d'abord proposée. Cependant, elle ne permet pas d'inclure les moyens de production intermittents comme les centrales solaires thermiques. De plus, les pertes thermiques ne peuvent pas être prises en compte avec précision. Cela augmente l'incertitude des prédicitons de productible pour les unités thermiques.

Ces deux contraintes ont justifié le développement d'une simulation d'unité semi-physique. Une comparaison avec les mesures sur une centrale solaire existante a été réalisée par le département "process" qui a validé l'outil. Finalement, il a permis de réaliser un prédictif de productible dont le résulat est donné ci-après : 

#figure(numbering:none,
  table(stroke:1.5pt,
  image("Illustrations/latina_resultats.png", width:11cm)))

Également, des méthodes métaheuristiques ont été testées pour optimiser le problème de dimensionnement des conduites d'un champ solaire. L'algorithme de différentiation génétique de la libraire scipy (python) a réduit le coût estimé de la tuyauterie de 10% en proposant la distribution des débits suivante : 

#figure(numbering:none,
  table(stroke:1.5pt,
  image("Illustrations/opti_capteurs_solaires_jonathan_disposition.png", width:11cm)))

 \
 \
#pagebreak()

#heading(outlined:false)[*Abstract*]
This report presents the simulation developed for Absolicon AB Solar Collector as part of this final year internship. It also sets out a methodology for sizing a low-carbon energy production unit. First of all, a simple mono-objective method is proposed. However, it does not allow intermittent means of production such as solar thermal power stations to be included. Also, heat losses cannot be taken into account accurately. This increases the uncertainty in predicting deliverability for thermal units.

These two constraints justified the development of a semi-physical unit simulation. A comparison with measurements on an existing solar power plant was carried out by the "process" department, which validated the tool. It was also used to produce a predictive field, the result of which is shown below: 

#figure(numbering:none,
  table(stroke:1.5pt,
  image("Illustrations/latina_resultats.png", width:11cm)))

Futhermore, metaheuristic methods were tested to optimise the pipe sizing problem for a solar field. The genetic differentiation algorithm of the scipy library (python) reduced the estimated cost of the piping by 10% by proposing the following flow distribution: 

#figure(numbering:none,
  table(stroke:1.5pt,
  image("Illustrations/opti_capteurs_solaires_jonathan_disposition.png", width:11cm)))
#pagebreak()

//************************************************************
//                    Table des matières
//************************************************************
#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(text(font :"Times New Roman", size:12pt)[#it])
  
}

#outline(
  title : heading(outlined:false,numbering: none)[#text(size:18pt)[*Table des matières*]],
  depth : 2,
  indent : auto
)
#pagebreak()

//************************************************************
//                    Table des illustrations
//************************************************************
#outline(
  title : heading(outlined:true, numbering: none)[*Table des figures*],
  target : figure
)
#pagebreak()

//************************************************************
//                        Glossaire
//************************************************************
= Glossaire
\

- *Charge* : Besoin en énergie d'un site industriel dans le temps.

- *Dictionary* (En français : dictionnaire) : Collection d'objets non-ordonnées ayant chacun une clef et une valeur.

- *Exergie* : La part d'une source d'énergie donnée valorisable sous forme mécanique.

- *Getter* : Méthodes naïves attribuées à une variable permettant de déclencher une méthode setter à chaque fois que la variable est modifiée.

- *IEA* : International Energy Agency

- *IDE* : Environnement de développement intégré (ex : Visual Studio Code, Anaconda).

- *Irradiance* : Densité de flux de chaleur en W/m². L'irradiance solaire est donc la densité de flux de chaleur provenant du soleil. 
  Sont distinguées :
  - L'irradiance directe : Irradiance venant uniquement du soleil
  - L'irradiance diffuse : Irradiance venant de la réflexion de l'irradiance directe sur l'environnement et de la radiation thermique de l'environnement.

- *Irradiation* : Chaleur obtenue du soleil pour une surface et un temps donnés [J/m²] ($integral^(t)_0("Irradiance")."dt"$).

- *Masque solaire* : Le masque solaire d'un endroit est l'ensemble des éléments de l'environnement pouvant ombrager sa surface pendant la journée.

- *Levelized Cost of Heat* (LCOH, ou coût moyen de la chaleur) : Coût d'un kWh de chaleur produite en prenant en compte le coûts d'investissement, les coûts de fonctionnement et les subventions.

- *Pompe-à-chaleur* (ou "PaC") : Machine thermodynamique ditherme permettant de produire de manière réversible de la chaleur à partir d'électricité, d'une source froide et d'une source chaude.

- *Setter* : Méthode naïve attribuée à une variable déclenchée par la méthode getter de cette dernière.

- *Unité de production d'énergie industrielle* (ou "unité"): Ensemble de systèmes permettant de produire #text(style:"italic")[in situ] une partie ou la totalité des besoins énergétiques du site industriel.

- *Vase d'expansion* : Composant d'un circuit hydraulique garantissant une pression fixe dans les conduites lors de la chauffe du fluide caloporteur. Il absorbe ou restitue un volume de fluide correspondant à la dilatation thermique. 

#pagebreak()
//************************************************************
//                        Introduction
//************************************************************
#heading(outlined:true, numbering:none)[*Introduction*]
La production de chaleur pour les procédés industriels représente une part importante de la production totale d'énergie dans l'industrie. En France, cette part représentait 60% en 2020 #footnote[Source ; CEREN]. La @mix_energetique_industrie_france donne pour la même année le mix énergétique qui y est associé : 

#figure(table(
  image("Illustrations/industrie-CGDD.svg", width:80%)) ,
  caption :[Mix énergétique de l'industrie française en 2020],
  kind:image) <mix_energetique_industrie_france>

L'industrie fait face à trois enjeux : 
- La pollution engendrée par les activités industrielles participe activement au changement climatique,
- La raréfaction de la ressource pétrolière tend les sociétés à se tourner vers d'autres ressources énergétiques,
- La fluctuation du prix du baril de pétrole et des produits pétroliers complique l'estimation du chiffre d'affaire des entreprises.

Ainsi, le remplacement des moyens de productions d'énergies fossiles (dont les chaudières) par des solutions bas-carbones et sur site devient une nécessité. Elles permettent de rendre les sites industriels autonomes (ou quasis-autonomes) vis-à-vis du marché de l'énergie et de décarboner leur production.

Parmi ces solutions, les centrales solaires thermiques à concentration permettent de fournir de la chaleur renouvelable à haute température ( \~ 160°C) aux procédés industriels. Bien que leur coût d'investissement soit élevé, la gratuité de l'irradiance solaire permet de baisser les coûts de fonctionnement et donc le coût global du kWh de chaleur. 

Cependant, ces infrastructures sont imposantes, complexes et sujet à l'intermittence de la ressource solaire. Pour y pallier, des moyens de stockage de la chaleur, voire d'autres moyens de production doivent être employés.

Leur conception, leur production et leur l'installation est l'expertise d'Absolicon AB Solar Collectors, une entreprise suédoise.  Elle développe depuis 20 ans un capteur solaire à concentration industriel, des lignes de production et un savoir-faire industriel. La simulation de ces unités de production d'énergie solaires et industrielles est une de ses compétences clefs nécessaire à la réalisation des études de pré-faisabilité.

L'objectif premier de ce rapport est de présenter la simulation dévellopée à Absolicon pendant le stage de fin d'études. En parallèle, il vise à établir une méthodologie générale de dimensionnement d'unités de production d'énergie industrielles. Finalement, il présente une ouverture sur l'optimisation économique de leur dimensionnement par des méthodes méta-heuristiques.
#pagebreak()

//************************************************************
//                         Chapitre 0
//************************************************************
#set heading(numbering: "I.1.a.")
#set par(justify: true)

= Présentation de l'entreprise d'accueil Absolicon AB Solar Collectors

== L'entreprise

Absolicon Solar Collector AB est une société créée en 2005 par Joakim Byström, ingénieur et entrepreneur suédois originaire d'Härnösand. C'est dans cette ville qu'il a fondé l'entreprise, enregistrée comme société de recherche et développement à ses débuts. Depuis une dizaine d'années, elle multiplie les projets avec l'industrie dont notamment les brasseurs de bières Peroni et Carlsberg.

#figure(table(inset:0pt,stroke:3pt,
  image("Illustrations/Absolicon_Peroni.jpg"
, width:13cm)) ,
  caption :[Centrale solaire Absolicon d'une brasserie Peroni en Italie],
  kind:image) <Absolicon_Peroni>

Elle est côtée en bourse et a réalisé un chiffre d'affaire de 3 millions d'euros en 2022.

À aujourd'hui, 20 installations ont été réalisées sur 3 continents, représentant près de 6000 mètres carrés de surface installée. L'ouverture sur l'internationale est présente également dans la composition de l'entreprise avec une part importante de salarié.e.s étranger.ère.s parmi les 30 employé.e.s. L'effectif est réparti sur 3 villes suédoises : Härnösand, Gothenburg, et Stockholm.

== Mise en contexte succinte du marché de l'énergie
L'utilisation d'énergie, à la base de tous les procédés industriels, est toujours hautement carbonnée. L'industrie et la société dans son ensemble cherchent à articuler l'utilisation d'énergie autour de moyens bas-carbones. Jusqu'alors, plusieurs problèmes s'y opposaient : 
-  Les énergies renouvelables sont intermittentes et nécessient des moyens de stockage et d'autres moyens de production pour une production en continue,
-  Le prix du baril de pétrole était bas et stable dans le temps (voir @eia_oil_crude). De plus l'utilisation d'infrastructures complexes est chronophage et coûteuse. Par conséquent, malgré une énergie primaire solaire gratuite, les retours sur investissement étaient trop élevés par rapport aux solutions fossiles de référence.

#figure(table(inset:0pt,stroke:3pt,
  image("Illustrations/eia_prices_crude.png"
, width:13cm)) ,
  caption :[Evolution des prix du baril de pétrole sur le marché international#footnote()[Source : U.S. Energy Information Administration (eia.gov)]],
  kind:image) <eia_oil_crude>

Ce graphique met également en lumière la fluctuation récente des prix du baril. Or, les industriels ont besoin de coûts stables pour organiser la production sur l'année. 

Le contexte économique et écologique pousse l'industrie à réétudier des projets d'unités de production bas-carbones, dont les centrales solaires. En effet, être indépendant en énergie est un moyen pour un industriel d'assurer sa production et de maîtriser ses coûts, indépendemment du marché de l'énergie.
  
== Activité et produits
Après 20 ans de recherche dont 10 ans d'expérience opérationnelle, la compagnie a mis au point un capteur cylindro-parabolique appelé T160 : 

#figure(table(inset:0pt,stroke:3pt,
  image("Illustrations/photo_T160.jpg"
, width:13cm)) ,
  caption :[Photo capteurs solaire thermiques à concentration T160],
  kind:image) <T160>

Il permet d'atteindre des températures jusqu'à 160°C pour un facteur optique $eta_0$ de 76,4%. Ci-dessous sont présentés les résultats des tests effectués sur le capteur par le label international solarkeymark : 

#figure(table(stroke:none,
  image("Illustrations/solarkeymark_T160.png",width:13cm
)) ,
  caption :[Résultats de l'étude de performances du T160 par Solarkeymark],
  kind:image) <Absolicon_Peroni>

Cependant, son produit principal est une ligne de production de collecteurs. Un capteur peut être produit toutes les six minutes  à bas coût et facilement transportable (camions et bâteaux).

Le plan d'affaires de l'entreprise est le suivant :

1.  Absolicon démarche des industriels ayant une usine utilisant des énergies fossiles, 
2.  Si le site est propice à l'implantation d'une centrale solaire, une étude de pré-faisabilité est conduite,
  - Elle inclut la simulation du productible et de son coût global pour plusieurs configurations satisfaisant les besoins en énergie du client,
  - Une proposition lui est faite et la phase de pré-faisabilité est terminée,
3. S'il accepte, une phase de prospection commence :
  - Absolicon cherche des industriels intéressés pour produire des capteurs,
  - L'entreprise vend les lignes de production et un savoir-faire : assemblage et utilisation des lignes de production,
  - Les capteurs ainsi construits sont vendus par le second industriel au premier.

== L'équipe

L'organisation de l'entreprise est la suivante :

- Le Management
  - Joakim Byström, CEO
  - Carlo Semeraro, Chief Sales Officer
  - Jonatan Mossegård, Chief Technical Officer – Industrialisation
  - Benjamin Ahlgren, Chief Technical Officer – Heat Processes

-  Le conseil,
  - Olle Olsson, Chairman of the Board
  - Joakim Byström, CEO
  - Stefan Johansson
  - Anna Sundgren

- Le département innovation et vente,
- Le département "process",
- Le département de recherche et développement.

== Raison d'être

L'entreprise souhaite verdir la production d'énergie mondiale. Elle ne cesse d'augmenter à mesure que les conditions de vie s'améliorent de part le monde. Une production d'énergies bas-carbone, locale et renouvelable est une manière d'assurer une répartition équitable pour toutes et tous. Produire de l'énergie de manière soutenable n'est donc pas seulement une volonté d'Absolicon, c'est une ambition mondiale que l'entreprise a choisi de porter.

== Motivation du stage

L'expérience de terrain d'absolicon, couplée à son logiciel de simulation, lui permet de dimensionner les centrales solaires répondant aux besoins du client. Le département innovation et vente, à l'origine de ces travaux de pré-dimensionnement, souhaite revoir l'outil pour proposer une meilleure estimation du productible. 


#pagebreak()
//************************************************************
//                         Chapitre 1
//************************************************************

#heading(outlined:true)[*Conception d'une unité de production d'énergies*]
\
Le dimensionnement des unités de production d'énergie est un savoir-faire essentiel de l'industrie. L'introduction de moyens de productions intermittents comme les énergies renouvelables ont contraint les entreprises à diversifier leurs outils. Dans ce chapitre, une méthode de dimensionnement classique est présentée. Elle permet de justifier du choix des variables d'intérêt et de présenter les raisonnements logiques sous-jacents au dimensonnement de ces installations.

== Analyse du besoin en énergie : notion d'exergie
Comme énoncé précédemment, la production de chaleur réprésente une part majeure du mix énergétique des procédés industriels. Chacun d'eux nécessite un apport de chaleur à une température donnée. Par exemple, le brassage de la bière s'effectue à 62°C et la purification du cuivre par zone fondue à 1 080 °C minimum. Cependant, ils sont généralement multiples au sein d'une usine : il est souvent nécessaire de produire de la chaleur à différent niveaux de température.\

Le terme générique pour qualifier ces différentes sources de chaleur est "la qualité de la chaleur". Plus la température de la source est élevée, plus grande est sa qualité. Pour autant, la température est une grandeur insuffisante pour la décrire. Ainsi définie, elle ne peut pas être utilisée pour comparer de la chaleur à une température donnée avec de l'énergie mécanique, électrique ou chimique.\

Pour pallier à ce défaut, les thermodynamicien.nes ont introduit la notion d'exergie. Elle est définie comme la part d'énergie valorisable sous forme mécanique d'une source d'énergie donnée. Sa valeur est donc supérieure ou égale à son travail. Cette grandeur n'est pas intrinsèque et dépend de l'environnement de la source étudiée. Par exemple, une source à 30°C ne peut pas échanger de chaleur avec une atmosphère à 35°C. Par conséquent on fixe l'exergie nulle quand le système est à l'équilibre thermique, mécanique et chimique. Il en existe une définition mathématique; elle présente cependant peu d'intérêt en l'absence de sa démonstration qui surchargerait ce document.  Pour plus d'informations, les lecteurs et lectrices peuvent consulter la source @noauthor_thermodynamique_nodate.

Finalement, on appelle charge la puissance à fournir à un site industriel au cours du temps. Elle est la somme de toutes les puissances requises par chaque besoin d'énergie pouvant être satisfait par une même source. Cette notion permet de se passer de calculs exergétiques et donc de faciliter les méthodes. Il faut maintenant définir l'ensemble des systèmes permettant d'y répondre.

== Définition d'une unité de production d'énergies industrielle

Une unité de production d'énergie industrielle est définie comme un ensemble de systèmes permettant de produire #text(style:"italic")[in situ] une partie ou la totalité des besoins énergétiques du site industriel. La @Schema_exemple_unite schématise un exemple d'unité comportant une liste non-exhaustive de systèmes énergétiques (pompe à chaleur, chaudière, champ solaire, ...) connectés à une chaufferie, à une centrale solaire, ou encore à un ensemble électrique. Cette dernière restitue à chaque procédé l'énergie qui lui est nécessaire.
#figure(
  table(image("Illustrations/Schéma unité de production energie industrielle.jpg", width: 90%)),
  caption: [Schéma d'un exemple d'unité de production d'énergie industrielle],
  kind : image) <Schema_exemple_unite>
  
Dans ce document, les unités étudiées permettent de produire de la chaleur. Portée à haute température, elle peut servir à la production d'électricité. Pour cela, de la vapeur est générée (puis souvent comprimée) et injectée dans une turbine.

=== Définition d'une centrale solaire thermique
Une centrale solaire thermique est une unité de production d'énergies industrielle possédant un champ solaire thermique. Les contraintes techniques dues à l'intermittence de sa production implique une architecture particulière (dont notamment un stockage thermique). Il convient de la détailler pour comprendre son pilotage et les choix de modélisation. \

Les procédés industriels nécessitent en grande majorité des températures de chauffe supérieures à 100°C. Par conséquent, ces champs solaires thermiques sont dotés la plupart du temps de capteurs à concentration. Une telle installation peut être représentée comme suit :

#figure(
  table(image("Illustrations/centrale_solaire_thermique.png", width: 73%)
),
  caption: [Exemple de centrale solaire thermique],
  kind : image) <centrale_solaire_thermique>

On distingue le champ solaire composé des capteurs, d'une conduite amenant l'eau de départ (upstream solar pipe) aux collecteurs ainsi qu'une seconde conduite pour le retour de l'eau (downstream solar pipe).\ 
Un échangeur de chaleur (heat exchanger) permet de stocker le surplus de production de chaleur du champ solaire dans le ballon (thermal storage). Un autre échangeur permet de déstocker la chaleur contenue dans le ballon vers la zone des procédés, elle-même dôtée d'un échangeur. Cela permet de pallier à l'intermittence de l'irradiance solaire. \ A l'instar du champ solaire, elle dispose d'une conduite amont (upstream client pipe) et d'une conduite aval (downstream client pipe).

== Dimensionnement d'une unité de production industrielle <methode_monoobjective>
Le dimensionnement d'une unité de production doit permettre de répondre à la charge#footnote()[Voir glossaire] <fn_gloss2> pour un ensemble de systèmes de production défini au préalable. Dans un premier temps, il est nécessaire de les caractériser. Puis, une optimisation mono-objectif est proposée pour les dimensionner. La méthode utilisée dans ce document s'appuie sur un cours d'énergétique dispensé par Elin Svensson en source @elin_system_2016. 

=== Caractérisation des composants
Une méthode générique doit être utilisée pour caractériser des composants d'énergies primaires et/ou de sortie différentes. De plus, elle doit prendre en compte le fait qu'un composant donné de l'unité peut ne pas fonctionner toute l'année et voir sa puissance varier.\

Soit un composant j pour lequel sont distingués : \

*Des paramètres intrinséques * :
- $#sym.Kai _j$ : Le coût d'investisemment spécifique en \$/kW, 
- $b_j$ : Le coût spécifique de production en  \$/$"MWh"_"produits"$,
- $c_j$ : L'émission spécifique de GES en $"kg"_"eq,CO"_2$/MWh.
*Des paramètres de dimensionnement* :
- $P_j$ : La puissance nominale en kW,
- $M_j$ : L'énergie annuelle produite par l'installation en MWh.

Le coût annuel d'une installation ainsi définie peut être décomposé en la somme d'un coût fixe annuel et d'un coût de fonctionnement annuel. Dans la suite de cette section, il est proposé de modéliser ces coûts. 

#underline()[Modélisation du coût fixe annuel]\
Le coût fixe annuel consiste en l'amortissement du coût d'investissement. Pour le calculer, il est nécessaire d'introduire le facteur d'annuité défini comme suit :
$ r_j eq.est i_j*(1+i_j)^(n_j)/((1+i_j)^(n_j) - 1) $
où : 
- $i_j$ est le taux d'intérêt annuel,
- $n_j$ est la durée de vie estimée.

A cette étape, le coût d'investissement spécifique $Kai_j$ doit être considéré constant afin de linéariser le coût fixe annuel. C'est une hypothèse forte dont la validité varie en fonction du type d'installation et de la plage de fonctionnement étudiée. Pour chacune d'entre elles, une valeur de $Kai_j$ peut être considérée. 

Il vient donc le coût fixe annuel du composant j en \$/an :

$ C_"j,fixe" eq.est P_j.r_j.Kai_j $ 

#underline()[Modélisation du coût de fonctionnement annuel]\
Le coût de fonctionnement d'un composant, bien que principalement composé du coût de l'énergie primaire, prend en compte plusieurs paramètres :
- Le coût de l'énergie primaire,
- Le coût de maintenance,
- Le coût de réparation,
- La taxe $"CO"_2$.

Certains composants produisent deux types d'énergie. Par exemple les centrales de cogénération produisent de la chaleur et de l'électricité. Dans ce cas, il faut tenir compte dans le coût spécifique des deux types d'énergies produites.

La taxe $"CO"_2$ est calculée en introduisant l'émission spécifique de $"CO"_2$ en $"kg"_"eq,CO"_2$/kWh: $ c eq.est "Emission annuelle"/"Production annuelle d'énergie"  $

Ainsi, il vient l'expression du coût annuel de fonctionnement du composant j :
$ C_"j,fonctionnement" = (b_j + c_j."Tax"_"CO"_2).W_j $ 

#underline()[Modélisation du coût global annuel]\
Ainsi caractérisé, le coût annuel d'un composant est déterminé par la fonction affine suivante : \
  
#math.equation(
  numbering : "(1)",  
  supplement : "l'équation",
  block : true,
  $C_j eq.est r_j.Kai_j.P_j + (b_j + c_j."Tax"_"CO"_2).W_j$) <f_cout_annuel>


Une fois la plage de fonctionnement du composant déterminée, son dimensionnement s'effectue en paramétrant $P_j$ et $W_j$.

=== Méthode de dimensionnement

L'objectif de cette partie est de construire une méthode générale de dimensionnement. Elle doit permettre d'optimiser le coût global d'une unité de production tout en répondant à l'entierté de la charge. Éventuellement, cette méthode peut être étendue à l'optimisation des émissions de CO2 engendrées. Cependant, elle est mono-objectif et ne permet pas d'optimiser les deux critères simultanément#footnote("On remarquera cependant l'introduction de la taxe C02 dans le calcul du coût de fonctionnement d'un système permettant de considérer les émissions dans l'optimisation."). Une méthode autorisant l'optimisation multiobjectif est proposée en  @sect_opti_meta_heuritic\

À titre d'exemple, on considère un site industriel ayant *n* besoins différents d'apport d'énergie pour ses procédés (industrie agroalimentaire). Comme vu précédemment, les besoins en chaleur pour des températures suffisament éloignées sont considérés comme deux besoins distincts. En effet, dégrader l'exergie d'une source haute température pour fournir une chaleur basse température est souvent moins intéressant que de fournir une chaleur adaptée à chaque besoin. // Ca serait pas mal de citer un article là...

Soit un besoin en chaleur i dont la température est connue. La charge annuelle de ce besoin est réprésentée en @heat_load telle que donnée par les industriels :
#figure(table(image("Illustrations/Exemple charge annuelle.png", width : 80% ), align: center, stroke:none), 
kind:image, gap : 0.05em,
caption : [Exemple de charge annuelle]) <heat_load> 

En triant la puissance dans l'ordre décroissant et en affinant le pas, il vient en @heat_load_duration pour chaque valeur de la puissance la durée pendant laquelle elle est demandée :

#figure(table(image("Illustrations/Exemple courbe de durée de puissance lissée.png",width : 80% ), align: center, stroke:none), kind:image, gap : 0.05em,
caption : [Exemple de courbe de durée de charge]) <heat_load_duration> 

Pour l'exemple, on considère que 3 systèmes répondent au besoin. Il existe une infinité de répartitions possibles de la production dont une est proposée en @heat_load_duration_discretized : 

#figure(table(image("Illustrations/Exemple de dimensionnement des composants.png",width : 80% ), align: center, stroke:none), kind:image, gap : 0.05em,
caption : [Exemple de mix énergétique]) <heat_load_duration_energetic_mix> 

Une telle répartition permet de répondre à la charge. Les surfaces hachurées correspondent aux énergies que les systèmes auraient pu fournir s'ils fonctionnaient tout le long de leur sollicitation à leur puissance nominale. Par définition, le meilleur mix énergétique est celui qui minimise la somme de ces surfaces.

Il suffit maintenant de déterminer pour chaque système de production j le couple $(P_j,W_"j")$ permettant d'obtenir ce mix.

Pour cela, la courbe de durée de puissance est discrétisée en $n_k$ segments comme illustré en @heat_load_duration_discretized.
#figure(table(image("Illustrations/Segmentation de la courbe de durée de puissance.jpg",width : 80% ), align: center, stroke:none), kind:image, gap : 0.05em,
caption : [Exemple de courbe de durée de charge discrétisée]) <heat_load_duration_discretized>
En déterminant le meilleur mix énergétique pour chacun d'entre eux, le mix énergétique global est calculé en sommant les contributions de chaque composant pour les $n_k$ segments.

Pour $P_k$ très petit devant $P_n$, les segments peuvent être considérés infinitésimaux où le coût global d'un composant est défini à partir de @f_cout_annuel :

#math.equation(
  numbering : "(1)",  
  supplement : "équation",
  block : true,
  $ "dC"_"j,k" = r_"j".Kai_j."dP"_"k" + (b_j + c_j."Tax"_"CO"_2)."dW"_"k" $) <eq_f_cout_k_j>


Après avoir minimisé le coût de chaque composant pour chaque section k, on calcule le coût global par composant : 
$ C_j = sum_(k=1)^(n_k) "dC"_"j,k" $

Intuitivement, il apparaît que l'obtention d'un résultat précis est possible si $n_k$ est grand, impliquant un nombre important de calculs. Pour éviter cela, on raisonne à l'aide des conditions d'opérations critiques. On suppose toujours $n_k$ très grand de sorte à ce que $"dW"_k="dP"_k.t_k$ 
où :
- $t_k$ est le temps d'opération du segment k (voir @heat_load_duration_discretized).
L'@eq_f_cout_k_j peut être réécrite comme suit : \

$#h(9.5pt) "dC"_"j,k" = r_"j".Kai_j."dP"_"k" + (b_j +  c_j."Tax"_"CO"_2)."dP"_"k".t_k $

En posant $m_"j,k" eq.est "dC"_"j,k"/"dP"_"k"$ le coût spécifique de production d'énergie, il vient son expression :
#math.equation(
  numbering : "(1)",  
  supplement : "équation",
  block : true,
  $  "dC"_"j,k"/"dP"_"k" = r_"j".Kai_j + (b_j +  c_j."Tax"_"CO"_2).t_k $) <eq_cout_specifique>


Pour chaque segment k, la charge est assurée par la technologie dont le coût spécifique annuel est le plus faible. Ces valeurs sont obtenues par moyenne des prix du marché#footnote()[Les valeurs des coûts spécifiques indiquées sur la @fig_resolution_graphique sont uniquement indicatives]. Deux résolutions, analytique et graphique, sont possibles. Cette dernière est illustrée ci-après :

=== Résolution graphique
#figure(table(image("Illustrations/Exemple de dimensionnement des composants - derivees.png",width : 80% ), align: center, stroke:none), kind:image, gap : 0.05em,
caption : [Résolution graphique du dimensionnement d'une unité]) <fig_resolution_graphique>

=== Limites de la méthode
A condition de connaître la charge annuelle avec précision, cette méthode permet de dimensionner facilement une unité. Cependant elle présente plusieurs limites : 

- Le coût spécifique de chaque composant doit être connu, 
  - Une étude de marché doit être réalisée pour chaque composant,
- Elle est mono-objectif, 
  - Le dimensionnement en vue de l'obtention d'un label (ex. type label environnemental) doit se faire par itérations, 
  - Dans ce cas, il n'y a pas de garantie que la solution finale soit un optimum,
- Elle ne permet pas d'inclure les champs solaires thermiques et photovoltaïques dans l'optimisation,
  - Un composant doit pouvoir être caractérisé par @f_cout_annuel ce qui est impossible quand l'énergie primaire et la puissance sont fluctuantes,\
  - Leur utilisation est donc réduite à un apport ponctuel et non à un apport principal,
- Dans le cas d'installations hydrauliques, les pertes thermiques sont considérées uniquement par des facteurs de rendement et ne dépendent pas des conditions météorologiques

Ce dernier point est un problème conséquent pour le dimensionnement des centrales solaires. L'usage d'une simulation semi-physique de l'unité permet de lever cette contrainte. De plus, la prise en compte des pertes thermiques dans les conduites et les composants permet une meilleure évaluation du productible.

Sa conception est détaillée dans le chapitre suivant.

== Conclusion
En conclusion, une unité de production d'énergies bas-carbones sur site industriel peut être dimensionnée via une méthode mono-objective graphique. Au préalable, la charge demandée par le site doit être connue et des études de marché sur toutes les unités à acheter doivent être effectuées. Elle permet d'optimiser le coût de l'unité sur son temps de fonctionnement tout en considérant les émissions de $"CO"_2$ induites. Cependant, elle admet plusieurs limites : 
-  L'unité ne peut comporter de système de production solaire,
-  Les pertes thermiques entre composants ne sont pas considérées,
-  La pollution engendrée par l'unité, bien que considérée dans le calcul, n'est pas une variable d'optimisation.

#pagebreak()

//************************************************************
//                         Chapitre 2
//************************************************************
= *Modélisation et pilotage des systèmes énergétiques*

== Contexte du projet
Le département innovation et vente est à l'origine de la demande d'amélioration de l'outil de simulation. Une meilleure prise en compte du comportement physique des unités et de leur pilotage permet de réaliser des études de faisabilité dont les résultats seraient plus proches de la réalité. Cela a motivé le stage à l'origine de ce travail de fin d'études. 

== Analyse des besoins
Avant toute conception, il est nécessaire d'analyser les besoins auxquels répond l'outil. Cette étape a été réalisée par la méthode de la bête à corne ci-dessous :

#figure(table(image("Illustrations/Bete a cornes.png",width : 85% ), align: center, stroke:none), kind:image, gap : 0.05em,
caption : [Analyse des besoins du département (Méthode bête à cornes)])

Une modélisation semi-physique permet de simuler les comportements physiques des composants tout en s'appuyant sur des lois de comportements empiriques. Les avantages d'une telle modélisation sont la rapidité de calcul et un paramétrage facilité. Cependant, elle nécessite de rester dans les domaines de fonctionnement prévu par les lois pour garantir un comportement simulé cohérent. \

Modéliser physiquement l'unité et son pilotage permet une meilleure estimation du coût global de la chaleur produite par l'unité. Ce faisant, le retour sur investissement calculé dans l'étude de pré-faisabilité peut être estimé plus précisément. Cela permet de baisser les coûts d'investissement et de production estimés. Ainsi, le nombre de projets de rénovation d'unité pouvant être conduits à terme augmente.

== Cachier des charges 

 Le cahier des charges du logiciel de simulation est donné ci-après. Il comporte les listes exhaustives des fonctionnalités requises et des contraintes techniques.

#underline()[Fonctionnalités nécessaires :] \

- Choisir le fluide caloporteur (exemple : eau liquide, eau glycolée, vapeur d'eau etc...),
- Modifier le pilotage si besoin,
- Simuler sur une année,
- Moduler le pas de résolution selon celui des données météorologiques et celui de la charge,
- Réaliser une analyse économique pour la réalisation d'études de pré-faisabilité,
- Utiliser une bibliothèque de composants, 

- Afficher de résultats graphiques dont : 
  - La production de chaleur et les pertes thermiques (diagramme en barre), 
  - Le respect de la charge dans le temps,
  - Le prix de chaleur et le retour sur investissement.

- Utiliser au besoin des méthodes d'optimisation, 
  - Le modèle doit pouvoir être appelé avec un jeu de paramètres à optimiser.

#underline()[Contraintes techniques]
  
- L'ensemble de l'équipe innovation et vente doit pouvoir prendre en main l'outil rapidement,
  - Un paramétrage rapide des modèles doit pouvoir être effectué, 
  - Le programme doit résister à la casse.
- Le temps de calcul doit être inférieur à 10 minutes, 
- La modélisation doit être acausale : 
  - Chaque projet étant unique, le jeu de paramètres de dimensionnement peut être sujet à changement.

Dans la suite, l'architecture répondant au mieux à ces contraintes est développée.

== Hypothèses de modélisation

Dans le cahier des charges, un temps de calcul rapide est requis. Pour cela, certaines hypothèses sont faites, permettant d'éviter des calculs non nécessaires. Elles sont listées ci-dessous : 

- L'écoulement des fluides dans les conduites, les flux de chaleurs convectifs des conduites et des composants sont toujours considérés en régime permanent,

- Lorsque les pompes sont en marche (donc quand il fait encore jour), le débit de fluide est considéré suffisament élevé pour répartir les pertes thermiques de chaque composant sur toute l'installation.

- Lorsque les pompes sont à l'arrêt, la convection naturelle du fluide caloporteur est négligée : le débit dans les conduites est considéré nul. De plus, la chaleur est perdue dans l'environnement composant par composant.

- La consommation électrique des pompes est négligée devant la production totale de chaleur,

- La chaleur du fluide caloporteur qui rentre dans le vase d'expansion#footnote[Voir glossaire] est considérée perdue.

== Architecture de modélisation
Le programme de simulation a été réécrit entièrement lors de ce projet pour les raisons suivantes : 
- Le programme précédemment utilisé par Absolicon AB Solar Collector ne correspondait pas aux nouvelles attentes techniques,
- Les simulateurs existants sur le marché sont coûteux #footnote()[Dymola ] et doivent être adaptés aux unités de production solaires thermiques,
- Les alternatives opensources n'étaient pas fiables #footnote()[Des tentatives de modèles simples ont été réalisés sur Openmodelica sans succès].

L'utilisation du langage de programmation Python est apparue comme un moyen de conciller le critère de facilité de prise en main avec le développement d'une bibilothèque de composants et l'utilisation d'un modèle acausal.\

En effet, l'équipe innovation d'Absolicon était déjà formée à l'utilisation du langage Python et des IDE#footnote()[Voir glossaire] <fn_gloss>, permettant par ailleurs de se passer d'une interface graphique. C'est un langage orienté-object permettant d'instancier des objets à partir de définitions de classes, donc rendant possible la création d'une bibliothèque de composants. Le critère d'acausalité n'a pu être respecté que partiellement. Contrairement à des langages compilés tels que le C++, Python est un langage interprété : les instructions sont lues dans l'ordre chronologique. \

Afin de se rapprocher d'un modèle acausal, tous les composants ont été basés sur une classe de fluide de travail. Cette dernière a été conçue avec des méthodes "getters"@fn_gloss et "setters"@fn_gloss sur les variables thermodynamiques. En faisant cela, toute modification d'une variable d'état#footnote()[Au sens thermodynamique] d'un composant entraîne l'actualisation de son état thermodynamique.

=== Développement
Le développement, itératif et incrémental, est constitué d'étapes numérotées en @fig_frise_chronologique. Elles sont détaillées par la suite : 
\
#figure(table(image("Illustrations/Chronologie developpement.jpg",width : 100% ), align: center, stroke:none), kind:image, gap : 0.05em,
caption : [Frise chronologique du développement de l'outil]) <fig_frise_chronologique>

#underline()[*Etape 1 :*]
Constitution d'une librairie de composants \ 
Tout d'abord, un modèle de fluide a été créé sur lequel sont basés la majorité des composants. Puis,
chacun d'eux a été testé en régime permanent et en régime transitoire. A ce stade, aucune comparaison avec l'expérience n'a été nécessaire puisque les équations à l'origine des modèles proviennent de la littérature.

#underline()[*Etape 2 :*]
Ecriture du pilotage d'une unité \
Le pilotage a été écrit sous la forme d'un évenement dictant les intéractions entre composants pour chaque pas de temps. Notamment, cela a permis la réalisation de bilans de productible annuels de centrales solaires thermiques. Leur localisation est prise en compte pour le calcul de l'apport solaire, des pertes d'énergie et de leur inertie thermique.

#underline()[*Etape 3 :*]
Comparaison avec l'expérience \
Le pilotage ayant rendu possible les bilans de productibles des centrales, l'ajout des procédés industriels et des pertes thermiques associés a permis de réaliser une comparaison avec des données réelles. L'estimation du productible et des températures de fluide pendant la nuit étaient erronés : très peu de pertes thermiques étaient considérées. Ainsi, les températures de fluide dans les conduites restaient importantes (environ 100°C pour une température de consigne de 160°C en condition de fonctionnement). 

#underline()[*Etape 4 :*]
Refonte du modèle de calcul et optimisation métaheuristique \
Ces résultats aberrants ont mené à une refonte du modèle de calcul des pertes thermiques. En parallèle, des méthodes d'optimisation ont été testées pour optimiser le dimensionnement des conduites du champ solaire#footnote()[Voir @sect_opti_meta_heuritic].

#underline()[*Etape 5 :*]
Implémentation de la charge \
Les procédés industriels étaient auparavant considérés uniquement via l'ensemble hydraulique les reliant au réseau. La vérification de la satisfaction de la charge a donc été implémentée. Egalement, l'ajout des changements de phase des fluides caloporteurs a nécessité une refonte profonde du modèle de fluide. Or, tous les composants et les méthodes de pilotage étant basés sur ce dernier, une refonte profonde du logiciel a été effectuée.

#underline()[*Etape 6 :*]
Analyse technico-économique \
La charge étant implémentée, l'analyse technico-économique a pu être ajoutée afin d'estimer le coût total annuel de la chaleur en considérant les coûts d'investissement et les coûts de production.

Ces dernières modifications ont permis d'obtenir la version finale du simulateur, présentée dans la suite. Cependant, l'outil a été conçu pour être modifié et amélioré au cours le temps : d'autres versions verront probablement le jour.

=== Modélisation orientée objet <modelisation_object>

On distingue deux types de modèles :
- Les modèles de composants (PaC, stockage thermique, champ solaire etc...),
- Les modèles particuliers (Fluide, horloge, météo etc...). \
Les principaux modèles de composants sont présentés dans le tableau ci-dessous :

#table(
  columns: (0.35fr, .7fr, 1fr),
  inset: 10pt,
  align: horizon,
  [*Composant*], align(center)[*Paramètres d'entrées*], align(center)[*Loi(s) de comportement*],
  // 1ère ligne
  align(center)[#image("Sigles/capteur_solaire.png", width:1.9cm) #par(justify:false)[*Capteur solaire thermique*]]
  ,
    par(justify: false)[
    *$l$* : Largeur [m]\
    *$S$* : Surface brute [m²]\
    *$eta_0$* : Facteur optique [-]\
    *$b_0$* : Réflexivité du DNI#footnote()[Voir glossaire] <fn_gloss17> [-]\ 
    *$K_d$* : Réflexivité du diffus @fn_gloss17 [-]\ 
    *$a_1$* : Pertes convectives [-]\ 
    *$a_2$* : Pertes radiatives [-]\ 
    
  ],
  [#underline[Densité de puissance thermique #footnote()[Source : SolarKeyMark.eu]] [$"kW"_"th"$/$m^2$]  #v(-20pt) \
  
    $ q(t) = eta_0.(b_0.G_b (t) +K_d.G_d (t))  \ -a_1.(T_m-T_a (t)) \ -a_2/(1,005).(T_m-T_a )(t))^2 $ 
    où : 
    - *$T_m$* : Température moyenne [°C]
    - *$T_a$* : Température ambiante [°C]
    - *$G_b$* : Irradiance directe @fn_gloss17 [W/m²]
    - *$G_d$* : Irradiance diffuse @fn_gloss17 [W/m²]
  ],
  // 2ème ligne
    
    align(center+horizon)[#image("Sigles/tuyau.png", width:2cm) #par(justify:false)[*Conduite*]

    
    #align(bottom)[#underline()[Sous-modèles :
    \
    ]
    Fluide]]
    
  ,
  par(justify: false)[
    *$L$* : Longueur [m]\
    *$D$* : Diamètre [m]\ 
    *$T_"min"$* : Température minimale [°C]\ 
    *$T_"work"$* : Température de travail (consigne) [°C]\
    *$"Fluid"$* : Type de fluide\ 
    *$T_0$* : Température de départ [°C]\
    *$T_"ext"$* : Température extérieure [°C]\
    *$P$*  : Pression [bar]\
    *$U$* : Coefficient d'échange thermique [$W.K^(-1).m^(-2)$]\
    *$"Closed"$* : Ouverture du système [Booléen]\

  ],
  [ #underline()[Débit masse] [$"kg".s^"-1"$] : #v(-5pt)
    $ accent(m,.) (t) = rho (t) ."v"_"max".A $
    
    #underline()[Pertes thermiques] [$"kWh"_"th"$] #v(-5pt)
    $ L(t) = U.S.(T_f (t) - T_a (t)) $

    #underline()[Transformation] [-] \
    -- Si Closed = Vrai : Chauffe isochore, système fermé \
    -- Si Closed = Faux : Chauffe isobare, système ouvert \
    
    où : \
  - *$A$* : Section droite [m²] \
  - *$S$* : Surface extérieure [m²] \
  - *$T_f (t)$* : Température du fluide [°C]
  - *$T_a (t)$* : Température ambiante [°C] 
  - *$rho (t) $* : Masse volumique du fluide [kg/$m^(3)$]
  ],
  
  //3ème ligne
  align(center)[#image("Sigles/centrale_solaire_thermique.png", width:2cm) #par(justify:false)[*Champ solaire thermique*]
  #align(bottom)[#underline()[Sous-modèle(s)
    \
    ]
    Conduite \ 
    Collecteur]]
  ,
  par(justify: false)[*$"nColSC"$* : Nombre de collecteurs par sous-circuits \ 
   *$"nSC"$* : Nombre de sous-circuits \
   *$"Collecteur"$* : Type de collecteur \
   *$"SC_pipe"$* : Conduites des sous-circuits \
   *$beta_g$* : Inclinaison par rapport au sol [°]\
   *$gamma$* : Orientation du champ [°]] ,
  [ #underline()[Puissance thermique] [$"kW"_"th"$] #v(-5pt)
    $ P (t) =q (t) .S $
    
    #underline()[Productible annuel] [$"MWh"_"th"$] 
    $ E = sum_(t=1)^(8760)("max"(P (t)."3,6"   - Phi(t) - Delta E_w (t)),0) $
    où : \
  - *$Phi(t)$* : Perte thermique globale [$"MWh"_"th"$]
  -  *$Delta E_w (t)$* : Energie à obtenir pour atteindre les conditions de fonctionnement  [$"MWh"_"th"$]
    
  ],
  // 4ème ligne
  align(center)[#image("Sigles/PaC.png",width:2.2cm) #par(justify:false)[*Pompe à chaleur*]]
,
  [*$eta$* : Facteur de Carnot\ 
  *$W_"nominal"$* : Travail nominal [W]\
  *$T_f_"s,min"$* : Température minimale de sortie du condenseur [K]\
  *$T_c_"s,max"$* : Température maximale d'entrée de l'évaporateur [K]],
  [#underline()[Puissance thermique] [$"kW"_"th"$] 
    $ P_"th"= "min"(accent(m,.)_"évap".C_p.(T_"target" - accent(T,macron)_"évap");P_"max") $ 
    
    #par(justify: false)[#underline()[Puissance électrique] [$"kW"$]
    #v(-5pt) $ P_"élec" \u{2248} accent(W,.) = (eta."CoP"_"carnot")/P_"th" $] 
  
    #par(justify: false)[#underline()[Puissance de refroidissement]  [$"kW"_"th"$] #v(-5pt)   $ P_"refroidissement" = P_"th" - W $
  où : \
  *$P_max $* $= eta."CoP"_"carnot".W_"nominal"$ : La puissance thermique maximale pouvant être fournie par la PaC [$"kW"_"th"$]]
  ],
  
  // 5ème ligne
    align(center)[#image("Sigles/strockage_thermique.png",width:1.9cm) #par(justify:false)[*Stockage thermocline*]
  #align(bottom)[#underline()[Sous-modèle(s)
    \
    ]
    Fluide]]
,
  [ *$"H"$* : Hauteur [m] \ 
  *$D$* : Diamètre [m] \ 
  *$T_"min" , T_"max"$* : Températures de fonctionnement [°C] \ 
  *$"Fluid"$* : Type de fluide\  
  *$"Text"$* : Température extérieure [°C] \ 
  *$P$* : Pression [bar]\ 
  *$U$* : Coefficient d'échange thermique [$W.K^(-1).m^(-2)$] \ 
  *$E_0$* = Energie initiale dans le système [kWh] \ 
  ],
  [#underline()[Chaleur minimale/maximale] [$"kWh"_"th"$]
    $ E_"min,max" = h ("T"_"min,max").m_f $ 
    
    #par(justify: false)[#underline()[Charge] [-]
    #v(-5pt) $ C = E/(E_"max" - E_"min") $] 
  
    #par(justify: false)[#underline()[Puissance de refroidissement]  [$"kW"$] #v(-5pt)   $ P_"refroidissement" = P_"th" - W $]
    où :\ 
    *$h$* : Enthalpie spécifique du fluide [$"J".K^(-1)."kg"^(-1)$]
  ],
   // 6ème ligne
     align(center)[#image("Sigles/chaudière.jpg",width:2.5cm) #par(justify:false)[*Chaudière*]
   #align(bottom)[#underline()[Sous-modèles :
    \
    ]
    Combustible]]
,
  [*$"Combustible"$* : Modèle de combustible \
  *$T_"min,max"$* : Températures minimale et maximale [°C]\
  *$T_"work"$* : Consigne de température [°C] \
  *$P_"min,max"$* : Plage de puissance thermique [$"kW"_"th"$]\ 
  *$P_n$* : Puissance nominale [$"kW"_"th"$]],
  [#underline()[Puissance thermique] [$"kW"_"th"$] #v(-5pt)
    $ P_"th" = "min"(accent(m,.)_"f".C_p.(T_"target" - accent(T,macron)_"f");P_"max") $ 
    
  ]
    ) 
  Tous ces composants possèdent des méthodes communes facilitant l'écriture du pilotage de l'unité dans le script principal. Cependant, elles sont adaptées pour chaque composant. On distingue : 
  - *Calculate_loss* : Calcule les pertes thermiques du composant avec l'environnement,
  - *Set_ambiant_conditions* : Modifie la température extérieure au composant étudié (peut différer d'un composant à l'autre),
  - *Update_energy_state* : Initialise ou modifie l'état thermodynamique du composant en fonction des entrées/sorties d'énergie et des pertes calculées. L'énergie du composant et sa masse y sont également calculées, ainsi que l'énergie nécessaire pour atteindre les conditions de fonctionnement.
  
  Les composants précédemment présentés ont besoin d'autres objets pour intéragir entre eux. Ils sont présentés ci-dessous : 

  #table(
  columns: (0.35fr, .7fr, 1fr),
  inset: 10pt,
  align: horizon,
  [*Composant*], align(center)[*Paramètres d'entrées*], align(center)[*Rôle*],
  
  // 1ère ligne
  align(center)[#image("Sigles/fluide.png", width:115%)
  #par(justify:false)[*Fluide*]],
  
  par(justify:false)[*$"Fluide"$* : Type fluide ($H_2 0, "NH"_3$, etc ...) \
  *$"Variables d'état"$* : Couple de variables d'état et de leur valeur [dictionary #footnote()[Voir glossaire] <fn_gloss19>]\
  *$"Liste variables d'état"$* : Ensemble des variables d'états utilisables pour caractériser le système [list]],

  par(justify: false)[
    - Structure de base pour la majorité des composants
    - Assure les comportements physiques suivants : \
      -- L'inertie thermique \
      -- Les changement de phase \
      -- Les pertes thermiques \
      -- Les transferts de chaleur et de masse d'un composant à l'autre
  ],
    //2ème ligne
  align(center)[#image("Sigles/systeme.png", width:2.3cm)
  #par(justify:false)[*Système*]
  #underline()[Sous-modèles :]
  Composants\
  Conduite],
  
  par(justify:false)[
  *$"Composants"$* : Composants du système [list] \
  *$"Conduite"$* : Conduite du système [list]
  #line(length: 100%,stroke : (thickness: 1pt, dash: "dashed"))
  #underline()[Après ajout des composants :] 
  *$ m_"sys,tot" = sum_(j=1)^(k)m_j \
    E_"sys,tot"  = sum_(j=1)^(k)E_j \
    L_"sys,tot"  = sum_(j=1)^(k)L_j $*] ,
  
  [#par(justify: false)[
      - Acquérit des composants : \ 
        -- Permet de séparer en systèmes différents les composants de l'unité (ex : système stockage thermique & système procédés/client) \
      - Sommer la masse, la chaleur et les pertes de tous ses systèmes à chaque pas de temps 
      - Appeler les méthodes communes à chacun de ses composants\
    ]],
  
  //3ème ligne
  align(center)[#image("Sigles/horloge.png", width:2cm)
  #par(justify:false)[*Horloge*]
 #underline()[Sous-modèles :]
  Systèmes],
  
  par(justify:false)[
  *$"startDate"$* : Début de la période \
  *$"endDate"$* : Fin de la période
  #line(length: 100%,stroke : (thickness: 1pt, dash: "dashed"))
  #underline()[Après ajout des composants :] 
  *$ m_"tot""" = sum_(i=1)^(n)m_"i,tot"  \
    E_"tot"  = sum_(i=1)^(n)E_"i,tot" \
    L_"tot"  = sum_(i=1)^(n)L_"i,tot" $*
  ],
  
  [#par(justify: false)[
      - Pilote l'unité : \ 
        -- Acquérit des méthodes (appelés événements) après instanciation @fn_gloss19 \
        -- Appelle les événements à chaque pas de temps
      - Acquérit les systèmes \
        -- Somme les masses, la chaleur et les pertes des systèmes  \
        -- Calcule l'écart entre l'énergie totale des systèmes et l'énergie nécessaire pour être en condition de fonctionnement \
        $Delta E=E-E_w $,
      - Acquérit les données désirées par l'utilisateur.rice\
    ]],
      // 1ère ligne
  align(center)[#image("Sigles/meteo.png", width:110%)
  #par(justify:false)[*Météorologie*]],
  
  par(justify:false)[
    *$"startDate"$* : Début de la période \
    *$"endData"$* : Fin de la période \
    *$phi$* : Latitude du lieu où se situe l'unité \
    *$"Données météos"$* : Tableau de l'irradiance et de la température extérieure en fonction du temps\
    ],

  par(justify: false)[
    - Stocke les données météorologiques
    - Restitue les informations aux composants
  ],
  )

=== Pilotage

Le pilotage d'une unité de production est l'ensemble des instructions qui lui sont données afin de garantir son fonctionnement. Il est dicté par une série d'instructions écrites pendant sa conception (ex : mise en marche et arrêt des pompes en début/fin de journée). Il est également régit par les mesures des capteurs de l'unité (ex : température du stockage thermique au maximum #sym.arrow fermeture de la vanne de la conduite amont au ballon). Dans le cas de ce logiciel de simulation, on inclut dans le terme pilotage les instructions permettant de simuler un comportement physique. \

Le pilotage influence le productible annuel. Dans la simulation, il est modélisé comme une suite de méthodes associées à l'horloge. Une méthode "en marche" permet de les exécuter les uns à la suite des autres. Elles fonctionnement en cascade : par exemple, la méthode update() de l'horloge appelle la méthode udpate() de tous les systèmes, qui à leur tour appellent celle de leur composant. Certains composants appellent également la méthode d'un sous-composant (comme une conduite, par exemple). Ce fonctionnement permet de faciliter l'écriture du pilotage pour l'utilisateur.\

Jusqu'alors, la modélisation des composants et du pilotage de l'unité ont été vus. Dans un soucis de clareté, un exemple de pseudo-code modélisant le pilotage d'une centrale solaire thermique simplifiée est donné ci-après.
=== Pseudo-code

Le pseudo-code d'un champ solaire et de son pilotage est donné ci-après. Le stockage thermique n'a pas été modélisé pour alléger l'exemple.

La centrale solaire étudiée est composée :
- d'un champ solaire et ses conduites aval, amont,
- d'une zone de procédés et ses conduites aval, amont.

Le pseudo-code qui en résulte est donné en @exemple_pseudocode :

#figure(table(
  image("Illustrations/pseudo-code.png", width:101%)) ,
  caption :[Exemple de pseudo-code pour une simulation champ et procédé],
  kind:image) <exemple_pseudocode>
#pagebreak()

Danc ce cas précis, le pilotage sert majoritairement à simuler un comportement physique. Seule l'arrêt des pompes est simulé par une valeur de puissance thermique du champ nulle. Les mesures réalisées sur ce dernier (température, densité de puissance) servent essentiellement à calculer le productible pour chaque pas de temps. \ 

On distingue une première phase de chauffe où chaque composant et conduite  de l'installation est chauffé jusqu'à atteindre ses conditions de fonctionnement. Ici, ce critère est évalué par des mesures de températures et des consignes de température de fonctionnement. \ 

A l'échelle de l'unité, la chaleur totale contenue dans l'installation est évaluée en sommant la chaleur contenue dans chaque composant et chaque conduite. La différence entre cette valeur et la chaleur nécessaire pour être en condition de fonctionnement est $Delta E_w$. Quand cette valeur devient nulle, alors le champ est en condition de fonctionnement. Le productible est alors égal au flux net de chaleur apporté par le champ solaire. 

== Conclusion
Une simulation semi-physique d'unités de production d'énergie a été réalisée dans le cadre de ce stage. Suite à une analyse des besoins, le langage de programmation Python a été choisi pour développer l'outil. Un travail itératif a permis de confronter l'outil à l'expérience ainsi qu'aux envies des utilisateurs.rices. Finalement, il a permis d'aboutir à la version présentée dans ce rapport. Le script a été écrit en langage orienté objet afin de permettre l'utilisation d'une bibliothèque de composants. Elle sera améliorée et agrandie par l'équipe d'innovation au fur et à mesure des projets. 

Cet outil permet de dimensionner efficacement une unité comportant un champ solaire en fonction de la charge du site étudié. Il est donc propice aux travaux de pré-faisabilité. Egalement, il peut servir de support dans le cas d'optimisation par méthode méta-heuristique. 
  
#pagebreak()

//************************************************************
//                         Chapitre 3
//************************************************************

= Application à l'avant projet de rénovation d'un site industriel
  
== Contexte du projet
L'objectif de ce chapitre est de présenter un exemple concret d'utilisation de la simulation. L'étude de pré-faisabilité de construction d'une centrale solaire thermique à concentration sur un site industriel est présentée. Située en Italie, le client y réalise des transformations pour l'industrie cosmétique. Par soucis de confidentialité, le nom du client, la localisation exacte du site et les détails techniques du projet ne sont pas donnés. Ce projet a permis d'obtenir un premier retour d'expérience des futur.e.s utilisateur.rice.s du logiciel et de proposer des modifications pour satisfaire au mieux leur besoins.  

== Site industriel
Le site industriel dispose : 
-  D'un espace non-utilisé et constructible conséquent, 
-  D'une irradiance solaire annuelle suffisante (voir @irradiation_Tamb),
-  De procédés propices à l'utilisation de chaleur solaire ($T_"procédés" < "160°C"$).

=== Données météorologiques

Les données météorologiques sont simulées par TRNSYS, un logiciel de simulation de systèmes solaires thermiques pour le génie climatique et la production d'énergie solaire. Il est développé par l'Université du Winconsin.

Une de ses fonctionnalités est de générer des données météorologiques sur une ou plusieurs années en prenant en compte : 
- Plus de vingt ans de mesures de l'irradiance solaire et de la température extérieure dans 120 pays différents (dont 1000 localisations différentes),
- Une prise en compte possible du masque solaire#footnote()[Voir glossaire],
- Une prise en compte de l'ombrage des panneaux entre eux,
- Une prise en compte du changement climatique dans le cas d'une simulation sur plusieurs années.

Une moyenne mensuelle des irradiations solaires et de la température extérieure générée par TRNSYS est donnée en @irradiation_Tamb :

#figure(table(
  image("Illustrations/Irradiations_Tamb.png", width:80%), stroke:none) ,
  caption :[Irradiations solaires et température ambiante moyennes annuelles du site industriel],
  kind:image) <irradiation_Tamb>

Il est à noter que les systèmes solaires à concentration ne permettent pas de valoriser l'irradiation diffuse dont les longueurs d'ondes sont situées dans l'infrarouge. La part utilisable de l'irradiation solaire pour un capteur solaire thermique à concentration est la projection du rayonnement direct solaire sur le vecteur normal au panneau.

=== Besoins en énergie

L'entreprise a trois besoins d'énergie : 
  - Un besoin en vapeur,
  - Un besoin en eau chaude,
  - Un besoin de chaleur pour procédés.

Leur répartition annuelle est donnée ci-après :
#figure(table(
  image("Illustrations/charge_annuelle_latina.png", width:82%), stroke:none) ,
  caption :[Charge annuelle de l'industriel],
  kind:image) <charge_annuelle_latina>
  
== Unité de production

=== Choix des composants
Dans un premier temps, un champ solaire est simulé sans stockage thermique afin d'estimer la dimension de ce dernier.

On considère le dimensionnement suivant : 

#{
show : it=>align(center)[#it]
table(
columns: (auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  [*Composant \ champ solaire*], align(center)[*Paramètres d'entrée*],[*Composant \ Procédé/Client*], align(center)[*Paramètres d'entrées*],
  
  // 1ère ligne
  [Conduite en amont],
  {show : it => align(left)[#it]
    [
    *$L$* = 2500 [m] \
    *$D$* = 0,35 [m]\ 
    *$T_"min"$* = 5 [°C]\ 
    *$T_"work"$* = 140 [°C]\
    *$"Fluid"$* = Eau \ 
    *$T_0$* = $T_"ext"$ [°C]\
    *$P$* = 10 [bar]\
    *$U$* = 0,5 [$W.K^(-1).m^(-2)$]\
    *$"Closed"$* : Faux\
  ]},

  
  //1ère ligne 
  [Conduite en amont],
  {show : it => align(left)[#it]
    [
    *$L$* = 20 [m] \
    *$D$* = 0,35 [m]\ 
    *$T_"min"$* = 5 [°C]\ 
    *$T_"work"$* = 160 [°C]\
    *$"Fluid"$* = Eau \ 
    *$T_0$* = $T_"ext"$ [°C]\
    *$P$* = 2 [bar]\
    *$U$* = 0,5 [$W.K^(-1).m^(-2)$]\
    *$"Closed"$* : Vrai\
  ]},
  //2ème ligne 
  [Conduite en aval],
  {show : it => align(left)[#it]
    [
    *$L$* = 2500 [m] \
    *$D$* = 0,35 [m]\ 
    *$T_"min"$* = 5 [°C]\ 
    *$T_"work"$* = 160 [°C]\
    *$"Fluid"$* = Eau \ 
    *$T_0$* = $T_"ext"$ [°C]\
    *$P$* = 10 [bar]\
    *$U$* = 0,5 [$W.K^(-1).m^(-2)$]\
    *$"Closed"$* : Faux\
  ]},

   //2ème ligne 
  [Conduite en aval],
  {show : it => align(left)[#it]
    [
    *$L$* = 20 [m] \
    *$D$* = 0,35 [m]\ 
    *$T_"min"$* = 5 [°C]\ 
    *$T_"work"$* = 140 [°C]\
    *$"Fluid"$* = Eau \ 
    *$T_0$* = $T_"ext"$ [°C]\
    *$P$* = 2 [bar]\
    *$U$* = 0,5 [$W.K^(-1).m^(-2)$]\
    *$"Closed"$* : Vrai\
  ]}
)
}
\
#align(center)[
#table(
  columns: (3.77cm,4.4cm),
  inset:10pt,
  align:horizon,
  align(center)[*Composant*], align(center)[*Paramètres d'entrée*],

  //1ère ligne
  align(center)[Champ solaire \ thermique],
  [*$"nColSC"$* = 13 \ 
   *$"nSC"$* = 200 \
   *$"Collecteur"$* : T160 \
   *$beta_g$* = 30 [°]\
   *$gamma$* = 0 [°]],

   //3ème ligne
   align(center)[Conduite \ du sous-circuit],
  [ *$L$* = 100 [m] \
    *$D$* = 0,025 [m]\ 
    *$T_"min"$* = 5 [°C]\ 
    *$T_"work"$* = 150 [°C]\
    *$"Fluid"$* = Eau \ 
    *$T_0$* = $T_"ext"$ [°C]\
    *$P$* = 10 [bar]\
    *$U$* = 1 [$W.K^(-1).m^(-2)$]\
    *$"Closed"$* : Faux\
  ],
)]

Ces choix sont principalement liés à la nature même du champ solaire : 
- La technologie du collecteur ne permet pas l'usage de caloduc autour des conduites de sous-circuits, leur coefficient d'échange thermique est donc élevé. 

- Egalement, le débit massique des conduites amont et aval du champ est réparti équitablement au travers des conduites de sous-circuit, leur diamètre est donc plus petit également.

-  Les conduites amont et aval du champ solaire doivent permettrent de relier tous les sous-circuits entre eux puis d'acheminer l'eau aux procédés : leur longueur est donc importante. 

-  Cependant, elles peuvent être facilement calorifugées ce qui permet de diminuer le coefficient d'échange thermique,

- Les conduites du client sont fermées et pressurisées à 2 bars pour permettre la génération de vapeur,

- Leur longueur est petite pour limiter au plus les pertes thermiques.

=== Pilotage

Le pilotage utilisé dans la simulation est présenté dans le pseudo-code en @exemple_pseudocode. Parmi les composants, on considère les conduites aval et amont des procédés et du champ solaire, et également les conduites du sous-circuit. Tant que l'unité n'a pas atteint ses conditions de fonctionnement, tous les fluides dans les conduites sont chauffés.

== Résultats et analyse

Le fonctionnement annuel de l'unité a été simulé avec un pas de temps d'une heure. Après 78 secondes, on obtient les résultats graphiques suivants : 

#figure(table(
  image("Illustrations/latina_resultats.png", width:100%), stroke:1pt) ,
  caption :[Résultats de la simulation],
  kind:image) <latina_resultats>

La première figure "Heat production" donne la variation temporelle de la chaleur produite par le champ solaire pour chauffer l'unité et pour répondre à la charge du client. Cette figure, en plus de donner un ordre de grandeur de la chaleur fournie, permet également de vérifier la bonne simulation du comportement de l'unité. En effet, on observe bien une variation nette de la chaleur produite d'une saison à l'autre.

On montre également les variations annuelles des températures du fluide caloporteur dans les différentes conduites. En pointillé, on trace les valeurs à atteindre pour être en conditions de fonctionnement. On remarque que la température dans les conduites de sous-circuit est plus faible en moyenne que les autres. Egalement, elle subit des variations plus fortes. Le coefficient d'échange thermique U permet donc de prendre en  compte efficacement le calorifugeage des conduites. \ 
De plus, il semble que la différence d'inertie thermique est bien simulée. Loïck Bruand, ingénieur process à Absolicon, a validé ces comportements comme étant "fidèles au comportement réel des installations".

La figure "heat production ratio" permet de se rendre compte de la part de chaleur perdue par perte thermique (convective dans les conduites et par rendement des échangeurs). On remarque qu'elles diminuent l'été et augmentent l'hiver, ce qui est cohérent.


La charge donnée par l'industriel est propice à l'utilisation d'un champ solaire puisque la demande en chaleur est forte pendant l'été et plus faible en hiver. Cependant, elle reste conséquente au regard de la faible production hivernale du champ solaire (environ 100 MWh). Il s'agit de déterminer le potentiel de chaleur à stocker en été lorsque la production est trop importante, et la chaleur à produire via d'autres composants en hiver pour satisfaire la charge. 

#figure(table(
  image("Illustrations/latina_charge_satisfaction.png", width:80%), stroke:none) ,
  caption :[Non satisfaction de la charge de l'industriel],
  kind:image) <latina_charge_satisfaction>

712,571 MWh peuvent être récupérés et 3313,163 MWh doivent être produits pour pallier au manque de puissance de l'installation. En analysant plus finement sur le mois de février et le mois de juillet, on remarque des surproductions et des sousproductions été comme hiver : 

#figure(table(
  image("Illustrations/latina_charge_hourly_satisfaction.png", width:100%), stroke:none) ,
  caption :[Non satisfaction de la charge de l'industriel],
  kind:image) <latina_charge_satisfaction>

Il apparaît nécessaire de simuler le stockage thermique et un second moyen de production afin de dimensionner au mieux l'unité pour le respect de la charge.
  
=== Dimensionnement du champ solaire, du stockage thermique et de la pompe-à-chaleur
  
Ainsi, l'implantation d'un stockage thermique et d'un deuxième composant (PaC, chaudière, etc...) doit être réalisée pour respecter la charge. On propose d'analyser différentes configurations à l'aide du coût moyen de la chaleur, appelé LCoH @louvet_guideline_2017. Il est défini par l'IEA#footnote[International Energy Agency] comme suit : 

#math.equation(
  numbering : "(1)",  
  supplement : "équation",
  block : false,
  $ "LCoH"=(I_0 - S_0 + sum^T_(t=1)( C_t.(1-"TR") - "DEP"_t."TR")/(1+r)^t - "RV"/(1+r)^T )/ (sum^T_(t=1) (E_t)/((1+r)^t) ) $) <eq_cout_specifique>

où :
#let p1 = [ 
- *$"LCoH"$* : (Coût moyen de la chaleur en #sym.euro/kWh)
- *$I_0$* : (Investissement initial en #sym.euro)
- *$S_0$* $in {30%,50%}.I_0$ (Subventions en #sym.euro)
- *$C_t$* = 8%.$I_0$ (Coût d'opération et de maintenance par an en #sym.euro/an)
- *$"TR"$* : (La taxe de l'entreprise en %)
]
#let p2 = [ 
- *$"DEP"_t$* : (Dépréciation de l'actif (à l'année t) en #sym.euro/a)
- *$"RV"$* : (La valeur résiduelle en #sym.euro)
- *$E_t$* : (L'énergie finale (à l'année t) en kWh/a)
- *$r$* = 7% (Le coût d'actualisation)
- *T* = 15 ans  (période d'analyse)
]
#table(
  columns:(1fr, 1fr),
  align : left,
  stroke:none,
  p1,p2
)

L'investissement initial $I_0$ tiens compte de la surface de capteur installée et du volume de stockage pour lesquels on définit des prix spécifiques (respectivement en #sym.euro/m² et #sym.euro/$m^3$). Il inclu également le coût d'achat du deuxième composant. Son coût d'exploitation est calculé à l'aide de @f_cout_annuel.

Pour chaque surface de champ solaire envisagée, le stockage thermique est dimensionné pour absorber le surplus de production du champ solaire. De plus, une pompe-à-chaleur puis une chaudière sont envisagées pour répondre au reste de la charge. La surface est donc la variable principale permettant de fixer le dimensionnement des autres composants.

L'étude est réalisée pour des surfaces de champ comprises entre 5000 et 35000 m² :

#figure(table(
  image("Illustrations/optimisation_economique_champ_latina.png", width:95%), stroke:none) ,
  caption :[Optimisation économique du champ solaire],
  kind:image) <latina_resultats>


Dans un premier temps, le coût de la chaleur moyen est étudié sans prise en compte de subventions dans le graphique "without subsidies". On observe que chaque courbe admet respectivement un minimum. Ainsi, il apparaît évident que la simulation du champ seul n'est pas suffisante pour déterminer un dimensionnement optimum de l'unité. \
Le second graphique permet d'observer une diminution du LCoH pour une augmentation des subventions. Egalement, la surface de capteurs optimum augmente (de 23712 m² sans subventions à 30000 m² avec 50% de subventions). 

=== Mix énergétique final
Finalement, l'optimum est trouvé pour une architecture sans second système de production. Pour un champ solaire de 
23712 $m²$ et un stockage thermique de 249 $m^3$, on obtient un coût de la chaleur moyen de 142.16 $euro$/$"MWh"$. Le mix energétique final est donnée ci-après : 

#figure(table(
  image("Illustrations/latina_mix_energetic.png", width:80%), stroke:none) ,
  caption :[Mix énergétique final],
  kind:image) <latina_resultats>
== Conclusion

Simuler le champ solaire a permis d'évaluer le coût de la chaleur moyen sur 15 ans et de trouver la surface l'optimisant. Cependant, une étude plus poussée prenant en compte le stockage thermique et un deuxième composant a été réalisée. Le respect de la charge contraint leur dimensionnement, ce qui augmente le LCoH et la surface optimaux.  Egalement, la prise en compte des subventions permet de baisser le LCoH tout en augmentant la surface des capteurs à installer. Dans le cas de cet exemple, utiliser un second moyen de production d'énergie s'est avéré moins intéressant que d'augmenter la surface de capteurs et le volume du stockage.

Cette optimisation doit pouvoir être réalisée par méthode méta-heuristique. Cette possibilité fait parti des développement futurs de l'outil. Néanmoins, la connaissance du nombre de capteurs et de leur emplacement n'est pas suffisant pour effectuer un dimensionnement total. La centrale solaire doit être dimensionnée de sorte à réduire le coût des conduites. Cette étude est proposée dans le chapitre suivant.
  
#pagebreak()

//************************************************************
//                         Chapitre 4
//************************************************************

= Optimisation du dimensionnement d'une centrale solaire thermique
\
Le précédent chapitre a permis de construire une simulation semi-physique de centrale solaire thermique permettant de la dimensionner pour un site industriel donné (lieu et charge). Ainsi, la différence de température entre l'amont et l'aval du champ, le nombre de capteurs, leur ajustement et le dimensionnement des autres composants de production peuvent être fixés. 

Cependant, ces données sont insuffisantes pour estimer les coût d'une telle installation. En effet, la localisation de la centrale solaire par rapport au champ et la manière dont l'eau est apportée à chaque sous-circuit influence le dimensionnement des tuyauteries et donc le coût d'investissement du projet. Pour cause, bien que la raréfaction des ressources pétrolières et les enjeux climatiques ouvrent la voie aux énergies renouvelables, l'inflation des matières premières#footnote[Source : INSEE] augmente les coûts d'investissement. On donne pour exemple l'inflation du coût de l'acier en @inflation_acier.

#figure(table(
  image("Illustrations/cours_acier_inox_insee.png", width:90%), stroke:1pt) ,
  caption :[Inflation du cours de l'acier (INSEE)],
  kind:image) <inflation_acier>

Les objectifs de ce chapitre sont multiples. Tout d'abord, on présentera les paramètres de dimensionnement à optimiser. Puis, on introduira les méthodes métaheuristiques. Finalement, le travail réalisé pour choisir la méthode sera présenté.

==  Variables d'optimisation d'une centrale solaire thermique

En @centrale_solaire_thermique, il a été vu qu'une centrale solaire thermique nécessite un stockage de chaleur permettant de pallier à l'intermittence du soleil. En considérant connue la charge requise par les procédés, la surface de capteurs influence la taille du stockage thermique. Ainsi, il existe un grand nombre de combinaisons possible ($S_"champ"$,$V_"stockage"$) respectant la charge et engendrant des coûts différents. Ces coûts sont difficilement évaluables puisque multifacteurs : une plus grande surface de champ implique certes une augmentation de la production, mais aussi une augmentation de la taille des conduites et donc des pertes thermiques globales. Dans un cas réel, le nombre de variable de dimensionnement augmente. En effet, il faut alors tenir compte : 
-  De la puissance nominale des autres composants (PaC, machines à absorption...),
- Des rendements des échangeurs thermiques,
- Des consommations électriques des pompes,
- Des paramètres d'entrée des composants présentés sous forme de tableau en @modelisation_object
- La taille et la longueur des conduites.

Ce dernier critère représente une part très importante dans le calcul du coût global d'une telle installation. En effet, l'augmentation récente du prix du mètre linéraire de conduite se répercute sensiblement sur le retour sur investissement des centrales solaires. \
Dans la suite, il sert de cas d'étude pour choisir la méthode d'optimisation.

== Introduction aux problèmes d'optimisation
Soit un problème à n variables indépendantes (discrètes et/ou continues) où n est très grand (> 20). On appelle fonction coût une fonction de la forme :
$ f:RR^n #h(6pt) --> RR \ 
#h(8pt) accent(U,arrow)=mat(u_1;"[...]"; u_n) --> f(accent(U,arrow)) $
 
L'objectif d'une optimisation est de trouver au moins un jeu de paramètres minimisant la ou les fonction(s) coût#footnote()[Dans le cas d'une optimisation multi-objectif, un front de Pareto peut être utilisé pour évaluer les solutions]. Un problème d'optimisation est donc de la forme $"PO" : "min"_x (f(accent(U,arrow)))$. Les contraintes de conception et les contraintes physiques permettent, en général, de borner chaque variable $u_i$ (ex : le diamètre d'une conduite admet des valeurs comprises entre 5 et $500 "mm"$). \ 

Dans le cas du dimensionnement d'une unité de production d'énergie, la méthode de dimensionnement présentée en @methode_monoobjective a permis de s'absoudre des paramètres physiques et donc de réduire considérablement le nombre total de paramètres. Cette réduction n'est pas possible dans le cas d'une simulation semi-physique. Le problème d'optimisation s'effectue sur un ensemble de paramètres important. Par conséquent, il est impossible d'en évaluer toutes les combinaisons de valeurs possibles pour en déterminer la meilleure. On appelle ce type de problème des problèmes np-difficiles @methode_monoobjective, où np signifie "non-polynomial". C'est à dire que le temps nécessaire pour trouver l'optimum n'est pas polynomial : il prendrait plus d'une vie humaine pour aboutir à un résultat. \

Face à ce constat, il apparait déraisonné de vouloir trouver un optimum à de tels problèmes. Une alternative moins ambitieuse est de déterminer un nombre de solutions "satisfaisantes". Pour cela, il est toujours nécessaire d'explorer l'espace des solutions. Les méthodes métaheuristiques permettent justement de l'explorer "intelligement", c'est-à-dire de trouver des solutions satisfaisantes sans balayer entièrement l'univers des possibilités, et donc de réduire le temps de calcul.

== Méthodes d'optimisation métaheuristiques <sect_opti_meta_heuritic>

=== Définition des méthodes métaheuristiques
Une méthode métaheuristique est une méthode d'optimisation basée sur comportements présents dans la nature. Le terme "heuristique" renvoie à la fonction première de l'algorithme qui est la recherche de solutions. Le terme "méta" met en avant la capacité de ces algorithmes à résoudre des problèmes de natures différentes sans changer fondamentalement leur principe. A titre d'exemple, on en dresse une liste non-exhaustive :
- Le choix du chemin optimal à emprunter par une colonie de fourmis pour trouver la source de nourriture a donné naissance à l'algorithme _ant colony_,
- Le comportement d'un essaim d'insecte, d'un banc de poisson ou encore d'un banc d'oiseaux : _particle swarm optimization_
- Le déplacement dans l'espace d'une abeille entre la ruche et une fleur :  _Bee colony_,
- Le ruissellement d'une rivière d'une source d'eau en altitude jusqu'à la mer  : _Water Cycle Algorithm_,
- La sélection naturelle (donc la sélection génétique) : l'ensemble des algorithmes génétiques.


Développées depuis 1965, il en existe à aujourd'hui un très grand nombre. Elles peuvent être classées de plusieurs façons. Une classification mathématique  a été réalisée par l'équipe du projet MealPy @noauthor_introduction_nodate, visible en annexe 1. Une autre classification plus simple est basée sur l'origine naturel des méthodes :
- Les méthodes basées sur des populations : 
  -  Les essaims particulaires, 
  - La différentiation génétique,
  - [...]
- Les méthodes basées sur les trajectoires :
  - Le ruissellement de l'eau,
  - [...]

Dans la suite, deux algorithmes ont été testés sur le problème du dimensionnement des conduites du champ solaire :
- La méthode d'essaim particulaire, recodée entièrement pour ce cas d'étude,
- L'algorithme de différentiation génétique importé depuis la libraire scipy.

Des algorithmes de la librairie Mealpy, dérivés de lalgorithme de l'essaim particulaire, ont été essayés sur ce problème. Les résultats, peu intéressants, n'ont pas été présentés dans ce document.

=== Principe général
Dans son cours de 2018 @cerf_techniques_2018, M. Max CERF illustre le fonctionnement général des méthodes d'optimisation métaheuristques en @fonctionnement_general_metaheuristique : 
#figure(table(
  image("Illustrations/Principe general metaheuristique.PNG", width:70%)) ,
  caption :[Principe général des méthodes métaheuristiques @cerf_techniques_2018],
  kind:image) <fonctionnement_general_metaheuristique>

Une population initiale est instanciée dans laquelle chaque individu se voit attribuer un vecteur de variables initial. Elles peuvent être choisies aléatoirement ou assignées par l'utilisateur. Un procedé itératif est utilisé pour explorer l'espace des solutions  et intensifier les recherches localement. On parle respectivement de la *diversification* et de *l'intensification* d'une méthode d'optimisation métaheuristique.\

Chaque algorithme possède des paramètres à ajuster pour piloter ces deux comportements. Leur paramétrage, pour un problème d'optimisation donné, est un processus itératif qui nécessite à la fois des connaissances sur l'algorithme et une compréhension approfondie du problème. 

Finalement, l'utilisation de méthodes métaheuritique d'optimisation peut être décomposée en plusieurs étapes : 

1. *Comprendre le problème :* Chaque problème d'optimisation a un nombre de paramètres différents et des bornes différentes. Certains algorithmes ne sont pas adaptés aux problèmes ayant un très grand nombres de variables. D'autres, à l'inverse, ne convergent pas pour un petit jeu de variable. 

2. *Réaliser une étude de sensibilité :* Certaines variables ont une influence très faible sur le coût de la fonction. Il est nécessaire de les trouver et de les éliminer des variables à optimiser afin de réduire au strict nécessaire l'espace des solutions. Une étude de sensibilité permet de les détecter. Le principe est d'évaluer la fonction coût en fixant la valeur de toutes les variables sauf de celle étudiée. On fait varier cette dernière sur tout sa plage de valeurs possible. Puis, on fixe de nouvelles valeurs aux autres variables, et on fait varier à nouveau la variable étudiée. Si le coût calculé n'a pas beaucoup évolué, alors on élimine la variable. Ce processus est répété pour toutes les variables.

3. *Sélectionner de l'algorithme :* Parfois, plusieurs minimaux locaux pouvant abriter potentiellement des solutions intéressantes sont connus. Dans ce cas, le choix de l'algorithme peut être amené à sélectionner plus facilement un type de solution qu'un autre. 

4. *Identifier des paramètres :* Chaque algorithme métaheuristique a des paramètres qui lui sont propres. 

  Par exemple : 
     - La taille de la population,
     - Le nombre d'itérations maximal,
     - La taille du voisinage.
     - etc...
     Pour un même problème d'optimisation, la taille de la population idéale d'un algorithme n'est probablement pas la même que pour un autre.

5. *Définir des plages de valeurs possibles des varibles :* Isoler au mieux l'espace des valeurs possible pour chaque variable permet de dimuner grandement l'espace des solutions (d'autant plus quand le nombre de variables est élevé). 

6. *Effectuer un réglage itératif :* Evaluer l'évolution de la fonction coût en modifiant de manière itérative les paramètres de l'algorithme. Finalement, choisir le meilleur jeu de paramétres expérimenté, c'est à dire diminuant le coût de la fonction le plus rapidement. Certaines librairies comme mealpy sont dotées de méthodes aidant au paramétrage.

== Mise en équation du problème

Soit un champ solaire dont le site industriel et la répartion des 250 collecteurs sont connus.

On donne ci-dessous un schéma de la répartition en @disposition_capteurs.
#figure(table(image("Illustrations/opti_capteurs_solaires_disposition2.png", width:90%), stroke:none) ,
  caption :[Disposition du champ solaire],
  kind:image) <disposition_capteurs>

Les lignes représentent les chemins possibles des conduites reliant les différents collecteurs entre eux. L'objectif est de déterminer le flux d'eau à l'intérieur du champ pour diminuer le coût de la tuyauterie. En effet, un débit de fluide important dans un tronçon implique un grand diamètre de conduite, donc un prix linéaire du tronçon plus élevé. La fonction objective est donc l'évaluation du coût de l'installation pour les débits massiques de chaque intersection de conduite. 

=== Création de la fonction objective

1. Fixer l'arrrivée et le départ d'eau du champ solare par rapport à la position de la centrale solaire (Débit = 38 L/min),
2. Positionner les points d'intérêt :
  - Positionner les intersections de conduites,
  - Positionner les coudes,
  - Evaluer les chemins possibles du fluide,
  - Regrouper toutes les positions dans un vecteur,
3. Ecrire pour chaque intersection la conservation du débit masse : 
  - Vitesse maximale de $"1,8" m.s^(-1)$ dans les conduites
  - Conservation du débit dans les coudes,
  - Convention : Le débit est positif de bas en haut et de gauche à droite, sinon il est compté négativement.
4. Calculer le coût de la tuyauterie : 
  - Déterminer le diamètre de la tuyauterie en fonction du débit de fluide qui la traverse,
  - Déterminer le coût linéaire des conduites en fonction de leur diamètre#footnote[Un tableau donne le coût spécifique de chaque conduite en fonction de son diamètre en annexe 3],
  - Déterminer le coût de chaque conduite en multipliant son coût linéaire par sa longueur.

Ces étapes nous permettent de créer un système d'équations (de conservation de la masse) et d'inconnues (les débits des conduites) sur-déterminé. Une dernière étape est donc nécessaire pour sélectionner les variables consituant un système d'équations linéaires. Dans cet exemple, les 258 variables sélectionnées sont donc les variables d'optimisation. En évaluant ce système, la fonction objective doit pouvoir renvoyer le coût de la configuration.

Un jeu de variables initial est donné en entrée du programme. Chaque particule de la population initiale se voit attribué un génome légèrement différent de ce vecteur initial afin d'encourager la diversification. Le résulat, sous forme graphique, est renvoyé  avec l'évaluation de la fonction coût en @disposition_initiale.
#figure(table(image("Illustrations/opti_res_DE_60s.png", width:90%), stroke:none) ,
  caption :[Disposition du champ solaire],
  kind:image) <disposition_initiale>

Cette solution présente un coût de 4.229.621 #sym.euro. Elle est volontairement aberrante pour permettre une meilleure diversification.

== Choix de la méthode

=== algorithme de l'essaim particulaire
Biomimétique, cette méthode s’inspire du comportement grégaire d’animaux (une nuée d'oiseaux, un banc de poissons, un essaim d'insectes etc...). Un essaim est défini comme un groupe d'individus (ou particules) où chaque individu est réparti aléatoirement sur l’espace des solutions et se voit attribuer une vitesse nulle. C'est à dire que la position de chaque individu est définie par un jeu de valeurs pour chacun des paramètres d'optimisation. Au fur et à mesure des itérations, les individus évoluent guidés par trois tendances différentes : \
- Une tendance à continuer dans leur lancée (le terme d’inertie, concept de diversification),
- Une tendance à explorer l’espace dans la direction la meilleure position enrigistrée par l'individu (concept d’intensification)
- Une tendance à explorer l’espace dans la direction où se situe le meilleur individu de l’essaim, autrement dit celui minimisant le plus la solution (concept d’intensification). \

Chaque individu se voit attribuer aléatoirement une pondération de ces trois tendances, le rendant unique dans son comportement. Un paramétrage correctement effectué permet l’accumulation de particules aux alentours de la solution globale en un minimum d’itérations. La position de la meilleure particule (celle minimisant au plus la fonction coût) est retenue comme meilleure solution du problème. 

==== Pseudo-code

- Définir les bornes du domaines des solutions
- Définir la classe "particule" 
  - Définir et initialiser la position initiale d'une particule dans l'espace des solutions $p_0$
  - Initialiser une vitesse nulle : $v(k=0) <- 0$ avec k la k-ième itération 
  - Initialiser la meilleure position de la particule par la position initiale : $p_b <-- p_0$ 
  - Chosir aléatoirement les pondérations *$w$*, *$a$*, *$b$* respectivement du terme d'*inertie*, d'*intensification par la meilleur position de la particule* $p_b$, d'*intensification par la position de la meilleure particule de l'essaim* $p_g$. 
  - Choisir $xi$ entre 0 et 0.5 comme taux d'acceptation d'erreur.
  - Créer les méthodes suivantes : 
    - Calcul de la vitesse de la particule pour la k-ième itération :
      - Choisir aléatoirement deux nombres $r_1$ et $r_2$ compris entre 0 et 1
      - Récupérer $p_g$
      - $v'_k <- w.v_"k-1" + a.r_1.(p_b - p_"k-1") +b.r_2.(p_g - p_"k-1")$
      - Si $p'_k < p_"k-1"$ alors :
        - $p_k <- p'_k$
        - Si $p_k < p_b$ alors : $p_b <-- p_k$
        - Si $p_k < p_g$ alors : $p_g <-- p_k$
      - Sinon : 
        - Choisir aléatoirement un nombre $beta$ en 0 et 1
        - Si $xi$ < 0.1 : $p_k <- p'_k$
        - Sinon : $p_k <- p_"k-1"$

- Définir la classe "essaim"
  - Définir un nombre de particules n et les instancier
  - Parcourir les positions initiales des particules et trouver la meilleure : $p_g$
  - Créer les méthodes suivantes : 
    - Déterminer la meilleure particule
    - Actualiser les positions des particules en appelant pour chacune la méthode « calcul de la vitesse » puis « calcul de la position »
- Instancier un objet essaim de $N_"particules"$ particules
- Définir la fonction coût
- Définir une condition d’arrêt
- Tant que la condition d’arrêt n’est pas respectée faire :
  - Appliquer la méthode « Détermination de la meilleure particule » à l'essaim
  - Appliquer la méthode « Actualisation des positions des particules » à l'essaim
- Retourner $p_g$

==== Paramétrage

  Suite au paramétrage, on donne les valeurs retenues dans le tableau ci-dessous :

  #{
  set par(justify:false)
  align(center)[#table(
  columns: (auto, auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,

  align(center)[*Paramètres*], align(center)[*Rôle*], align(center)[*Type de paramétrage*], align(center)[*Valeurs \ possibles*], align(center)[*Valeur \ retenue*],

   $N_"particules"$,[Taille de la population],[Fixé par l'utilisateur.rice], [$I = [2 ; +infinity]$ \ odg : 10 \~ 100],[100],
  // 1ère ligne
  $alpha$,[Intensification ($p_b$)],[Aléatoire puis fixé \ pour chaque itération], [$I=[0;1]$], [N/A],
  //2ème ligne
  $b$,[Intensification ($p_g$)],[Aléatoire puis fixé \ pour chaque itération],[$I=[0;1]$],[N/A],
  //3ème ligne
  $w$, [Terme d'inertie], [Aléatoire puis fixé \ pour chaque itération],[$I=[0;1]$],[N/A],
  //4ème ligne
  $r_1$, [Pondération \ Intensification ($p_b$)], [Aléatoire à chaque itération ],[$I=[0;1]$],[N/A],
  //5ème ligne
  $r_2$, [Pondération \ Intensification ($p_g$)], [Aléatoire à chaque itération ],[$I=[0;1]$],[N/A],
  //6ème ligne
  $xi$, [Taux d'acceptation d'erreur], [Fixé par l'utilisateur.rice], [ $I=]0;1[$ \ odg : 0.01 \~ 0.15],[0.05],
  //7ème ligne
  $N_"itérations,max"$, [Nombre maximal d'itération], [Fixé par l'utilisateur.rice], [ $I=]1;+infinity[$ \ odg : 100],[1500],
  )]
  }

=== Algorithme à évolution différentielle
L'algorithme à évolution différentielle considère une population d'individus possédant chacun un génome. Ce dernier est le vecteur des paramètres à optimiser. À chaque itération, un individu principal est considéré. Il subit un brassage génétique avec trois autres individus. Si "l'enfant" résultant du brassage minimise plus la fonction coût que son parent principal, alors il prend sa place au sein de la population. Sinon, il n'est pas conservé. C'est la phase d'intensification. La phase de diversification est permise grâce aux mutations spontanées chez l'"enfant".

==== Pseudo-code#footnote()[Source : @storn_differential_1997]

- Choisir la taille de la population NP
- Choisir la propabilité de cross-over $"CR" in [0;1]$
- Choisir la pondération différentiel $F in [0;2]$,
- Chosir la probabilité de mutation $PP_"mutation" in [0;1]$
- Choisir la pondération mutagène $F' in [0.5;1.5]$,
- Initialiser les individus avec des positions aléatoires ou un jeu de positions initial
- Définir la fonction coût f
- Définir une condition d’arrêt
- Tant que la condition d’arrêt n’est pas respectée faire :
  - Pour chaque individu x de génome $I_0$ de la population faire :
    - Sélectionner trois individus de génome $I_1$, $I_2$, $I_3$ différents de x
    - Sélectionner un index aléatoire $R in {1,...,n}$ où n est la dimension du problème (Dans l'exemple, n = 258),
    - Déterminer le génome $y = [y_1,...,y_n]$ du nouvel individu (muté ou enfant) comme suit :
      - Pour chaque $i in {1,...,n}$, chosir un nombre aléatoire de distribution uniforme $r_i = U(0,1)$
      - Si $r_i < "CR"$ ou $i=R$ alors : $y_i=I_"1,i" + F*(I_"2,i" - I_"3,i")$
      - Sinon : $y_i = x_i$
      - Si $r_i < PP_"mutation" : y_i=I_"0,i".F'$
    - Si $f(y) <= f(x)$, remplacer l'individu $I_0$ par sa mutation ou par son enfant de génome y.
- Sélectionner l'individu de la population minimisant la fonction coût.
    
==== Paramétrage

  #{
  set par(justify:false)
  align(center)[#table(
  columns: (auto, auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,

  align(center)[*Paramètres*], align(center)[*Rôle*], align(center)[*Type de paramétrage*], align(center)[*Valeurs \ possibles*], align(center)[*Valeur \ retenue*],

   $N_"particules"$,[Taille de la population],[Fixé par l'utilisateur.rice], [$I = [2 ; +infinity]$ \ odg : 10 \~ 100],[15],
  // 1ère ligne
  $"CR"$,[Probabilité de mutation],[Fixé par l'utilisateur.rice], [$I=[0;1]$], [0],
  //2ème ligne
  $F$,[Pondération différencielle],[Fixé par l'utilisateur.rice],[$I=[0;2]$],[0],
  //3ème ligne
  $PP_"Mutation"$, [Probabilité de mutation], [Fixé par l'utilisateur.rice],[$I=[0;1]$],[0.05],
  //4ème ligne
  $F'$, [Pondération \ mutagène], [Aléatoire à chaque itération ],[$I=[0.5;1.5]$],[N/A],
  //7ème ligne
  $N_"itérations,max"$, [Nombre maximal d'itération], [Fixé par l'utilisateur.rice], [ $I=]1;+infinity[$ \ odg : 50],[30000],
)]}

Pour ce problème, seule la mutation de l'individu est considérée car le cross-over d'une conduite à l'autre ne fait pas sens. 
== Résulats et analyse

#let fig_DE = figure(table(image("Illustrations/opti_capteurs_solaires_jonathan_disposition.png", width:100%), stroke:none) ,
  caption :[Configuration optimisée par l'algorithme génétique],
  kind:image) 

#let fig_SW = figure(table(image("Illustrations/opti_res_DE_60s.png", width:100%), stroke:none) ,
  caption :[Configuration optimisée par l'algorithme de l'essaim particulaire],
  kind:image)
  
#table(columns : (auto,auto), stroke:0pt,
fig_DE,fig_SW)

L'algorithme de différenciation génétique de scipy a permis d'obtenir une configuration de 668 965 #sym.euro contre 3 722 066 #sym.euro pour l'essaim particulaire, soient respectivement des réductions de 84% et 11%. 

On remarque que l'algorithme génétique a exploré un chemin différent de la solution initiale. A l'inverse, l'algorithme de l'essaim a réalisé des modifications locales de la configuration initiale. La diversifaction réalisée par l'algorithme de Scipy a permis de déterminer une configuration réduisant considérablement les coûts. En effet, la solution proposée par l'ingénieur d'études était quant à elle 10% plus chère.

== Conclusion

La disposition et le nombre de collecteurs d'une centrale solaire thermique ne suffisent pas à en estimer le coût. La tuyauterie du champ elle-même doit être dimensionnée. Ce dimensionnement, réalisé par un.e ingénieur.e étude thermique et fluides, peut être optimisé par méthode méta-heuristique. Plusieurs de ces méthodes existent.  Dans cet exemple, l'algorithme de différenciation génétique de la librairie scipy a réussi à diminuer à hauteur de 10% le coût total de la tuyauterie. Les algorithmes basés sur la méthode des essaims particulaires n'ont pas donné de résultats satisfaisants, ce qui pourrait être lié au nombre de variables d'optimisation trop important. Finalement, cet exemple d'utilisation ouvre la voie à l'amélioration des méthodes de dimensionnement de l'entreprise. 

#pagebreak()
//************************************************************
//                          Conclusion
//************************************************************

#heading(numbering:none)[*Conclusion*]
\
Remplacer les énergies fossiles de l'industrie est une nécessité autant économique (stabilisation des coûts liés à l'énergie) qu'écologique (décarbonation des procédés). Absolicon AB Solar Collector en a fait son domaine d'expertise notamment via la conception, la fabrication et l'installation de centrales solaires thermiques à concentration.

D'une manière plus générale, une unité de production industrielle bas-carbone, bien que complexe et nécessitant de lourds investissements, permet d'obtenir un coût global de la chaleur stable. Plus la part d'énergie renouvelable et gratuite augmente, plus ce coût est estimé à la baisse. Un dimensionnement fin des ces installations, pour un site industriel donné, est nécessaire à la réalisation d'études de pré-faisabilité réalistes. Ce faisant, leur coûts peuvent être ajustés aux contraintes des clients et motiver plus de projets de construction. 

Pour cela, la mise en place d'une simulation semi-physique est nécessaire afin de tenir compte au mieux comportements physiques influençant le productible et le coût. Développée de manière itérative dans le cadre de ce stage de fin d'étude, elle a pu être validée par comparaison expérimentale avec des installations réelles par le département process. Aidée par des méthodes méta-heuristiques et d'un bon savoir-faire industriel, elle permet également d'affiner le dimensionnement de certaines parties du champ comme la tuyauterie. 

Cet outil, modulable, sera amélioré au fur et à mesure du temps par l'entreprise. Notamment, l'utilisation de méthodes méta-heuristiques pourra être plus largement déployé. Par exemple, leur utilisatiion permettrait d'améliorer le dimensionnement du champ, du stockage thermique, et des autres composants de production d'énergie.

#pagebreak()
//************************************************************
//                         Bibliographie
//************************************************************
//#set bibliography(title :heading(numbering:none)[*Bibliographie*])

#bibliography("Ma bibliothèque.bib",
  title : "Bibliographie")

#pagebreak()
//************************************************************
//                            Annexes 
//************************************************************
#heading(numbering:none)[*Annexes*]
#heading(level:2, numbering:none)[*Annexe 1 : Type de méthodes métaheuristiques*] 

#figure(image("Illustrations/bio_inspired.png"), caption:[Type de méthodes métaheuristiques @noauthor_introduction_nodate])

#pagebreak()

#heading(level:2, numbering:none)[*Annexe 2 : Définition des irradiances solaires @berton_modelisation_2022*] 

#align(center)[#image("Annexes/Extrait_rapport_alternance_2-1.png", width:116%)]

#align(center)[#image("Annexes/Extrait_rapport_alternance_2-2.png", width:116%)]

#pagebreak()

#heading(level:2, numbering:none)[*Annexe 3 : Coût linéaires des conduites en fonction de leur diamètre*] <annexe3>

#v(80pt)

#let l1 = [0,50, 65, 80, 100, 125, 150, 200, 250, 300, 350, 400, 450, 500]
#let l2 = [0, 91.86,100.16, 122.09, 143.27, 169.24, 198.40,263.44, 328.47, 393.50, 458.53, 523.57, 588.60, 653.63]

#table(columns : (auto,auto, auto, auto, auto,auto,auto, auto, auto, auto,auto,auto, auto, auto, auto),
align: (horizon + center),
[*DN*],[0],[50], [65], [80], [100], [125], [150], [200], [250], [300], [350], [400], [450], [500],
[*Coût [#sym.euro/m]*], [0], [91.86],[100.16], [122.09], [143.27], [169.24], [198.40], [263.44], [328.47], [393.50],[ 458.53], [523.57], [588.60], [653.63])

