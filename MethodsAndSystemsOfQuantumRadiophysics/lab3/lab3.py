from functions import interpolated_graph, common_graph
from math import pi


def main():

    focus = 100
    x1 = []
    y1 = []

    for _ in range(10, 50, 1):
        y1.append(4.45 * pi * pi * _**3 * 108 / focus**2)
        x1.append(_)

    diameter = 10
    x2 = []
    y2 = []

    for _ in range(20, 1000, 10):
        y2.append(4.45 * pi * pi * diameter ** 3 * 108 / _ ** 2)
        x2.append(_)

    interpolated_graph(x1, y1, [
        'graph1',
        'Диаметр входного зрачка',
        'Сигнал/шум',
        'График зависимости С/Ш от диаметра входного зрачка'
    ])

    common_graph(x2, y2, [
        'graph2',
        'Фокус',
        'Сигнал/шум',
        'График зависимости С/Ш от фокуса'
    ])


if __name__ == "__main__":
    main()
