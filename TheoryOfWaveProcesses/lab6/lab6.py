from functions import graph_add

import pandas
from math import cos, sin


data = pandas.read_csv('measurements/frequency_2500MHz.csv')
angle = data['angle']
u_max = data['U_max']
u_min = data['U_min']


x = []
y = []
for i in angle:
    x.append(sin(i))
    y.append(cos(i))


pf = 0.785
df = -1.571
a = cos(pf)
b = sin(pf)

px = []
for u in u_max:
    px.append(a * cos(u))

py = []
for u in u_max:
    py.append(b * cos(u - df))

graph_add(px, py, ['graph1', '.', '.', '.'])
