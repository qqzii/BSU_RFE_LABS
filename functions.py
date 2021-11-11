import matplotlib.pyplot as plt


def graph_add(x, y, title):
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
