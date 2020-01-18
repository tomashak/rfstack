print("Second Number Pattern ")
lastNumber = 7
for row in range(1, lastNumber):
    for column in range(1, row + 1):
        print(column, end=' ')
    print("")