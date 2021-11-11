from math import sin, cos, pi
import matplotlib.pyplot as plt


def make_graph(degree, val, title):
    count = 0
    plt.title(title)
    while count < len(degree):
        plt.scatter(degree[count], val[count], c='black')
        count += 1
    plt.plot(degree, val)
    plt.grid()
    plt.savefig('graphs/' + title + '.png')
    plt.close()


def main():

    n21 = 3.91
    d = 1 * 10 ** -3
    light_speed = 3 * 10 ** 8
    g = 30 * 10 ** 9
    _lambda = light_speed / g

    rotation_angles = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70]
    measurements = [0.70, 0.94, 0.66, 0.76, 0.98, 0.65, 0.94, 0.73, 0.88, 0.90, 0.71, 0.22, 0.63, 0.89, 0.80]

    theoretical_val = []
    for i in rotation_angles:
        r = ((n21 ** 2 - sin(i) ** 2) ** 0.5 - n21 ** 2 * cos(i)) / (
                (n21 ** 2 - sin(i) ** 2) ** 0.5 + n21 ** 2 * cos(i))
        phi = 2 * pi * d / _lambda * (n21 ** 2 - sin(i) ** 2) ** 0.5
        t = ((1 - r ** 2) ** 2 / ((1 - r ** 2) ** 2 + 4 * r ** 2 * sin(phi) ** 2)) ** 0.5

        total_val = round(t, 2)
        theoretical_val.append(total_val)

    make_graph(rotation_angles, measurements, 'Измерения')
    make_graph(rotation_angles, theoretical_val, 'Теоретические значения')


if __name__ == "__main__":
    main()