---retrieve the distinct rating types our films could have in our database

select distinct rating from film

---A customer forgot their wallet at our store! we need to track down their email to inform them.
---what is the email for the customer woth the name Nancy Thomas?

select email from customer
where first_name = "Nancy" 
and last_name = "Thomas";

---A customer want to know what the movie "Outlaw Hanky" is about.
---Could you give them the description for the movie "Outlaw Hanky"?

 select description
 from film
 where title = "Outlaw Hanky";
 
 ---A customer is late on their movie return, and we've mailed them a letter to their address at "259 ipoh Drive". we should let them know .
 ---can you get the phone number for the customer who lives at "259 Ipoh Drive"?
 
 select phone from address
 where address = "259 Ipoh Drive"


---we want to reward our first 10 paying customers, What are the customer ids of the first 10 customers who created a payment?

select  customer_id
from payment
order by payment_date asc
limit 10


-----A customer wants to quickly rent a video to watch over their short lunch break.
---what are the titles of the 5 shortest (in lengt of runtime) movies?


select title,length 
from film
ORDER BY length asc
limit 5;

---if the previous customer can watch any movie that is 50 minutes or less in run time, how many options does she have?


select count(title)
from film
where length  <= 50


---how many payment trANsactions were greater than $5.00?


select count(amount)
from payment
where amount > 5.00


----how many actors have a first name that starts with the letter P ?

select count(actor_id)
from actor
where first_name like 'P%';

---how many unique districts are our customers from ?

select count(distinct district)
from address;

---retrieve the list of names for those distinct districts from the previous question?

select count(distinct district)
from address;

---how many films have a rating of R and a replacement cost between $5 and $15?

select count(title)
from film
where rating = 'R'
and replacement_cost between 5 and 15;