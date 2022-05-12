--Two dashes is a single line comment 
-- Hello world!

-- The 'hello, world!' program of SQL: select all rows and all columns from a table
--how do I select all the column and all the rows from a table?
-- Today we'll be discussing DQL - data query langugae
-- sepecifically, simple select statements 

--(only dql commands shoould be considered queries but meh)
--Computer doesn't really care about indentention 

select * --selects the quantity we want to grab
from actor; -- selects the file we want to grab 

-- A select statement at minimun needs two clauses:
-- a select clause to specifu which columns are being selected 
-- and a from clause to specify which table we are selecting from 

-- select * from <table>; commonly used as an exploratory query 
-- to show you (developer) what information exists within a table

select * from customer;

--what if I didnt't want every column in a table 
--just specify the columns you'd like to query/select in the select clause 
select first_name, last_name
from actor;

--WHERE clause 
-- Filter our results by a condition- this will alter the rows that get returned
select first_name, last_name 
from actor
where first_name = 'Nick';

--sql is not case sensitive
-- The order of clauses in a statement matters
-- As we discuss more clausese I'll lay out the specific order but it generally follows the rule
-- Column selection -> Table selection -> Modifiers -> Grouping -> Ordering 

-- When writing a where clause with a string - you can use the LIKE operator 
-- this enables the use of wildcards aka regex-like patterns
select first_name, last_name 
from actor 
where last_name like 'Wahlberg';

--Wildcards:
-- % and _
-- % represents any number of characters (could be 0, could be 1344444423)
--_ represents a single instance of a character 
select first_name, last_name 
from actor 
where last_name like 'W%';

select first_name, last_name 
from actor 
where first_name like 'A___';

select first_name, last_name 
from actor 
where first_name like '%nn%';

--We've senn a wher eclause with strings (aka varchars)
--how do wehre clauses work for numerical data?
-- comparison operators: 
-- Greater than > 
-- Less than < 
-- = like shown above
-- Greater or equal >=
-- Less or equal <=
-- Not equal <>

-- eplore my data with a SELECT ALL query 
select * payment;

-- query for all payments greater than $10
select customer_id, amount
from payment 
where amount > 10;

--combining operators in our where clause 
-- just like python we can combine multiple conditionals with and/operator 
select customer_id, amount
from payment
where amount < 0.5 or amount > 300;
--an alternative
--between operator 
select customer_id, amount
from payment
where amount between 10 and 20;


--can combine conditionals in different comlumns into one where clause
-- don't need to select a column in order to use that column in the where clause 
select first_name, last_name
from actor
where first_name like 'K%' and actor_id > 100;

--ORDER BY CLAUSE 
--let's us sort our result 

select customer_id, amount
from payment 
where amount > 0 
order by amount DESC; --desc is to organized on ascending data 

--order of the clauses we've discussed so far:
-- select <columns> 
-- from <table>
-- where <conditional>
-- order by <column>;

-- The use of SQL aggregations -> aka how we take many rows of data and conense them 
-- into a single easy to digest piece of information
select * 
from payment
where amount = 0.99; 
-- How many .99 payments have  I received 
-- We can find the answer by looking at total rows in a normal query 
--or we can run an aggregate as part of our query 
-- and get the actual number as a result 

-- instead of selecting a column I can select an aggregate function 
-- option for aggregates: 	COUNT(), SUM(), AVG(), MIN(), MAX()
select count(amount)
from payment p where amount = 0.99;
-- 2,683 payments of 0.99

--how much money did we make from 2683 payments of 0.99
select sum(amount)
from payment 
where amount = 0.99;
-- $2,656.17

--what was the average payment amount?
select avg(amount)
from payment;
--$3.01

--What if I want to select other columns in addition to my aggregate result 
--I can't without anothe clause 
-- use the GROUP BY clause to specify how non-aggregares should behave when used alongside and aggregate 
-- I want to know the number of payments of each amount 
select count(amount), amount
from payment
group by amount

-- which payment amount have we made the most money off of? 
select amount, sum(amount)
from payment 
group by amount 
order by sum(amount) desc;
--we've made the most money off of 4.99 sales

--which customer made the most money?
select customer_id, sum(amount)
from payment 
group by customer_id 
order by sum(amount) desc;
-- customer_id 6 spent the most money

--how was customer 6's spending distributed?
--we can do a multiple group by
--aka we can primarily group by customer_id and secondarily group by amount 
select customer_id, amount, count(amount), sum(amount)
from payment 
where customer_id = 6
group by customer_id, amount;

-- which of my customers have spent more than $1000?
-- To answe this question, we essenstialy need to appply a conditional to our aggregate 
-- HAVING clause
-- The HAVING clause performs the conditional role for aggrergates 
-- just like te where clause is the conditional for regular columns
select customer_id, sum(amount)
from payment 
where customer_id < 10
group by customer_id
having sum(amount) > 1000
order by customer_id;

--Two customers spent more than $1000
-- customer-id 5 and customer_id 6 

--Who are customer 5 and customer 6?
select * 
from customer
where customer_id = 5 or customer_id = 6;

-- what if I wanted to write a query to directly in one query acces the name and emails of my best customers along with the amount they spent? 
-- In other words, how do I get results from two tables at once?
-- I can combine queries in multiple tables with a join 
-- if we have two tables with a shared column 
-- such as customer_id in both the customer and payment table 
-- we can combine data from both tables by joining it on that shared column 
-- in order to perform a join you need a JOIN clause and an ON clause

-- SELECT <columns>
--FROM <primary table>
-- JOIN <secondary table>
-- ON <primary_table.column> = <secondary_table.column>
select payment.customer_id, first_name, last_name, email, sum(amount)
from payment 
join customer 
on payment.customer_id = customer.customer_id
group by payment.customer_id, first_name, last_name, email 
having sum(amount) > 1000;

-- Two spearate tables:
select * from customer;
select * from payment;
--They share the customer_ud column
--if we need to answer about 
