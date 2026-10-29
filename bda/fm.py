def hash_func(n):
    return (3 * n + 1) % 8

n = int(input("Enter the number of elements = "))
list1 = []

for i in range(n):
    a = int(input("Enter the element = "))
    h = hash_func(a)
    binary = format(h, 'b')
    list1.append(binary)

print("Binary list of hash values:", list1)

zeros = []

for b_str in list1:
    # If the binary string is just "0", trailing zeros = 0
    if b_str == "0":
        zero = 0
    else:
        zero = len(b_str) - len(b_str.rstrip("0"))
    zeros.append(zero)

R = max(zeros)
predict = 2 ** R

print("Maximum trailing zeros (R) =", R)
print("Estimated distinct elements =", predict)