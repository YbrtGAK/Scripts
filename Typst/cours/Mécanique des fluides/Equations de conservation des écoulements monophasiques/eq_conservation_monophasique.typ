#import "@local/paper_course_template:1.0.0": *
#import "@local/typst-boxes-main:1.0.0" : *
#import "@local/math_lib:1.0.0" : *

#show: course.with(
  title: [Equations de conservation des écoulements monophasiques],
  field : [Cours de mécanique des fluides],
  author: "Yann Berton",
)

#let vol = text(8pt)[V]

#set math.equation(numbering:none)
#show math.equation.where(numbering: "(1)") : it => grid(
  columns : (1fr,auto,1fr),
  [],
  math.equation(block : true)[#block(stroke : black, clip:true, inset : 6pt)[#it.body]],
  h(20pt) + align(right + horizon, "(" + str(counter( math.equation).at(it.location()).first())+ ")"))

= Contexte & Rappels de cours

== Hypothèse du milieu continue

- La structure est continue : \ 
 Soit un système physique dont un ensemble de grandeurs physiques $V = (v_1, [...], v_n)$ sont étudiées avec $n in NN$. L'hypothèse du milieu continue implique que  $forall v_i in V, v_i (vec(x),t) "est une fonction continue " $ où  M est un point matériel du solide.
- Condition de validité :
  - La longueur caractéristique du système $L_c$ doit être très grande devant le libre parcours moyen  *$l$*. Pour s'en assurer, on introduit le nombre adimensionnel de Knudsen : *$K_n=l/L$*. Ainsi l'hypothèse du milieu continu est valide si $K_n << 1.$ 
 
== Thèorème de la divergence (Théorème de Green-Ostrogradski)
#outlinebox(
  title: [Thèorème de la divergence],
  color: none,
  width: auto,
  radius: 2pt,
  centering: false
)[
  #table(
  columns: (1fr,1fr),
  stroke: none,
  $ underbrace(integral_V vec(nabla)vec(F).d V, "Divergence d'un champ" \ "vectoriel sur un volume " \ "de    " RR^3) = underbrace(integral.cont_(diff V) vec(F).vec(d A), "Flux à travers " \ "la frontière du " \ "du volume") $,
  {set list(marker: ([ • ],sym.arrow))
  set text(size : 9pt)
  underline[Où :]
  [ 
  - V : Volume de $RR^3$ [$m^3$],
  - $diff V$ : Frontière de V [$m^3$],
  - $vec(dS)$ : Vecteur normal à la surfaced tel que $vec(dS) = vec(n).d A$
  - $vec(F)$ : Fonction dérivable en tout point de V]}
)]

== Etude cinétique & Description eulerienne :
Lors de l'étude cinétique, seul le mouvement est étudié indépendemment de ses causes. \ 
La description du mouvement du fluide selon Euler nécessite :
- L'utilisation d'un champ de vecteurs,
- La connaissance de l'accélération du fluide :

Considérons une grandeur physique scalaire ou vectorielle quelconque du fluide, appelée G. Par définition, $G accent(=,"^") G(vec(x),t)=G(x,y,z,t)$. On donne la différentielle totale de G : 
  
$ "dG" &= (diff G)/(diff x)."dx" + (diff G)/(diff y)."dy" + (diff G)/(diff z)."dz" + (diff G)/(diff t).d t \
arrow.double "dG"/d t &= (diff G)/(diff x)."dx"/d t + (diff G)/(diff y)."dy"/d t + (diff G)/(diff z)."dz"/d t + (diff G)/(diff t) \
arrow.double "dG"/d t &= (diff G)/(diff x)."vx" + (diff G)/(diff y)."vy" + (diff G)/(diff z)."vz" + (diff G)/(diff t) $
Il vient ainsi l'expression de la dérivée particulaire d'une grandeur physique G : \

#math.equation(numbering: "(1)",
supplement : "l'équation",
block : true,$ "dG"/dt = "DG"/dt = (diff G)/(diff t) + (vec(nabla)G).vec(v) $) <equation_derivee_particulaire>
La description eulérienne s'intéresse à l'évolution des grandeurs physiques du fluide pour chaque point de l'espace en fonction du temps. L'accélération du fluide en fait partie. En évaluant l'équation (1) avec la vitesse du fluide, il vient : 

#math.equation(numbering:"(1)",
supplement : "l'équation",
block : true,
$vec(a) = (D vec(v))/dt = (diff vec(v))/(diff t) + (vec(nabla)vec(v)).vec(v)$) <eq_der_particulaire>

== Théorème fondamental de Cauchy : Tenseur de contraintes
#outlinebox(
  title: [Théorème fondamental de Cauchy #footnote[Source : https://savoir.ensam.eu/moodle/pluginfile.php/26945/mod_resource/content/0/Theoreme_de_Cauchy.pdf]],
  color: none,
  width: auto,
  radius: 2pt,
  centering: false
)[
Il existe [...] en tout point M du milieu continu, un tenseur du second ordre $tensor(sigma) (M)$,
appelé tenseur des contrainte de Cauchy tel que : $vec(T)(M,vec(n))=tensor(sigma).vec(n)$]

Le tenseur de contraintes représente l'action des forces de surface à l'intérieur du fluide et avec son environnement. Dans cette partie, on cherche à déterminer son expression mathématique.

Soit un repère orthonormé (M, $vec(e_1)$, $vec(e_2)$, $vec(e_3)$). On considère un volume élémentaire $Omega$ de forme tétraédrique. On repère son sommet M et trois des ses faces $\{S_i "où" i in (1,2,3)}$ situées dans les plans des coordonnés. La $4^"ème"$ face, appellée S, a pour surface $alpha$ et admet une normale $vec(n)$. 

#figure(image("Illustrations/Démonstration théorème fondamental de Cauchy - Tétrahèdre.jpeg", width:40%), caption: [Tétrahèdre élémentaire #footnote()[source : LA313 - Base de la MMC - L. Champaney]])

On appelle les $n_j$ les cosinus directeurs de $vec(n)$ tels que $vec(n)=sum_(j=1)^(3) n_j .vec(e_j)$. Triviallement, il vient l'expression des aires des surfaces $A_j$ : $S_j=alpha. n_j$. \
#text(fill:red)[Aller voir https://mmaya.fr/cours-mmc/poly/Contrainte/Contrainte_2.htm pour de meilleures explications \ ]
La hauteur issue de M est h, #vec($Gamma$) est le vecteur des contraintes de cisaillement et #vec($T$) est le vecteur des contraintes normales appliquées au surfaces de $Omega$. On effectue un bilan des forces sur le volume $Omega$ : 

$ &underbrace(integral_(Omega) (rho .vec(Gamma)) .d Omega,"Efforts intérieurs") =
underbrace(integral_(Omega) vec(F^d) .d Omega, "Forces volumiques") +
underbrace(integral_S vec(T)(N, vec(n)) .dS, "Force appliquée sur" \ "A") +
underbrace(sum_(j=1)^(3) integral_(S_j) vec(T)(N_j,-vec(e_j)).dS, "Somme des forces appliquées sur" \ "les" A_j) \

arrow.double &(h.alpha)/3 .(rho .vec(Gamma) - vec(F^d)) = alpha. vec(T)(M,vec(n)) + sum_(j=1)^(3) n_j.alpha. vec(T)(M_j,-vec(e_j)) 
$
Or, $Omega$ étant un volume infinitésimal, h tend vers 0 dans l'expression précédente. 
\ Il vient alors : 
$
alpha. vec(T)(M,vec(n)) = - sum_(j=1)^(3) n_j.alpha. vec(T)(M_j,-vec(e_j)) \ 
$
En posant $vec(T_j) = -vec(T)(M_j,-vec(e_j))$, on obtient finalement la relation suivante : \ 
$ vec(T)(M,vec(n)) = n_j vec(T)_j $

Puisque le vecteur $vec(n)$ a une orientation quelconque, cette relation montre que toute surface de normale $vec(n)$ admet un vecteur contrainte proportionnel au vecteur unitaire $vec(n)$. 
Ainsi, tout point M du milieu continu admet un tenseur du second ordre $tensor(sigma)$
appelé tenseur des contrainte de Cauchy, tel que :

$ vec(T)(M,vec(n))=tensor(sigma).vec(n) $

== Conservation de la masse

=== Définition du débit masse

L'objectif de cette partie est de définir le débit masse. Soit un fluide s'écoulant dans un tube de section S. Considérons une surface infinitésimale dS de centre M. On appelle dm la masse s'écoulant au travers de cette section pendant un temps infinitésimal dt. On donne ci-après l'expression de sa variation temporelle : 
$ &(d^2m)/(d t. d S) = rho(vec(x),t).vec(v)(vec(x),t).vec(n) $
Triviallement, on peut isoler la différencielle totale de l'équation : \ 
$ &d m = integral_(M in S)((rho(vec(x),t).vec(v)(vec(x),t).vec(n)).dS).d t $ 

Il vient l'expression du débit masse $Q_m$ : 

$ Q_m eq.est dm/dt = integral.cont_(M in S)(rho(vec(x),t).vec(v).vec(n)).dS $ <eq_debit_masse>

En définissant le vecteur densité de flux de masse $vec(J)(vec(x),t)=rho(vec(x),t).vec(v)(vec(x),t)$, l'expression du débit masse devient : 
$ Q_m=integral.cont_(M in S)(vec(J)(vec(x),t).vec(n)).dS $

=== Equation de continuité

On considère un volume de contrôle fixe quelconque V délimité par une surface fictive fermée S. Par définition, on a : 
$ m(t)=integral_(M in V) (rho(vec(x),t)).d tau $ <equation3>
où $d tau$ est un volume infinitésimale de V. \
Cette masse varie dans le temps à travers la surface S, donc : #text(fill:red)[Mieux expliquer avec le théorème de Reynolds !!!!]
$ dm/dt = - integral.cont_(M in S) rho(vec(x),t).vec(v). vec(dS)_"ext" $
Le signe "moins" vient du fait que $vec(S)_"ext"$ est dirigé vers l'extérieur de la surface S.
Or, $dm/dt$ peut également être exprimée à partir de la définition de la masse : 
$ dm/dt = integral_(M in V) diff(rho(vec(x),t))/(diff t).d tau $

Le théorème de Green-Ostrogradski permet d'exprimer une intégrale de surface à une intégrale sur le volume : 
$ dm/dt = integral_(M in V) diff(rho(vec(x),t))/(diff t).d tau = integral_(M in V) -nablav(rho(vec(x),t).vec(v)(vec(x),t)).d tau $

Donc il vient : 
$ integral_(M in V) (diff(rho(vec(x),t))/(diff t) + nablav(rho(vec(x),t).vec(v)(vec(x),t))).d tau = 0 #h(10pt) forall M in V $

Il vient finalement l'*équation de continuité* (ou équation de conservation de la masse) : 
#math.equation(numbering:"(1)",
supplement : "l'équation",
block : true,$ div(rho. vec(v)) + (diff rho)/(diff t) = 0 $) <equation_continuite>

_Remarque :_ On peut exprimer @equation_continuite en fonction de la dérivée particulaire.
En évaluant @equation_derivee_particulaire avec la massse volumique, on obtient : 

$ Der(rho) &= derpt(rho,"t") + (vec(nabla) vec(v)).rho \ arrow.double derpt(rho,"t") &= Der(rho) - (vec(nabla) vec(v)).rho $

En remplaçant dans @equation_continuite on obtient :

$ &nablav(rho .vec(v)) + ("D"rho)/(dt) - (vec(nabla) vec(v)) .rho = 0 \

arrow.double &rho (vec(nabla) vec(v)) + vec(v).(vec(nabla) rho) + Der(rho) - vec(v) .(vec(nabla) rho) = 0 \
$
Finalement il vient une seconde forme de @equation_continuite.
$
Der(rho) + rho (vec(nabla) vec(v)) = 0
$
Si le fluide est *incompressible*, la relation se simplifie : 
$ vec(nabla) vec(v) = 0 $

=== Conservation de la quantité de mouvement

L'évolution de la quantité de mouvement du volume de contrôle V est donnée par l'équation ci-dessous :

$ 
underbrace(derpt("","t") integral_(M in V) (rho .vec(v))."dV", "Variation de la QdM" \ "dans V") + 
underbrace(integral.cont_(M in S) (rho .vec(v) . vec(v)).vec(n).dS, "Flux de QdM "\ "au travers S") = 
underbrace(integral_(M in V) vec(F_V)."dV", "QdM générée/absorbée" \ "par les forces volumiques") + underbrace(integral_(M in S) vec(F_S).dS, "QdM générée/absorbée" \ "par les forces surfaciques")
$ <eq_bilan_qdm>

On se place dans le cas où la force gravitationnelle est la seule force à distance.
Il vient alors : $vec(F_V) = rho. vec(g)$. Egalement, le théorème fondamental de Cauchy nous permet d'obtenir l'expression des forces surfaciques : $vec(F_S) = vec(T)(N, vec(n)) .dS = tensor(sigma). vec(n)$ \
Il vient alors : 

$ 
derpt("","t") integral_(M in V) (rho .vec(v))."dV" + 
integral.cont_(M in S) (rho .vec(v).vec(v) .vec(n)).dS = 
integral_(M in V) (rho. vec(g))."dV" +
integral.cont_(M in S) (tensor(sigma). vec(n)).dS
$

Afin de continuer le développement, l'utilisation du théorème de la divergence permet d'exprimer les intégrales de surface en intégrale sur le volume. Ainsi : 
$
cases(
integral.cont_(M in S) (rho .vec(v).vec(v) .vec(n)).dS = integral_(M in V) (nablav (rho. vec(v).vec(v))). "dV" ,
integral.cont_(M in S) (tensor(sigma). vec(n)).dS = integral_(M in V) (nabla tensor(sigma) ."dV"))
$
En remplaçant ces résultats dans l'équation de conservation de la quantité de mouvement, on obtient :

$ 
derpt("","t") integral_(M in V) (rho .vec(v))."dV" + 
integral_(M in V) (nabla (rho. vec(v).vec(v). vec(n))). "dV" = 
integral_(M in V) (rho. vec(g))."dV" +
integral_(M in V) (nabla tensor(sigma) )."dV"
$
dV étant une valeur arbitraire, on peut le considérer égal pour tous les termes de l'équation :

$ 
&integral_(M in V)(derpt("","t")
 (rho .vec(v)) + 
 nablav (rho. vec(v).vec(v) ) -
rho. vec(g) -
nabla tensor(sigma) )
&= 0 \ 
&derpt("","t")
 (rho .vec(v)) +
 nablav (rho. vec(v).vec(v) ) =
rho. vec(g) +
nabla tensor(sigma) 
$
On développe le terme $nablav (rho. vec(v).vec(v). ) = rho. vec(v). nablav(vec(v)) + vec(v). nablav(rho. vec(v)) $ :

$
&vec(v). derpt("","t")
 (rho ) + rho. derpt("","t")
 (vec(v) ) +
 rho. vec(v). nablav(vec(v)) + vec(v). nablav(rho. vec(v)) =
rho. vec(g) +
nabla tensor(sigma) 
$
On remarque la seconde forme de @equation_continuite dans ce développement. Après simplification des termes, il vient *la première loi du mouvement de Cauchy* :  

#math.equation(numbering:"(1)",
supplement : "l'équation",
block : true)[$
&rho. derpt("","t")
 (vec(v) ) +
 rho. vec(v). nabla vec(v) =
rho. vec(g) +
nabla tensor(sigma) 
$] <eq_1ere_loi_mvt_cauchy>

Puisque le tenseur de Cauchy est symétrique à coefficients réels, il est diagonalisable et admet trois valeurs propres réelles. Ces valeurs propres sont appellées contraintes principales, orientées selon des vecteurs propres appelés directions principales. \
De plus, on peut définir un champ scalaire P(vec(x),t) tel que lorsque le fluide est au repos, il se réduit à la pression statique. Ainsi définit, on peut l'exprimer en fonction du tenseur des contraintes de cauchy :

$ P(vec(x),t) = 1/3.(sigma_"11" + sigma_"22" + sigma_"33")= 1/3."trace"(tensor(sigma)) $

Il représente la contrainte normale moyenne du fluide.
\ En appellelant $tensor(sigma_d)$ le tenseur déviateur, il vient : 
$ tensor(sigma) = -P(vec(x),t).I + tensor(sigma_D) $
Où $"trace"(tensor(sigma_D)) = 0$ et $I$ la matrice identité.
\
En remplaçant la nouvelle expression du tenseur de Cauchy dans @eq_1ere_loi_mvt_cauchy on obtient : 

$

rho. derpt(vec(v),t) + rho. vec(v). nabla vec(v) &=rho. vec(g) - nablav(-P(vec(x),t).I + tensor(sigma_D)) \

so rho. derpt(vec(v),t) + rho. vec(v). nabla vec(v) &=rho. vec(g) - nablav(-P.I) + nablav tensor(sigma_D) \

so rho. derpt(vec(v),t) + rho. vec(v). nabla vec(v) &=rho. vec(g) -P. nablav I + I. nablav(-P) + nablav tensor(sigma_D) \

$
Finalement on peut réécrire @eq_1ere_loi_mvt_cauchy pour obtenir l'équation de conservation de la quantité de mouvement : 
#math.equation(numbering:"(1)",
supplement : "l'équation",
block : true)[$
rho. derpt(vec(v),t) + rho. vec(v). nabla vec(v) &=rho. vec(g) - nablav P + nablav tensor(sigma_D) 
$] <eq_cons_QDM>

== Conservation de l'énergie

Considérons @eq_cons_QDM de conservation de la quantité de mouvement : 
$
rho. derpt(vec(v),t) + rho. vec(v). nabla vec(v) &=rho. vec(g) - nablav P + nablav tensor(sigma_D) 
$
En multipliant chaque terme par la vitesse $vec(v)$, on obtient le bilan des puissances volumiques  : 
$
&vec(v). rho. derpt(vec(v),t) + vec(v). rho. vec(v). nabla vec(v) = vec(v). rho. vec(g) - vec(v). nablav P + vec(v).nablav tensor(sigma_D) \

so & 1/2. rho. derpt(vec(v)^2,t) + 1/2.vec(v). rho. nabla vec(v)^2 = vec(v). rho. vec(g) - vec(v). nablav P + vec(v).nablav tensor(sigma_D) \
$
Finalement, on obtient l'équation de conservation de l'énergie mécanique : 
#math.equation(numbering:"(1)",
supplement : "l'équation",
block : true)[$
& rho. Der("")(1/2. abs(abs(vec(v)))^2) = -vec(v). nablav P + vec(v). (rho. vec(g)) + vec(v).nablav tensor(sigma_D)
$] <eq_cons_Emeca>

Cette expression peut être inclue dans l'expression générale de *l'énergie massique totale e* d'une particule où : 
$ e #eq_df e_"méca" + u = e_"cinétique" + e_"potentielle" + u $
Avec u l'énergie interne de la particule. 

L'objectif est d'établir un bilan d'énergie. Pour cela, les hypothèses suivantes sont réalisées :
- La seule force à distance en présence est le poids :
  - L'énergie potentielle d'une particule de fluide par unité de masse est : $- vec(g).vec(z)$ avec z la hauteur,
- Il n'y a pas de réaction chimique, nucléaire ou de production/génération de chaleur au sein du fluide.

Ainsi, on peut poser l'équation de conservation d'énergie suivante : 

#{

math.equation(numbering : "(1)", supplement : "l'équation", block : true)[#text(size:7pt,$ 
underbrace(
  derpt(,t) integral_V (rho. u + 1/2. rho. vec(v)^2 - rho. vec(g). vec(z)). d V,
  "Variation d'énergie dans V"
) 
+
underbrace(
  derpt(,t) integral_A (rho . u + 1/2. rho. vec(v)^2  - rho. vec(z). vec(g)). vec(v). vec(n). d A,
  "Flux d'énergie à travers A"
) 
= 
underbrace(
  integral_A (vec(dot(q)).vec(n)). d A,
  "Flux de chaleur " \ "au travers A"
) 
+
underbrace(
   integral_A vec(n). (sigma. vec(n)). d A,
  "Variation d'énergie due " \ "aux forces surfaciques"
) 
$ ) <bilan_energie>

]
}

Où : 
- $vec(dot(q))$ est le vecteur de densité de flux de chaleur au travers de la surface A,
- $integral_A vec(n). (sigma. vec(n)). d A$ est obtenu en appliquant le théorème de Cauchy à l'expression de la variation d'énergie due aux forces surfaciques $integral_A (sigma. v).d A$,

En remarquant que le volume est indépendant du temps, puis en appliquant le théorème de la divergence, il vient : 
#math.equation(numbering : "(1)", supplement : "l'équation", block : true)[
$ derpt(,t) [rho. (u + 1/2. v^2 - vec(g). vec(z))] + nablav[rho. vec(v). (u + 1/2. vec(v)^2  - vec(g))] = -nablav vec( dot(q)) + nablav(sigma. vec(v)) $] <equation_8>

Développons les expressions de l'énergie cinétique, de l'énergie interne et de l'énergie potentielle spécifiques dans le terme de gauche : 

- $derpt(,t) [rho. (u + 1/2. v^2)] = rho. derpt(,t)(u + 1/2. v^2) + derpt(rho,t). (u + 1/2. v^2 )$
- $nablav[rho. vec(v). (u + 1/2. v^2)] =  nablav (rho.  vec(v)) .(u + 1/2. vec(v)^2 )  + (rho. vec(v)). nablav(u+ 1/2. v^2)$
- $derpt(,t) (rho. vec(g). vec(z)) + nablav. (rho. vec(v). vec(g). vec(z)) &= vec(g). vec(z). derpt(rho,t) + rho. derpt(,t). (vec(g). vec(z)) + vec(g). vec(z). nablav(rho. vec(v)) + rho. vec(v). nablav(vec(g). vec(z)) \

$

En sommant l'énergie cinétique et l'énergie interne il vient : 
#{
set text(size:7pt) 
$
derpt(,t) [rho. (u + 1/2. v^2)] + nablav[rho. vec(v). (u + 1/2. v^2)] = 
rho. derpt(,t)(u + 1/2. v^2)  +  (rho. vec(v)). nablav(u+ 1/2. v^2) + (u + 1/2. v^2). (derpt(rho,t) + nablav(rho. vec(v)))
$}

On peut remplacer dans ces termes @equation_continuite de conservation de la masse : 
$
&derpt(,t) [rho. (u + 1/2. v^2)] + nablav[rho. vec(v). (u + 1/2. v^2)] = 
rho. derpt(,t)(u + 1/2. v^2)  +  (rho. vec(v)). nablav(u+ 1/2. v^2)
$
Donc : 
#math.equation(numbering : "(1)", supplement : "l'équation", block : true)[
$
&derpt(,t) [rho. (u + 1/2. v^2)] + nablav[rho. vec(v). (u + 1/2. v^2)] = rho. Der(,) (u + 1/2. abs(vec(v))^2) 
$] <equation_somme_u_Ec>
Egalement, on peut introduire la dérivée particulaire dans l'expression de l'énergie potentielle : \
$ derpt(,t) (rho. vec(g). vec(z)) + nablav. (rho. vec(v). vec(g). vec(z)) &= vec(g). vec(z). derpt(rho,t) + vec(g). vec(z). nablav(rho. vec(v)) + rho.(derpt(,t) (vec(g). vec(z)) + vec(v). nablav(vec(g). vec(z))) \
&= vec(g). vec(z). derpt(rho,t) + vec(g). vec(z). nablav(rho. vec(v)) + rho. Der(,).(vec(g). vec(z))
$
L'accélération de la pesanteur étant une constante du temps et de l'espace : $rho. Der(,).(vec(g). vec(z)) = rho. vec(g). vec(v)$. De plus, en factorisant les deux autres termes par $vec(g). vec(z)$, on introduit l'équation de continuité (@equation_continuite) : 

$ &derpt(,t) (rho. vec(g). vec(z)) + nablav. (rho. vec(v). vec(g). vec(z)) = vec(g). vec(z). underbrace((derpt(rho,t) +nablav(rho. vec(v))),"= 0") + rho. vec(g). vec(v) \ 
$
#math.equation(numbering : "(1)", supplement : "l'équation", block : true)[
$ &derpt(,t) (rho. vec(g). vec(z)) + nablav. (rho. vec(v). vec(g). vec(z)) = rho. vec(g). vec(v) $] <equation_10>

Finalement, en repartant de @equation_8 de conservation d'énergie, on peut injecter les nouvelles expressions des énergies cinétique, interne, et potentielle développées dans @equation_somme_u_Ec et  @equation_10 : 

$ &derpt(,t) [rho. (u + 1/2. v^2 - vec(g). vec(z))] + nablav[rho. vec(v). (u + 1/2. vec(v)^2  - vec(g))] = -nablav vec(dot(q)) + nablav(sigma. vec(v)) \
so & rho. Der(,) (u + 1/2. abs(vec(v))^2) - rho. vec(g). vec(v) = -nablav vec(dot(q)) + nablav(sigma. vec(v)) \
so &rho. Der(,) (u + 1/2. abs(vec(v))^2) = -nablav vec(dot(q)) + rho. vec(g). vec(v) + nablav(sigma. vec(v))
$