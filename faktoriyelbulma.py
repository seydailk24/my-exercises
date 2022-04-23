#print('*********************************

#faktoriyel bulma programi


#cikmak icin q 'ya basin ******************')

while True:  #kullanici q ya basana kdr while dongumuz donsun 
    sayi = input("sayi: ")
    if (sayi == "q"):
        print("program sonlandiriliyor. ")
        break

    else:
        sayi = int(sayi)

        faktoriyel = 1 
         
         for i in range(2, sayi+1): #range ile sayi fonksiyonu olusturduk 
            faktoriyel *= i
        print("faktoriyel", faktoriyel)