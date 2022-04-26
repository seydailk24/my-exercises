
---SINGLE SUBQUERIESSS--------


----Davis Thomas'nın çalıştığı mağazadaki tüm personelleri listeleyin.
--davidin calistigi birimin id sini bulduk 
Select store_id
from sale.staff
where first_name = 'Davis' and last_name = 'Thomas'
--- buradada 1 yerine yukaridaki kodu yazp store id si davis thomasin calistigi store id sine esit olan personellerin
--ciktisini verir 
SELECT *
from sale.staff
WHERE store_id = 1

-- Charles	Cussona 'ın yöneticisi olduğu personelleri listeleyin.

---charlis cussananin personel id si 2 dir 
SELECT staff_id
from sale.staff
WHERE first_name='Charles' and last_name='Cussona'
---simdi bu kisinin manageri oldugu tum kisileri bulucaz ayni id de olan 
SELECT *
FROM sale.staff
WHERE manager_id = 2 --ya by sekilde koyuluyo 

SELECT *
FROM sale.staff
WHERE manager_id = (SELECT staff_id --bu sekildede ayni cozum verir yuvalama yaptik 
from sale.staff
WHERE first_name='Charles' and last_name='Cussona'

)


-- 'The BFLO Store' isimli mağazanın bulunduğu şehirdeki müşterileri listeleyin.

SELECT city
from sale.store
WHERE store_name= 'The BFLO Store'


select *
from sale.customer
WHERE city = (SELECT city
from sale.store
WHERE store_name= 'The BFLO Store'

)
-- 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)' isimli üründen pahalı olan Televizyonları listeleyin.

SELECT list_price
from product.product
where product_name='Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'

----bu isimli urunden pahali olan iki ane urun var dedi bu asagidaki kod bana 
SELECT *
from product.product
where list_price > (
    SELECT list_price
from product.product
where product_name='Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'

)



--bu sorguyuda ilkine eklersek and diyip where yerinde bunuda ekleyebiliriz 
select category_id
from product.category
WHERE category_name = 'Televisions & Accessories'

-----MULTIPLE ROW SUBQUERIESLER---
----IN NOT IN ANY ALLL ULLANIYORUZZZZ YUKARIDAKI BUYUK ESIT KUUCK YERINEEEE---


-- Laurel Goldammer isimli müşterinin alışveriş yaptığı tarihte/tarihlerde alışveriş yapan tüm müşterileri listeleyin.

--ILK OLARAK BU KISININ ALSVERIS TARIHLERINI TESPIT ETMEMIZ LAZIM
--burada buldugum iki tarihi kullaniyorum simdi
SELECT a.order_date
FROM SALE.orders a, sale.customer b
WHERE a.customer_id=b.customer_id
AND b.first_name = 'Laurel'
AND b.last_name='Goldammer'

select	b.first_name, b.last_name, a.order_date
from	sale.orders a, sale.customer b
where	a.customer_id = b.customer_id and
		a.order_date IN (
			select	a.order_date
			from	sale.orders a, sale.customer b
			where	a.customer_id = b.customer_id and
					b.first_name = 'Laurel' and
					b.last_name = 'Goldammer'
		)
;

-- Game, gps veya Home Theater haricindeki kategorilere ait ürünleri listeleyin.
--	Sadece 2021 model yılına ait bisikletlerin adı ve fiyat bilgilerini listeleyin.

---2021 urunlerinden game gps ve home theather olmayanlar

SELECT *
from product.category
WHERE category_name in ('Game', 'gps','Home Theather')


SELECT *
from product.product
WHERE model_year = '2021' AND
      category_id NOT IN (
         SELECT category_id
         from product.category
         WHERE category_name in ('Game', 'gps','Home Theather') 
      )
      

-- 2020 model olup Receivers Amplifiers kategorisindeki en pahalı üründen daha pahalı ürünleri listeleyin.
-- Ürün adı, model_yılı ve fiyat bilgilerini yüksek fiyattan düşük fiyata doğru sıralayınız.

---enpahali urunu bulduk

SELECT b.list_price
from product.category a , product.product b 
WHERE category_name = 'Receivers Amplifier' 
AND a.category_id = b.category_id
---subqueries birden fazla satir dondururken buyuktur kucuktur esitir kullanamayiz any kullanabiliriz
--list pricedan sonra 
--->ALL kullandik cunku bu kategorideki urunlerin tamaindan pahali olani soruyor 
SELECT product_name, model_year, list_price
from product.product
where model_year = 2020 AND
      list_price >ALL (
          SELECT b.list_price
          from product.category a , product.product b 
          WHERE category_name = 'Receivers Amplifier' 
AND a.category_id = b.category_id)

ORDER BY list_price DESC


---veya selectin basina top 1 yazip > u kullanabiliriz 

SELECT product_name, model_year, list_price
from product.product
where model_year = 2020 AND
      list_price > (
          SELECT top 1 b.list_price
          from product.category a , product.product b 
          WHERE category_name = 'Receivers Amplifier' 
AND a.category_id = b.category_id)


-- Receivers Amplifiers kategorisindeki ürünlerin herhangi birinden yüksek fiyatlı ürünleri listeleyin.
-- Ürün adı, model_yılı ve fiyat bilgilerini yüksek fiyattan düşük fiyata doğru sıralayınız.

--bu soruda aynisi ama herhangi diyor 
----bu sefer ANY kullanacagiz 


select	product_name, model_year, list_price
from	product.product
where	model_year = 2020 and
		list_price >ANY (
			select	b.list_price
			from	product.category a, product.product b
			where	a.category_name = 'Receivers Amplifiers' and
					a.category_id = b.category_id)

ORDER BY list_price DESC


--                                correleted sub queries
-- 'Apple - Pre-Owned iPad 3 - 32GB - White' isimli ürünün hiç sipariş edilmediği eyaletleri listeleyiniz.
-- Not: Eyalet olarak müşterinin adres bilgisini baz alınız.




select	distinct [state]
from	sale.customer d
where	not exists (
			select	*
			from	sale.orders a, sale.order_item b, product.product c, sale.customer e
			where	a.order_id = b.order_id and
					b.product_id = c.product_id and
					c.product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White' and
					a.customer_id = e.customer_id and
					d.state = e.state
		)
;

-- 2020-01-01 tarihinden önce sipariş vermeyen müşterileri döndüren bir sorgu yazın. 
-- Bu sorguda 2020-01-01 tarihinden önce sipariş vermiş bir müşteri varsa sorgu herhangi bir sonuç döndürmemelidir.

select	b.customer_id, b.first_name, b.last_name, a.order_date
from	sale.orders a, sale.customer b
where	a.customer_id = b.customer_id and
		NOT EXISTS (
			select	*
			from	sale.orders c
			where	c.order_date < '2020-01-01' and
					b.customer_id = c.customer_id
		)
;

-- Jerald Berray isimli müşterinin son siparişinden önce sipariş vermiş 
-- ve Austin şehrinde ikamet eden müşterileri listeleyin.
;
WITH table_name AS (
		SELECT	MAX(B.order_date) last_order_date
		FROM	sale.customer A, sale.orders B
		WHERE	A.first_name = 'Jerald' AND
					A.last_name = 'Berray' AND
					A.customer_id = B.customer_id
	)

SELECT	*
FROM	table_name
;



-- Recursive CTE
-- 1'den 10'a kadar herbir rakam bir satırda olacak şekide bir tablo oluşturun.
;
with tbl as (
		select	1 rakam
		
		union all

		select	rakam + 1
		from	tbl
		where	rakam < 10
)

select	*
from	tbl
;















