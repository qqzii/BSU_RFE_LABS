from functions import graph_add

from math import sin, cos, pi
import pandas


def main():
    data1 = pandas.read_csv('measurements/first.csv')
    data2 = pandas.read_csv('measurements/second.csv')

    angle = data1['angle']
    measurements1 = data1['U']
    measurements2 = data2['U']

    graph_add(angle, measurements1, ['graph1', '\u0398, \u00B0', 'U, B', 'Экспериментальный график №1'])
    graph_add(angle, measurements2, ['graph2', '\u0398, \u00B0', 'U, B', 'Экспериментальный график №2'])

    n21 = 3.91
    d = 1 * 10 ** -3
    wavelength = 3 * 10 ** 8 / 30 * 10 ** 9

    theoretical_u = []
    # theoretical_t = []

    for i in angle:
        r12 = ((((n21 ** 2) - (sin(i) ** 2)) ** 0.5) - (n21 ** 2) * cos(i)) / (
                (((n21 ** 2) - (sin(i) ** 2)) ** 0.5) + (n21 ** 2) * cos(i))

        phi = 2 * pi * d / wavelength * (n21 ** 2 - (sin(i) ** 2)) ** 0.5

        u = ((4 * (r12 ** 2) * (sin(phi) ** 2)) / (((1 - (r12 ** 2)) ** 2) + 4 * (r12 ** 2) * (sin(phi) ** 2))) ** 0.5
        # t = (((1 - (r12 ** 2)) ** 2) / (((1 - (r12 ** 2)) ** 2) + 4 * (r12 ** 2) * (sin(phi) ** 2))) ** 0.5

        theoretical_u.append(round(u * 10 ** 15, 3))
        # theoretical_t.append(round(t, 3))

    graph_add(angle, theoretical_u, ['graph3', '\u0398, \u00B0', 'U, B', 'Теоретический график'])
    # graph_add(angle, theoretical_t, ['graph4', '\u0398, \u00B0', 'U, B', 'Теоретический график'])


if __name__ == "__main__":
    main()
