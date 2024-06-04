#align(center)[#heading()[Glossary]]
#let dpf = $Delta P_(f,2#sym.phi)$
\
#{

set text(size:7.8pt)
let barre =  text(size:20pt)[ #sym.bar.v]
align(left)[
#table(align : horizon, columns:(auto, auto, auto, 7cm),

align(center)[Symbol],align(center)[Name],align(center)[Definition],align(center)[Mathematical formula],

align(center)[#dpf], [Frictional pressure drop [Pa]],[Pressure drop component due to friction between the fluid and the canal's wall and friction within the fluid itself],
[ $ "dp"/"dz" barre_(2 phi , f) = Phi_"Lo"^2  "dp"/"dz" barre_("Lo,f") =  Phi_"Go"^2  "dp"/"dz" barre_("Go,f") \ 
 #h(28pt) = Phi_"L"^2  "dp"/"dz" barre_("L,f") =  Phi_"G"^2  "dp"/"dz" barre_("v,f") $ ],

align(horizon + center)[$ Phi_k \  $] + align(bottom + left)[$ k in [l, l_o, v, v_o] $], [Pressure drop multipliers [-]],[],
[ $  $ ],

 
align(center)[$ chi  $], [Martinelli parameter [-]],[Ratio of pressure drops of single-phase flow terms],[$ chi = sqrt(("dp/dz")_l/("dp/dz")_v)  $],

align(center)[$ epsilon  $], [Void fraction [-]],[Fraction of the channel volume that is occupied by the gas phase],[$ epsilon = A_v/(A_v + A_l) $],

align(center)[$ lambda_c  $], [Capillary lenth [m]],[Length scaling factor that relates surface tension and gravity],[$ lambda_c = sqrt(gamma/(Delta rho. g)) $],

align(center)[$B_o$], [Bond number [-]],[Mesure the importance of gravitational forces compared to surface tension forces for the liquid front's movement],[$ B_0 = (L_c/lambda_c)^2 =(Delta rho . g.d_H^2)/sigma $],

align(center)[$C_o$], [Confinement number [-]],[],[$ C_o = 1/sqrt(B_o) = 1/L_c . sqrt(sigma/(g. Delta rho)) $],

align(center)[CHF], [Critical Heat flux [-]],[Heat flux at which boiling ceases to be an effective form of transferring heat from a solid surface to a liquid],[$ q/A_max="CHF".rho_v [(sigma . g.(Delta rho))/(Rho_v^2)]^(1/4) (1+ rho_v/rho_L) #footnote[Zuber, Novak (June 1959). "Hydrodynamic aspects of boiling heat transfer". doi:10.2172/4175511. Retrieved 4 April 2016.] $ ],

align(center)[Eö], [Eötvos [-]],[Criterion for defining the two-phase macro-to-microchannel transition],[$ "Eö" = (g. Delta rho. lambda_c^2)/(8. sigma) $],

align(center)[$F_o$],[Froude number [-]],[Ratio of the flow inertia to the external field (the latter in many applications simply due to gravity)],[$ F_0=u/(sqrt(g.L)) $],

align(center)[$f$],[Fanning friction factor [-]],[Ratio of the local shear stress with the local flow kinetic energy density],[$ f= tau/(rho*(u^2)/2) $],

align(center)[HTC], [Heat Transfert Coefficient [-]],[Proportionality constant between the heat flux and temperature difference],[$ "HTC"=q/(Delta T) $],

align(center)[ONB], [Onset of Nucleate Boilling [-]],[Onset activation for the first nucleation sites],align(center)[N/A],

align(center)[OSV], [Onset of Significant Void [-]],[Incipient of increased vapor convection : bubbles begin moving toward the core],align(center)[N/A],

align(center)[s],[Symmetry [-]],[Mesure of the none-uniformity of the liquid's level around the canal's perimeter [-]],[$ s=d_"top"/r = 1 - (t_"bottom" - t_"top")/d $],

align(center)[Y], [Chisholm parameter [-]],[Ratio of pressure drops of single-phase flow terms considering they occupy the whole volume each],[$ Y = sqrt(("dp/dz")_"lo"/("dp/dz")_"vo")  $],


)]
}