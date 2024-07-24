"""
28/11/2023 11:15 - Yann BERTON
"""
"""This script allows to analyze the "microsope confocal"'s roughness measurements"""

%matplotlib inline

#imports
import pandas as pd
import matplotlib.pyplot as plt
from numpy import abs, linspace
from scipy import integrate

#get data
path = "C:/Users/yberton/Documents/Expérimental/Rugosité/Mesures/Tube inox test/23-11-2023.csv"
df = pd.read_csv(path, encoding='unicode_escape',decimal='.',sep=';')

#Withdraw measure error
df = df[df['Z [mm]'] !=0]
df.rename(columns={'Z [mm]' : 'Zum', 'Y [mm]' : 'Ymm'}, inplace=True)
#Add Y as the index
df.set_index('Ymm', inplace=True)
df_zoom = df[df.index > 1]

#Ra calculus
f = lambda x : abs(x) 
integre = lambda y,z: integrate.trapz(z, x=y)
y = df.index ; z = df['Zum']
Y = y.values*1e3 ; Z = f(z).values
Ra = integre(Z,Y)/((df.index[0] - df.index[-1])*1e3)
print(Ra)

#Ra_zoom calculus
y = df_zoom.index ; z = df_zoom['Zum']
Y = y.values ; Z = f(z).values*1e-3 
Ra_zoom = integre(Z,Y)/((df.index[0] - df.index[-1])*1e3)
print(Ra_zoom)

#Nice plot
fig, ax = plt.subplots(1,1,figsize=(7*(1+5**0.5)/2,2))
#(2,2*(1+5**0.5)/2)
ax.spines['bottom'].set_position('center')
ax.plot(df.index, df['Zum'], 'k', label="Surface's profil")
ax.plot(df.index, [Ra*1e3 for i in range(len(df.index))], '--k')
ax.set_xlabel('Traverse length [mm]')
ax.set_ylabel(r'Depth [$\mu$m]')
ax.set_xlim(df.index.min(),df.index[0])
ax.set_ylim(df['Zum'].min(),df['Zum'].max())
ax.legend()
plt.show()


#Rq, Rv
Rp = df_zoom['Zum'].max()
Rv = df_zoom['Zum'].min()

#Plot the zoomed part
%matplotlib inline
fig, ax = plt.subplots(1,1,figsize=(7*(1+5**0.5)/2,2))
#plots
#Profil
ax.plot(df_zoom.index, df_zoom['Zum'],'-k')
#Ra
ax.plot(df_zoom.index, [Ra_zoom +  df_zoom["Zum"].mean() for i in range(len(df_zoom))],'--r')
ax.plot(df_zoom.index, [-Ra_zoom+  df_zoom["Zum"].mean() for i in range(len(df_zoom))],'--r')
#Rp
ax.plot(df_zoom.index, [Rp for i in range(len(df_zoom))],'--k')
#Rv
ax.plot(df_zoom.index, [Rv for i in range(len(df_zoom))],'--k')

#Axis setter
ax.spines['left'].set_position((('data', df_zoom.index[-1])))
ax.spines['right'].set_visible(False)
ax.spines['bottom'].set_position((('data', df_zoom["Zum"].mean())))
ax.spines['top'].set_visible(False)
ax.xaxis.set_ticks_position('bottom')
ax.yaxis.set_ticks_position('left')
ax.set_xlabel('Traverse length [mm]', loc="right")
ax.set_ylabel(r'Depth [$\mu$m]', loc="top")
#Put arrow at the edge of the axis
ax.plot((1), (df_zoom["Zum"].mean()), ls="", marker=">", ms=10, color="k",
        transform=ax.get_yaxis_transform(), clip_on=False)
ax.plot((df_zoom.index[-1]), (1), ls="", marker="^", ms=10, color="k",
        transform=ax.get_xaxis_transform(), clip_on=False)

plt.show()

