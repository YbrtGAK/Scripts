//Imports
//Def variables
#let imm = "imm"
#let bot = "bot"
#let mid = "mid"
#let top = "top"
#let CHF = "CHF"

//Text settings
#set text(fill: black)
#set heading(numbering: "1.1.1.a")

//Rules settings
#show table.cell.where(y: 0): it => {
set text(weight: "bold")
it
}
#show table.cell.where(x: 0): it => {
set text(weight: "bold")
it
}
#let pat = pattern(size: (15pt, 5pt))[
  #place(line(start: (0%, 0%), end: (100%, 100%)))
]
#set text(size:9pt)
#set align(center)
#{}

//Mise en forme du tableau
//Mise en forme des bordures
#set table(stroke: (x, y) => (
  top: if y == 0 or y==1 { 2pt } else { 1pt },
  bottom: if y == 0 {2pt} else {1pt}
))

#let data_thermal_sensors = (
  ([201],"FRTD1",[Cold junction],[-],[-]),
  ([202],"iTC1",[$E_"i,imm"$],[-],[-]),
  ([203],"TC1",[$E_(i,bot)$],[0,999203138],[0,090049892]),
  ([204],"TC2",[$E_(i,mid)$],[1,007093392	],[-0,067784712]),
  ([205], "TC3",[$E_(i,top)$],[0,999629038	],[0,090337667]),
  ([206], "TC4",[$E_(1,bot)$],[0,99972736	],[0,089275501]),
  ([207], "TC5",[$E_(1,mid)$],[0,998990584	],[0,087979913]),
  ([208], "TC6",[$E_(1,top)$],[0,999507203	],[0,083640637	]),
  ([209], "TC7",[$E_(2,bot)$],[1,002805492	],[0,010259193]),
  ([210], "TC8",[$E_(2,mid)$],[0,999382786],[0,091773961]),
  ([211], "FRTD2",[Cold junction],[-],[-]),
  ([212], "TC9",[$E_(2,top)$],[1,000011497	],[0,077110999	]),
 ( [213], "TC10",[$E_(3,bot)$],[0,999967152	],[0,08251179	]),
  ([214], "TC11",[$E_(3,mid)$],[1,000509938	],[0,073671345	]),
  ([215], "TC12",[$E_(3,top)$],[0,998681182	],[0,056222984	]),
  ([216], "TC13",[$E_(o,bot)$],[1,000610859	],[0,045845514	]),
  ([217], "TC14",[$E_(o,top)$],[1,000201074	],[0,094409229	]),
  ([218], "iTC2",[$E_"o,imm"$],[-],[-]),
  ([219], "TC15",[$CHF_(bot)$],[0,998843899	],[Homemade]),
  ([220], "TC16",[$CHF_(top)$],[0,999954194	],[0,083520716	]),
  ([221],"FRTD3",[Cold junction],[-],[-]),
  ([222],"iTC3",[$"Tank"_(bot)$],[-],[-]),
  ([223],"iTC4",[$"Tank"_(top)$],[-],[-]),
  ([224],"iTC5",[$"Ph"_"i,imm"$],[1,004094734	],[0,012216993	]),
  ([225],"TC17",[$"Ph"_i$],[1,004175565	],[0,036247208	]),
  ([226],"TC18",[$"Ph"_1$],[0,999468873	],[0,091424732	]),
  ([227],"TC19",[$"Ph"_2$],[Homemade],[Homemade]),
  ([228],"TC20",[$"Ph"_3$],[1,000802287	],[0,067030995	]),
  ([229],"TC21",[$"Ph"_4$],[1,011770186	],[-0,115245067]),
  ([230],"aTC1",[$T_"amb"$],[-],[-]),
  ([231],"FRTD4",[Cold junction],[-],[-]),
  ([232],"iTC4",[$"Pump"_"i,imm"$],[1,003862311	],[-0,023933146]),
  ([233]," ",[],[],[]),
  ([234]," ",[],[],[]),
  ([235]," ",[],[],[]),
  ([236]," ",[],[],[]),
  ([237]," ",[],[],[]),
  ([238]," ",[],[],[]),
  ([239]," ",[],[],[]),
  ([240]," ",[],[],[]),
  )
  #figure(caption : "Thermal sensor inventory (2023 - 2026)",
  table(
  columns:(3cm,3cm,3cm,3cm,3cm),
  align: horizon+center,
  table.header[Canal][Indice][Localization][a [-]][b [°C]],
  ..data_thermal_sensors
  .map(((canal,indice,localisation,reference,calibre)) => {
    let cell = table.cell.with(fill :
     if indice.first() == "T" {blue.lighten(75%)} else if indice.first() == "F" {gray.lighten(60%)} else if indice.first() == "i" {green.lighten(75%)} else if indice.first() == "a" {} else {pat})
    (cell(canal), cell(indice), cell(localisation), cell(reference), cell(calibre))
  }).flatten()
  ))

#{
set text(size:8pt)
set align(left)
h(37pt) + [*#sym.convolve* ] + [E : Evaporator, Ph : Preheater ; i : inlet, o : outlet ; imm : immerged \ ] 
h(37pt) + [*#sym.convolve* ] + [TC : Homemade $"Omega"^®$, Immerged TC : K405 $"Prosensor"^®$ ]
}
#pagebreak()

#let data_pressure = (
  ([102],"dP1",[Evaporator],[0-5 bars], [Keller PD-23],[a],[b]),
  ([112],"dP2",[Evaporator], [0-2 bars],[Emmerson Rosemount 3051],[125,126253],[-0,012395497]),
  ([113],"PA1",[Evaporator outlet], [0-35 bars],[Keller PA23],[a],[b]),
  ([114],"dP3",[Evaporator], [Emmerson Rosemount 3051], [0-50 mbars],[2190,335909],[-8820,69099]),
  ([115],"PA2", [Tank],[0-35 bars], [Keller PA23],[a],[b]),
  ([118],"PA3",[Evaporator inlet], [0-30 bars], [Keller PA23],[a],[b]),
  ([120],"PA4",[Pump inlet], [0-35 bars],[Keller PA23],[a],[b])
)
#table(
  columns: (2cm,2cm,2cm,2cm,2cm,2cm,2cm),
  rows:(auto, 1.2cm),
  align : horizon + center,
  table.header[Canal][Indice][Localization][Pressure range][Brand][a][b],
  ..data_pressure
  .map(((canal, indice, localization, pressure_range, brand, ta, tb)) => {
    let cell = table.cell.with(fill:
      if indice.first() == "d" {blue.lighten(75%)} else if indice.first() == "P" {green.lighten(75%)})
      (cell(canal),cell(indice),cell(localization),cell(pressure_range),cell(brand),cell(ta),cell(tb))
  }).flatten()
)