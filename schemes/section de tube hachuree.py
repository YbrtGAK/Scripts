# -*- coding: utf-8 -*-
"""
Created on Mon Jan  8 17:09:45 2024

@author: yberton
"""

import matplotlib.pyplot as plt
import numpy as np
import matplotlib.patches as patches


"""Draw"""
fig = plt.figure(dpi=200)
ax = fig.add_subplot(projection='polar')
#plt.axis('off')
theta = np.deg2rad(np.linspace(0,360,1000))
r = [6 for e in theta]
r2 = [2 for e in theta]

plt.polar(theta,r,'k')
plt.polar(theta,r2,'k')
#plt.annotate(text='', xy=(0.8,0), xytext=(1,0), arrowprops=dict(arrowstyle='<->'))
"""arr1 = plt.arrow(0, 0.7, 0, 0.3, alpha = 1, width = 0.001,
                 edgecolor = 'black', facecolor = 'black',linestyle='-', lw = 1, zorder = 0.1)"""
plt.fill_between(theta, r, r2, hatch='/',alpha=0, linestyle='--')
plt.axis('off')