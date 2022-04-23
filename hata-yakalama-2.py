#Bir sayının çift olup olmadığını sorgulayan bir fonksiyon yazın.
#Bu fonksiyon, eğer sayı çift ise return ile bu değeri dönsün. 
#Ancak sayı tek sayı ise fonksiyon raise ile ValueError hatası fırlatsın. 
# Daha sonra, içinde çift ve tek sayılar bulunduran bir liste tanımlayın ve 
# liste üzerinde gezinerek ekrana sadece çift sayıları bastırın.


def cift_mi(sayi):
    
    if (sayi % 2 == 0):
        return sayi
    else:
        raise ValueError
liste = [34,2,1,3,33,100,61,1800]

for i in liste:
    try:
        print(cift_mi(i))
    except ValueError:
        pass
