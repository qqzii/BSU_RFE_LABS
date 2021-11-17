import matplotlib.pyplot as plt
import numpy


def common_graph(x, y, title):
    count = 0
    while count < len(y):
        plt.scatter(x[count], y[count], c='black', s=10)
        count += 1
    plt.title(title[3])
    plt.xlabel(title[1])
    plt.ylabel(title[2])
    plt.plot(x, y)
    plt.grid()
    plt.savefig('graphs/' + title[0] + '.png')
    plt.close()


def interpolated_graph(x, y, title):
    plt.grid()
    plt.title(title[3])
    plt.xlabel(title[1])
    plt.ylabel(title[2])

    count = 0
    while count < len(y):
        plt.scatter(x[count], y[count], c='black', s=10)
        count += 1

    x_new = numpy.linspace(min(x), max(x), 500000)
    poly = numpy.polyfit(x, y, 5)
    y_new = numpy.polyval(poly, x_new)
    plt.plot(x_new, y_new)
    plt.savefig('graphs/' + title[0] + '.png')
    plt.close()
