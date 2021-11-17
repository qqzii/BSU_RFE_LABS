from functions import common_graph, interpolated_graph


def main():
    delta = []
    d = []
    s = []

    for _ in range(0, 51):
        d.append(100 / (10 + _))
        delta.append(_)
        s.append(10 * (20 + _) / (10 + _))

    interpolated_graph(delta, d, [
        'graph1',
        'Расстояние между плоскостью анализа и главной плоскостью',
        'Диаметр входного зрачка',
        'График зависимости диаметра входного зрачка и его положения от \u0394'
    ])

    interpolated_graph(delta, s, [
        'graph2',
        'Расстояние между плоскостью анализа и главной плоскостью',
        'Положение выходного зрачка на оси',
        'График зависимости положения выходного зрачка на оси от \u0394'
    ])


if __name__ == "__main__":
    main()
