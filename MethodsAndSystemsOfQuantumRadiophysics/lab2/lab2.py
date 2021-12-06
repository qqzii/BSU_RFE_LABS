from functions import common_graph, interpolated_graph

import pandas
from math import pi


def main():
    data1 = pandas.read_csv('data/table1.csv')

    temperature = data1['T']
    nm = data1['Nm']
    nl = data1['Nl']
    nn = data1['Nn']

    interpolated_graph(temperature, nm, ['graph1', 'T', 'Nm', 'График зависимости плотности излучения от температуры'])
    interpolated_graph(temperature, nl, ['graph2', 'T', 'Nl', 'График зависимости яркости от температуры'])
    interpolated_graph(temperature, nn, ['graph3', 'T', 'Nn', 'График зависимости световой отдачи от температуры'])

    data2 = pandas.read_csv('data/table2.csv')

    wavelength = data2['lambda']
    tau1 = data2['tau1']
    tau2 = data2['tau2']
    ro = data2['ro']

    common_graph(wavelength, tau1,
                 ['graph4', '\u03BB', '\u03C4\u2081', 'График зависимости \u03C4\u2081 от длины волны'])
    common_graph(wavelength, tau2,
                 ['graph5', '\u03BB', '\u03C4\u2082', 'График зависимости \u03C4\u2082 от длины волны'])
    common_graph(wavelength, ro, ['graph6', '\u03BB', '\u03C1', 'График зависимости \u03C1 от длины волны'])

    const = {'l1': 500, 'l2': 100, 'a1': 250, 'a2': 250, 'a_inp': 100, 'l': 200000}
    signal = []
    for i in range(len(wavelength)):
        signal.append(((1/pi) * const['a1'] * const['a2'] * const['a_inp'] * const['l'] * tau1[i] * tau2[i] * ro[i] *
                       wavelength[i]) / ((const['l1'] ** 2) * (const['l2'] ** 2)))

    common_graph(wavelength, signal, ['graph7', '\u03BB', 'Фс', 'График зависимости полезного сигнала от длины волны'])


if __name__ == "__main__":
    main()
