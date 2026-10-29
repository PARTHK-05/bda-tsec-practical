def hash1(n):
    return n % 5

def hash2(n):
    return (2*n+3) % 5

n = int(input("Enter the number of elements to be inserted = "))

bit_arr = [0]*5

print(bit_arr)

for i in range(n):
    a = int(input("Enter the element : "))
    temp1 = hash1(a)
    bit_arr[temp1] = 1

    temp2 = hash2(a)
    bit_arr[temp2] = 1

print("After insertion = ")
print(bit_arr)


n = int(input("enter the number of elements to be checked = "))

for i in range(n):
    a = int(input("enter the element {i+1} = "))
    temp1 = bit_arr[hash1(a)]
    temp2 = bit_arr[hash2(a)]

    if temp1==0 or temp2==0:
        print("Definetely not present")
    else:
        print("may be present")
    
