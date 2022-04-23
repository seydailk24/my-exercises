'''
fibonacci serisi yeni bir sayiyi onceki iki sayinin toplammi seklinde olusturur.
1,1,2,3,5,8,13,21,34,........

'''

a = 1
b = 1 

fibonacci = [a, b]


for i in range(20):
   
    a,b = b, a+b 
    print("a : ", a , "b :" , b)

    fibonacci.append(b) #listeme yeni sayilari atiyorum 


print(fibonacci)

