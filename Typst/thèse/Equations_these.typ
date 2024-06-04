#import "@local/math_lib:1.0.0" : *

#set math.equation(numbering:none)
#show math.equation.where(numbering: "(1)") : it => grid(
  columns : (1fr,3fr,1fr),
  [],
  math.equation(block : true)[#rect(inset:10pt)[#it.body]],
  align(right + horizon, "(" + str(counter( math.equation).at(it.location()).first())+ ")"))
#show heading.where(level:1) : it => align(center)[#it]
#show heading.where(level:2) : it => {
  underline[#it]}

= Equations d'intérêt pour l'étude de l'ébullition convective

== Dynamique des bulles

=== Equation de Rayleigh-Plesset (dérivée des équations de Navier-Stokes)
Equation différentielle non linéaire : Dynamique d'une *bulle sphérique* dans un *fluide incompressible* de dimension infini.

#math.equation(numbering:"(1)", supplement : "l'équation",
block : true)[$
R(t). dot2(R(t)) + 3/2.(dot(R(t)))^2 +  (4. nu_L)/R(t). dot(R) + (2.sigma)/(rho_L. R(t)) + (Delta P(t))/rho_L = 0 
$]
Où : \

$
cases(
 #h(2pt) #sym.circle.filled.tiny #h(5pt) R(t) &: "Rayon de la bulle [m]",
 #h(2pt) #sym.circle.filled.tiny #h(5pt) rho_L &: "Masse volumique de la phase liquide à la paroie" ["kg/"m^3],
 #h(2pt) #sym.circle.filled.tiny #h(5pt) nu_L &: "Viscosité cinématique de la phase liquide [m²/s]",
 #h(2pt) #sym.circle.filled.tiny #h(5pt) sigma &: "Tension de surface de l'interface [N/m] ",
 #h(2pt) #sym.circle.filled.tiny #h(5pt) Delta P(t) &= P_infinity (t) - P_B (t) "avec" P_B (t) "la pression interne de la bulle et" P_infinity (t) "loin de la bulle")
$

=== Equation de Gilmore
Equation différentielle non linéaire : Comparée à l'équation de Rayleigh-Plesset, la compressibilité du liquide est prise en compte et la viscosité présente uniquement par le biais de la compressibilité. 
$
(1-1/(c. R(t))). R(t). dot2(R)(t) + 3/2.(1 - (dot(R)(t))/(3. c.R(t))). dot(R)^2 = ((1+dot(R)(t))/(c. R(t))). H.R(t) + (1-dot(R)/(c.R(t))). R/(c.R(t)). dot(H). R(t)
$
Où : \

$
cases(
H &= n/(n-1). (P_infinity (t) + B)/rho_L . [((P+B)/(P_infinity (t) + B))^((n-1)/n) - 1],
c &= c_0. ((rho_g (t) - 2. sigma/R + B)/(P_infinity (t) + B))^((n-1)/(2.n)),
dot(H) &= D/(p_infinity (t)+ B). H - D/rho. ((P+B)/(P_infinity (t) + B))^((n-1)/n) + dot(R)/(rho_L . R). [(p_infinity(t) + B)/(P+B)]^(1/n). [(2. sigma)/R - 3. k. rho_g (t)]
)

$
