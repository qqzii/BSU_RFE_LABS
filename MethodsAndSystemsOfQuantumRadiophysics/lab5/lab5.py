from functions import common_graph

import pandas


def main():
    data_with_glass = pandas.read_csv('measurements/with_glass.csv.csv')
    data_without_glass = pandas.read_csv('measurements/without_glass.csv')

    concentrate = data_with_glass['solution_volume']
    transparency = data_with_glass['transparency']
    turbidity = data_with_glass['turbidity']
    dilution = data_with_glass['dilution']

    common_graph(concentrate, transparency,
                 [
                     'graph1',
                     'Количество туши, мл',
                     'Прозрачность, A',
                     'График зависимости от количества туши (без фильтра)'
                 ])
    common_graph(concentrate, turbidity,
                 [
                     'graph2',
                     'Количество туши, мл',
                     'Мутность, V',
                     'График зависимости от количества туши (без фильтра)'
                 ])
    common_graph(concentrate, dilution,
                 [
                     'graph3',
                     'Количество туши, мл',
                     'Коэффициент ослабления, F',
                     'График зависимости от количества туши (без фильтра)'
                 ])

    transparency = data_without_glass['transparency']
    turbidity = data_without_glass['turbidity']
    dilution = data_without_glass['dilution']

    common_graph(concentrate, transparency,
                 [
                     'graph4',
                     'Количество туши, мл',
                     'Прозрачность, A',
                     'График зависимости от количества туши (с фильтром)'
                 ])
    common_graph(concentrate, turbidity,
                 [
                     'graph5',
                     'Количество туши, мл',
                     'Мутность, V',
                     'График зависимости от количества туши (с фильтром)'
                 ])
    common_graph(concentrate, dilution,
                 ['graph6',
                  'Количество туши, мл',
                  'Коэффициент ослабления, F',
                  'График зависимости от количества туши (с фильтром)'
                  ])


if __name__ == "__main__":
    main()
