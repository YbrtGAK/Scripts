#import "@local/paper_course_template:1.0.0": *
#import "@local/typst-boxes-main:1.0.0" : *
#import "@local/math_lib:1.0.0" : *
#import "@preview/tablex:0.0.8"

#show: course.with(
  title: [Equations de conservation des écoulements diphasiques],
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
                          Corps du cours
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

= Contexte
== Introduction
=== 