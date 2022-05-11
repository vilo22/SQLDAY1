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
select first_name, lastn_name
from actor 
where first_name like 'k%' and actor_id > 100;

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

