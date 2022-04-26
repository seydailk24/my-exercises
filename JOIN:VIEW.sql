----- march 5, 2022 JOIN---
---inner join---
----ortak recordlari kesisim kumesi gibi iki tablodaki kayitlari veriyor---
---left join = a da olan tum elemanlari getir
---ayni seyi b icine gecerli---
---right joinde ayni sey gecerli---

------------------------------------------------------------------------------

-- List products with category names
-- Select product ID, product name, category ID and category names



SELECT A.product_id, A.product_name, B.category_id, B.category_name
FROM product.product A
INNER JOIN product.category B ON A.category_id = B.category_id


--List employees of stores with their store information
--Select employee name, surname, store names

---SELECT * from sale.staff
---select * from sale.store
SELECT A.first_name, A.last_name, B.store_name
FROM sale.staff A
INNER JOIN sale.store B ON A.store_id=B.store_id


--Write a query that returns count of orders of the states by months.
---burada state sutunumun customer tablosunda oldugunu bakmam lazim oncelikle
---order tablosuyla customer tablosunun birlesiminin oldugunu goruyorum customerid sutunuyla
---aylik ve yillik durmumlarini orderdateten yapicaz
---

SELECT A.[state], YEAR(B.order_date) YEAR1, MONTH(B.order_date) MONTH1, COUNT (DISTINCT B.order_id) NUM_COUNT
FROM sale.customer A
INNER JOIN sale.orders B
ON A.customer_id = B.customer_id
GROUP BY A.[state], YEAR(B.order_date), MONTH(B.order_date)


---ikinci yontem---
SELECT A.[state], YEAR(B.order_date) YEAR1, MONTH(B.order_date) MONTH1, COUNT (DISTINCT B.order_id) NUM_COUNT
FROM sale.customer A, sale.orders B
WHERE A.customer_id = B.customer_id
GROUP BY A.[state], YEAR(B.order_date), MONTH(B.order_date)



-----LEFT JOIN


-- Write a query that returns products that have never been ordered
--Select product ID, product name, orderID
--(Use Left Join)


SELECT A product ID, A product name,B orderID
FROM product.product
LEFT JOIN sale.order_item B ON A.product_id = B.product_id
WHERE order_id IS NULL


--Report the stock status of the products that product id greater than 310 in the stores.
--Expected columns: Product_id, Product_name, Store_id, quantity


SELECT A.product_id,A.product_name,B.store_id,B.quantity
From product.product A
LEFT JOIN product.stock B
ON A.product_id=B.product_id
WHERE A.product_id > 310


----RIGHT JOIN
--yukarida sorunu aynisi--- right join ile coz--
--Report (AGAIN WITH RIGHT JOIN) the stock status of the products that product id greater than 310 in the stores.

SELECT B.product_id, B.product_name, A.*
From product.stock A
RIGHT JOIN product.product B
ON A.product_id = B.product_id
WHERE B.product_id > 310

-------Report the orders information made by all staffs.
--Expected columns: Staff_id, first_name, last_name, all the information about orders


SELECT B.staff_id, B.first_name, B.last_name, A.*
FROM sale.orders A
left JOIN sale.staff B ON A.staff_id = B.staff_id


---- FULL OUTER JOIN
---uc tane table birlestirmesi yaptik---
--Write a query that returns stock and order information together for all products . (TOP 100)
--Expected columns: Product_id, store_id, quantity, order_id, list_price

SELECT  TOP 100 A.product_id, B.store_id, B.quantity, C.order_id, C.list_price
FROM product.product A
FULL OUTER JOIN product.stock B ON A.product_id = B.product_id
FULL OUTER JOIN sale.order_item C ON A.product_id=C.product_id
ORDER BY B.store_id


---cross join---
--her bir row u diger rowdaki herbir elemanla eslestirmek istiyorsak kullaniyoruz
---In the stocks table, there are not all products held on the product table and you
--want to insert these products into the stock table.
---You have to insert all these products for every three stores with “0” quantity.
---Write a query to prepare this data.---
--
select product_id, quantity
FROM product.stock


SELECT b.store_id, a.product_id ,0 QUANTITY
FROM product.product a
CROSS JOIN sale.store b
WHERE a.product_id NOT IN (
    SELECT product_id
    FROM product.stock
   )
ORDER BY a.product_id , b.store_id










---self join
--kendi icinde tablo eslesme yapiyo
--bir tablonun iki kopyasi gibi

--Write a query that returns the staffs with their managers.
--Expected columns: staff first name, staff last name, manager name

SELECT *
FROM sale.staff

SELECT A.first_name, B.first_name MANAGER_NAME
From sale.staff A
JOIN sale.staff B
ON A.manager_id = B.staff_id



---- VIEW OLUSTURMA
--ASIL TABLOYU ETKILEMIYOR SANAL OLARAK OLUSTUURUYORUZ
-- SANAL BIR TABLO GIBI DAVRANIYOOR

CREATE VIEW CUSTMOER_PRODUCT
AS

SELECT	distinct D.customer_id, D.first_name, D.last_name
FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE	A.product_id=B.product_id
AND		B.order_id = C.order_id
AND		C.customer_id = D.customer_id
AND		A.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'

SELECT * FROM [dbo].[CUSTMOER_PRODUCT]
