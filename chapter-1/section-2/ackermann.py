#! /usr/env/bin python3

# Ackermann's function in Python for reference

def A(x, y):
    if y == 0:
        return 0
    if x == 0:
        return 2 * y
    if y == 1:
        return 2
    return A((x-1), A(x, (y-1)))

print(A(1, 10))
print(A(2, 4))
print(A(3, 3))
