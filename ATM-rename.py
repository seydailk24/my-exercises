




#para cekme makinesine hosgeldiniz
#islemler ;
# 1. bakiye sorgulama 
# 2. para yatirma
# 3. para cekme 
#programdan cikmak icin 'q' ya basin.

bakiye = 1000

while True:
    islem = input("islemi seciniz: ")

    if (islem == "q"):
        print("yine bekleriz.")
        break
    elif (islem == "1"):
        print("bakiyeniz {} tl dir".format(bakiye))
    elif (islem == "2"):
        miktar = int(input("miktari giriniz :"))

        bakiye += miktar


    

    elif (islem == "3"):
        miktar = int(input("miktari giriniz: "))
        if (bakiye - miktar < 0):
            print("boyle bir miktar cekemezsiniz....")
            continue
        bakiye = 1000

    else:
        print("gecersiz islem......")



