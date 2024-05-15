#set page(width: auto, height: auto, margin: 1em, fill: white)
#import "@local/math_lib:1.0.0" : *

- $dot(m) incr, T_sat dcr spc so derpt(P,z) dcr$
- Transfert thermique dominant : NB 
- $forall x, incr T_sat, incr q, spc so incr HTC$
- $Delta dot(m) so  emptyset "sauf" T_sat, q <<$
- $"2 Méthodes tq "(epsilon <= "30%", FSR : 90% "filled")$
- $forall$ Méthodes : HTC surestimé