CREATE DATABASE sql_assignment;
USE sql_assignment;
/********************************************************************
 SQL BASICS
********************************************************************/

/* Q1: Create a table called employees with the following structure?
 emp_id (integer, should not be NULL and should be a primary key)Q
 emp_name (text, should not be NULL)Q
 age (integer, should have a check constraint to ensure the age is at least 18)Q
 email (text, should be unique for each employee)Q
 salary (decimal, with a default value of 30,000).
Write the SQL query to create the above table with all constraints*/

-- Answer:
CREATE TABLE employees (
    emp_id     INT PRIMARY KEY NOT NULL,
    emp_name   TEXT NOT NULL,
    age        INT CHECK (age >= 18),
    email      TEXT UNIQUE,
    salary     DECIMAL(10,2) DEFAULT 30000
);


/* Q2: 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
 examples of common types of constraints.*/

-- Answer:
/* Constraints are rules enforced on data columns in a table to limit the type of data that can go into a table. This ensures the accuracy and reliability of the data in the database, a concept known as data integrity.
 Here are some common types of constraints:

 NOT NULL: Ensures a column cannot have a NULL value. This is useful for columns that must always have a value, like a customer's name.
 UNIQUE: Ensures all values in a column are different. While a PRIMARY KEY is always UNIQUE, you can have multiple UNIQUE constraints in a table. For example, a social security number or email address should be unique for each record.
 PRIMARY KEY: A column or a set of columns that uniquely identifies each row in a table. A table can only have one PRIMARY KEY. It's a combination of UNIQUE and NOT NULL.
 FOREIGN KEY: A key that links two tables together. It references the PRIMARY KEY of another table, ensuring referential integrity by preventing actions that would destroy links between tables. For example, you can't delete a customer if there are still orders associated with their ID.
 CHECK: Ensures all values in a column satisfy a specific condition. For instance, you can use a CHECK constraint to ensure that an age column only contains values greater than or equal to 18.*/

/* Q3: Why would you apply the NOT NULL constraint to a column?
 Can a primary key contain NULL values? Justify your answer.*/
 
-- Answer:

/* You apply the NOT NULL constraint to a column when you need to guarantee that every row in the table will have a value for that column.
 This prevents missing or unknown data in fields that are essential for the integrity of the data, such as a user's name or an item's description.
 A primary key cannot contain NULL values. This is a fundamental rule of relational database design.
 A primary key is designed to uniquely identify each record in a table, and a NULL value represents missing or unknown data.
 If a primary key could be NULL, it would be impossible to guarantee a unique identity for that record, which defeats the entire purpose of a primary key.*/

-- Q4: 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. 
-- Provide an example for both adding and removing a constraint.

-- Answer:
/* You can add or remove constraints from an existing table using the ALTER TABLE statement.
Adding a Constraint: You use ALTER TABLE with the ADD CONSTRAINT clause.
Example: To add a UNIQUE constraint to the email column in a table named users:*/

ALTER TABLE users
ADD CONSTRAINT UC_users UNIQUE (email);

/*Removing a Constraint: You use ALTER TABLE with the DROP CONSTRAINT clause.
Example: To remove the UNIQUE constraint named UC_users from the users table:*/

ALTER TABLE users
DROP CONSTRAINT UC_users;

/* Q5: Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.*/

-- Answer:

/* Attempting to perform an operation (like INSERT, UPDATE, or DELETE) that violates a constraint will cause the database to reject the action and return an error.
 The operation will not be completed, and the data in the table will remain unchanged.
 This mechanism is crucial for maintaining data integrity and preventing invalid or corrupt data from being stored.
Example of an error message:
If you try to insert a duplicate value into a column with a UNIQUE constraint, the database will raise an error similar to this:

ERROR 1062 (23000): Duplicate entry 'test@example.com' for key 'users.email'

This specific message indicates a Duplicate entry error, which happens when you attempt to insert a value that already exists in a column with a UNIQUE or PRIMARY KEY constraint.*/

/*Question 6. You created a products table without constraints as follows:

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2));
    
Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00*/

-- Answer:
ALTER TABLE products
ADD PRIMARY KEY (product_id);
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

/* Q7: You have two tables:
Write a query to fetch the student_name and class_name for each student using an INNER JOIN.*/

SELECT s.student_name, c.class_name
FROM students s
INNER JOIN classes c ON s.class_id = c.class_id;

/* Q8:  Consider the following three tables:
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order 
Hint: (use INNER JOIN and LEFT JOIN)*/
-- Answer:

SELECT o.order_id,
       c.customer_name,
       p.product_name
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
LEFT JOIN orders o        ON od.order_id = o.order_id
LEFT JOIN customers c     ON o.customer_id = c.customer_id;

/* Q9: Given the following tables:
Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.*/

-- Answer:

SELECT p.product_name,
       SUM(od.quantity * od.price) AS total_sales
FROM products p
INNER JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_name;

/* Q10:  You are given three tables:
Write a query to display the order_id, customer_name, and the quantity of products ordered by each
customer using an INNER JOIN between all three tables.
Note - The above-mentioned questions don't require any dataset.*/

-- Answer:

SELECT o.order_id,
       c.customer_name,
       od.quantity
FROM orders o
INNER JOIN customers c     ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id   = od.order_id;


/********************************************************************
 SQL COMMANDS (Maven Movies DB)
********************************************************************/

-- Q1: Identify the primary keys and foreign keys in Maven Movies DB and discuss differences.

-- Answer:
/* Primary keys: e.g. customer.customer_id, film.film_id.
 Foreign keys: e.g. rental.customer_id -> customer.customer_id.
 PK uniquely identifies a row; FK links to another table’s PK.*/

-- Q2: List all details of actors.

-- Answer:
SELECT * FROM actor;

-- Q3: List all customer information.

-- Answer:
SELECT * FROM customer;

-- Q4: List different countries.

-- Answer:
SELECT DISTINCT country FROM country;

-- Q5: Display all active customers.

-- Answer:
SELECT * FROM customer WHERE active = 1;

-- Q6: List rental IDs for customer with ID 1.

-- Answer:
SELECT rental_id FROM rental WHERE customer_id = 1;

-- Q7: Display films whose rental duration is greater than 5.

-- Answer:
SELECT * FROM film WHERE rental_duration > 5;

-- Q8: Total number of films with replacement cost >15 and <20.

-- Answer:
SELECT COUNT(*) FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

-- Q9: Count of unique first names of actors.

-- Answer:
SELECT COUNT(DISTINCT first_name) FROM actor;

-- Q10: First 10 records from customer table.

-- Answer:
SELECT * FROM customer LIMIT 10;

-- Q11: First 3 records whose first name starts with 'b'.

-- Answer:
SELECT * FROM customer
WHERE first_name LIKE 'b%' LIMIT 3;

-- Q12: Names of first 5 movies rated 'G'.

-- Answer:
SELECT title FROM film
WHERE rating = 'G' LIMIT 5;

-- Q13: Customers whose first name starts with 'a'.

-- Answer:
SELECT * FROM customer WHERE first_name LIKE 'a%';

-- Q14: Customers whose first name ends with 'a'.

-- Answer:
SELECT * FROM customer WHERE first_name LIKE '%a';

-- Q15: First 4 cities which start and end with 'a'.

-- Answer:
SELECT city FROM city
WHERE city LIKE 'a%a' LIMIT 4;

-- Q16: Customers whose first name has 'NI' in any position.

-- Answer:
SELECT * FROM customer WHERE first_name LIKE '%NI%';

-- Q17: Customers whose first name has 'r' in second position.

-- Answer:
SELECT * FROM customer WHERE first_name LIKE '_r%';

-- Q18: Customers whose first name starts with 'a' and is at least 5 characters.

-- Answer:
SELECT * FROM customer WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

-- Q19: Customers whose first name starts with 'a' and ends with 'o'.

-- Answer:
SELECT * FROM customer WHERE first_name LIKE 'a%o';

-- Q20: Films with PG or PG-13 rating using IN.

-- Answer:
SELECT * FROM film WHERE rating IN ('PG','PG-13');

-- Q21: Films with length between 50 and 100.

-- Answer:
SELECT * FROM film WHERE length BETWEEN 50 AND 100;

-- Q22: Top 50 actors using LIMIT.

-- Answer:
SELECT * FROM actor LIMIT 50;

-- Q23: Distinct film IDs from inventory.

-- Answer:
SELECT DISTINCT film_id FROM inventory;


/********************************************************************
 FUNCTIONS
********************************************************************/

/* Q1: Retrieve the total number of rentals made in the Sakila database.
 Hint: Use the COUNT() function.*/
 
-- Answer:
SELECT COUNT(*) AS total_rentals FROM rental;

/* Q2: Find the average rental duration (in days) of movies rented from the Sakila database.
 Hint: Utilize the AVG() function.*/
 
-- Answer:
SELECT AVG(rental_duration) AS avg_duration FROM film;

/* String Functions:
 Q3: Display the first name and last name of customers in uppercase.
 Hint: Use the UPPER () function.*/
 
-- Answer:
SELECT UPPER(first_name), UPPER(last_name) FROM customer;

/* Q4: Extract the month from the rental date and display it alongside the rental ID.
 Hint: Employ the MONTH() function.*/
 
-- Answer:
SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;

/* GROUP BY:
 Q5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
 Hint: Use COUNT () in conjunction with GROUP BY.*/
 
-- Answer:
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

/* Q6: Find the total revenue generated by each store.
 Hint: Combine SUM() and GROUP BY.*/
 
-- Answer:
SELECT store_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

/* Q7: Determine the total number of rentals for each category of movies.
 Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.*/
 
-- Answer:
SELECT c.name AS category, COUNT(*) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i      ON fc.film_id    = i.film_id
JOIN rental r         ON i.inventory_id = r.inventory_id
GROUP BY c.name;

/* Q8: Find the average rental rate of movies in each language.
 Hint: JOIN film and language tables, then use AVG () and GROUP BY.*/
 
-- Answer:
SELECT l.name AS language, AVG(f.rental_rate) AS avg_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;


/********************************************************************
 JOINS
********************************************************************/

/* Q9: Display the title of the movie, customer s first name, and last name who rented it.
Hint: Use JOIN between the film, inventory, rental, and customer tables.*/

-- Answer:
SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r    ON i.inventory_id = r.inventory_id
JOIN customer c  ON r.customer_id = c.customer_id;

/* Q10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
Hint: Use JOIN between the film actor, film, and actor tables.*/

-- Answer:
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f        ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

/* Q11: Retrieve the customer names along with the total amount they've spent on rentals.
Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.*/

-- Answer:
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name;

/* Q12: List the titles of movies rented by each customer in a particular city (e.g., 'London').
 Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.*/

-- Answer:
SELECT cu.first_name, cu.last_name, f.title
FROM customer cu
JOIN address a  ON cu.address_id = a.address_id
JOIN city ci    ON a.city_id = ci.city_id
JOIN rental r   ON cu.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f     ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY cu.first_name, cu.last_name, f.title;

/********************************************************************
 Advanced Joins and GROUP BY:
********************************************************************/

/* Q13: Display the top 5 rented movies along with the number of times they've been rented.
Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.*/

-- Answer:
SELECT f.title, COUNT(*) AS times_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r    ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY times_rented DESC
LIMIT 5;

/* Q14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
 Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.*/

-- Answer:
SELECT customer_id
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;


/********************************************************************
 WINDOW FUNCTIONS  (sample queries)
********************************************************************/
-- 1. Rank the customers based on the total amount they've spent on rentals.

-- Answer:
SELECT customer_id, SUM(amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(amount) DESC) AS rank_by_spent
FROM payment
GROUP BY customer_id;

-- 2. Calculate the cumulative revenue generated by each film over time.

-- Answer:
SELECT
    p.payment_date,
    f.title,
    SUM(p.amount) OVER (ORDER BY p.payment_date) AS cumulative_revenue
FROM
    payment p
JOIN
    rental r ON p.rental_id = r.rental_id
JOIN
    inventory i ON r.inventory_id = i.inventory_id
JOIN
    film f ON i.film_id = f.film_id
ORDER BY
    p.payment_date;

-- 3. Determine the average rental duration for each film, considering films with similar lengths.

-- Answer:
SELECT
    film_id,
    title,
    rental_duration,
    AVG(rental_duration) OVER (PARTITION BY rental_duration) AS avg_rental_duration_for_length
FROM
    film;
    
-- 4. Identify the top 3 films in each category based on their rental counts.

-- Answer:
WITH RankedFilms AS (
    SELECT
        c.name AS category,
        f.title AS film_title,
        COUNT(r.rental_id) AS rental_count,
        ROW_NUMBER() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
    FROM
        film f
    JOIN
        inventory i ON f.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    JOIN
        film_category fc ON f.film_id = fc.film_id
    JOIN
        category c ON fc.category_id = c.category_id
    GROUP BY
        c.name, f.title
)
SELECT
    category,
    film_title,
    rental_count
FROM
    RankedFilms
WHERE
    rank_in_category <= 3;
    
/* 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals
 across all customers.*/

-- Answer:
WITH CustomerRentalCounts AS (
    SELECT
        customer_id,
        COUNT(rental_id) AS total_rentals
    FROM
        rental
    GROUP BY
        customer_id
),
AverageRentals AS (
    SELECT
        AVG(total_rentals) AS average_rentals
    FROM
        CustomerRentalCounts
)
SELECT
    crc.customer_id,
    crc.total_rentals,
    ar.average_rentals,
    crc.total_rentals - ar.average_rentals AS difference_from_average
FROM
    CustomerRentalCounts crc,
    AverageRentals ar;
    
-- 6. Find the monthly revenue trend for the entire rental store over time.

-- Answer:
SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS rental_month,
    SUM(amount) AS monthly_revenue,
    SUM(SUM(amount)) OVER (ORDER BY DATE_FORMAT(payment_date, '%Y-%m')) AS running_total
FROM
    payment
GROUP BY
    rental_month
ORDER BY
    rental_month;
    
-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

-- Answer:
WITH CustomerSpending AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent,
        NTILE(5) OVER (ORDER BY SUM(amount) DESC) AS spending_quintile
    FROM
        payment
    GROUP BY
        customer_id
)
SELECT
    customer_id,
    total_spent
FROM
    CustomerSpending
WHERE
    spending_quintile = 1;
    
-- 8. Calculate the running total of rentals per category, ordered by rental count.

-- Answer:
WITH CategoryRentalCounts AS (
    SELECT
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM
        category c
    JOIN
        film_category fc ON c.category_id = fc.category_id
    JOIN
        film f ON fc.film_id = f.film_id
    JOIN
        inventory i ON f.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name
)
SELECT
    category_name,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM
    CategoryRentalCounts;
    
-- 9. Find the films that have been rented less than the average rental count for their respective categories.

-- Answer:
WITH FilmRentalCounts AS (
    SELECT
        f.film_id,
        f.title,
        fc.category_id,
        COUNT(r.rental_id) AS film_rental_count
    FROM
        film f
    JOIN
        inventory i ON f.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    JOIN
        film_category fc ON f.film_id = fc.film_id
    GROUP BY
        f.film_id, f.title, fc.category_id
),
CategoryAverages AS (
    SELECT
        category_id,
        AVG(film_rental_count) AS avg_category_rentals
    FROM
        FilmRentalCounts
    GROUP BY
        category_id
)
SELECT
    frc.title
FROM
    FilmRentalCounts frc
JOIN
    CategoryAverages ca ON frc.category_id = ca.category_id
WHERE
    frc.film_rental_count < ca.avg_category_rentals;
    
-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

-- Answer:
WITH MonthlyRevenue AS (
    SELECT
        DATE_FORMAT(payment_date, '%Y-%m') AS rental_month,
        SUM(amount) AS total_revenue
    FROM
        payment
    GROUP BY
        rental_month
)
SELECT
    rental_month,
    total_revenue
FROM
    MonthlyRevenue
ORDER BY
    total_revenue DESC
LIMIT 5;

/********************************************************************
 NORMALISATION & CTE
********************************************************************/

/* Q 1. First Normal Form (1NF)
a. Identify a table in the Sakila database that violates 1NF 
and explain how you would normalize it to achieve 1NF.*/

-- Answer;

/* In the Sakila sample database, the ADDRESS table can be viewed as violating 1NF
 if we choose to store multiple phone numbers for a single address inside one column
 (for example: a column "phones" that stores values like '555-1111,555-2222').
 1NF requires that each attribute contain only atomic (single) values and that there
 are no repeating groups.

 Normalization to 1NF:*/
-- Step 1: Create a new table to hold each phone number as a separate row.

CREATE TABLE address_phone (
    address_id INT NOT NULL,
    phone      VARCHAR(20) NOT NULL,
    PRIMARY KEY (address_id, phone),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- Step 2: Remove the non-atomic "phones" column from ADDRESS (if it existed).

ALTER TABLE address
DROP COLUMN phones;

/* Step 3: Insert each phone number as a separate row into address_phone.
 Now each field in every table holds a single, indivisible value,
 satisfying the requirements of First Normal Form.*/



/* Q 2. Second Normal Form (2NF):
 a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
If it violates 2NF, explain the steps to normalize it.*/

-- Answer:
/* 2NF Definition:
A table is in 2NF if:
   (1) it is already in 1NF, AND
   (2) every non-key attribute is fully functionally dependent
   on the whole primary key (no partial dependency on part of a composite key).

- Example from Sakila:
 Consider a hypothetical design of the FILM_ACTOR table where
   PRIMARY KEY (film_id, actor_id) and suppose it also contains columns like film_title or actor_first_name.

 Problem:
  film_title depends only on film_id (part of the composite key),
  actor_first_name depends only on actor_id.
 These are partial dependencies → the table violates 2NF.

 Steps to normalize to 2NF:
 1. Remove the non-key columns that depend on only one part of the composite key.
 2. Place them in separate tables where the primary key matches their natural dependency.*/

-- Implementation:

-- Create separate tables (if not already existing):
CREATE TABLE film (
    film_id INT PRIMARY KEY,
    title   VARCHAR(255) NOT NULL
    -- other film-specific columns…
);

CREATE TABLE actor (
    actor_id INT PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name  VARCHAR(45) NOT NULL
    -- other actor-specific columns…
);

-- Keep the junction table only for the many-to-many relationship:
CREATE TABLE film_actor (
    film_id  INT NOT NULL,
    actor_id INT NOT NULL,
    PRIMARY KEY (film_id, actor_id),
    FOREIGN KEY (film_id)  REFERENCES film(film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
);

/* Now every non-key attribute depends on the whole primary key in its own table,
 and the relationship table contains no partial dependencies, satisfying 2NF.*/


/* Question 3. Third Normal Form (3NF):
 a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
  present and outline the steps to normalize the table to 3NF.*/

-- Answer:
/* 3NF Definition:
 A table is in 3NF if:
   (1) it is already in 2NF, AND
   (2) every non-key attribute depends only on the primary key,
       not on another non-key attribute (no transitive dependency).

 Example from Sakila:
 Imagine we design the CUSTOMER table like this (hypothetical extra column):
   customer_id  (PK)
   first_name
   last_name
   address_id
   city_name        <-- violates 3NF
   country_name     <-- violates 3NF

 Transitive dependency:
   city_name and country_name depend on city_id/country_id,
   which in turn depend on address_id, not directly on customer_id.
   So: customer_id → address_id → city_name / country_name
   This is a transitive dependency and breaks 3NF.

Steps to normalize to 3NF:
 1. Remove the non-key columns that depend on another non-key column.
 2. Place those columns in separate tables keyed by their own determinants.

 Implementation (already present in the official Sakila schema):
   • CITY table holds city_name and a foreign key to COUNTRY.
   • COUNTRY table holds country_name.
   • ADDRESS table holds city_id.
   • CUSTOMER table holds address_id.*/

-- Correct 3NF structure:

CREATE TABLE country (
    country_id   INT PRIMARY KEY,
    country      VARCHAR(50) NOT NULL
);

CREATE TABLE city (
    city_id      INT PRIMARY KEY,
    city         VARCHAR(50) NOT NULL,
    country_id   INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE address (
    address_id   INT PRIMARY KEY,
    address      VARCHAR(100) NOT NULL,
    city_id      INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE customer (
    customer_id  INT PRIMARY KEY,
    first_name   VARCHAR(45) NOT NULL,
    last_name    VARCHAR(45) NOT NULL,
    address_id   INT NOT NULL,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

/* After separating city and country into their own tables,
 all non-key attributes in CUSTOMER depend only on customer_id,
 and transitive dependencies are removed — the design is now in 3NF.*/


/* Q 4. Normalization Process:
 a. Take a specific table in Sakila and guide through the process of normalizing
 it from the initial unnormalized form up to at least 2NF.*/
 
 -- Answer

/* Example Table:  Suppose we start with an UNNORMALIZED table called CUSTOMER_ORDERS
 (this is a hypothetical denormalized design for illustration):

 UNNORMALIZED FORM (UNF)
 -------------------------------------------------------
 customer_id | customer_name | phones               | film_titles
 ------------|-------------- |--------------------- |------------------------------
 1           | John Smith    | 555-1111,555-2222    | "Matrix,Avatar"
 2           | Mary Jones    | 555-3333             | "Titanic"
 -------------------------------------------------------
 Problems:
  • Multiple phone numbers in one column (repeating group)
  • Multiple film titles in one column (repeating group)

 Step 1: First Normal Form (1NF)
 Requirement: Eliminate repeating groups; each field must be atomic.

 Solution:
  • Create separate rows for each phone number.
  • Create a separate table for the many-to-many relationship of customers to films.*/

CREATE TABLE customer (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE customer_phone (
    customer_id INT NOT NULL,
    phone       VARCHAR(20) NOT NULL,
    PRIMARY KEY (customer_id, phone),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE customer_film (
    customer_id INT NOT NULL,
    film_id     INT NOT NULL,
    PRIMARY KEY (customer_id, film_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (film_id)     REFERENCES film(film_id)
);

/* Now each column contains atomic values and the design satisfies 1NF.

Step 2: Second Normal Form (2NF)
 Requirement: Already in 1NF and every non-key attribute
 must be fully dependent on the entire primary key.

Potential issue:
   In the customer_film table, suppose we also added a column customer_name.
   customer_name depends only on customer_id (part of the composite key),
   not on the whole (customer_id, film_id).
   This is a partial dependency and violates 2NF.

 Solution:
   Remove customer_name from customer_film and keep it only in the customer table,
   so that all non-key attributes depend on the whole key.

 After removing the partial dependency, the schema is in 2NF.

 Summary:
   UNF  -> 1NF : removed repeating groups (phones, film_titles).
   1NF  -> 2NF : removed partial dependency by placing customer_name only in customer table.*/

/* Q 5: Write a query using a CTE to retrieve the distinct list of actor names
    and the number of films they have acted in from the actor and film_actor tables.*/

-- Answer:
WITH film_count AS (
    SELECT 
        fa.actor_id,
        COUNT(fa.film_id) AS total_films
    FROM film_actor fa
    GROUP BY fa.actor_id
)
SELECT 
    a.first_name,
    a.last_name,
    fc.total_films
FROM actor a
JOIN film_count fc ON a.actor_id = fc.actor_id
ORDER BY a.first_name, a.last_name;

/* Q 6: CTE with Joins:
 Create a CTE that combines information from the film and language tables
to display the film title, language name, and rental rate.*/

-- Answer
WITH film_language AS (
    SELECT
        f.title        AS film_title,
        l.name         AS language_name,
        f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT *
FROM film_language
ORDER BY film_title;

/* Q 7: CTE for Aggregation:
 Write a query using a CTE to find the total revenue generated by each customer
 (sum of payments) from the customer and payment tables.*/

-- Answer:
WITH customer_revenue AS (
    SELECT
        p.customer_id,
        SUM(p.amount) AS total_revenue
    FROM payment p
    GROUP BY p.customer_id
)
SELECT
    c.first_name,
    c.last_name,
    cr.total_revenue
FROM customer c
JOIN customer_revenue cr ON c.customer_id = cr.customer_id
ORDER BY cr.total_revenue DESC;

/* Q 8:CTE with Window Functions:
 Utilize a CTE with a window function to rank films based on their rental duration from the film table.*/

-- Answer:
WITH film_rank AS (
    SELECT
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM film
)
SELECT *
FROM film_rank
ORDER BY duration_rank, title;

/* Q 9. CTE and Filtering: 
 a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
 customer table to retrieve additional customer details.*/

-- Answer
WITH HighValueCustomers AS (
    SELECT
        customer_id
    FROM
        rental
    GROUP BY
        customer_id
    HAVING
        COUNT(rental_id) > 2
)
SELECT
    c.first_name,
    c.last_name,
    c.email
FROM
    HighValueCustomers hvc
JOIN
    customer c ON hvc.customer_id = c.customer_id;

/* Q 10. CTE for Date Calculations:
 Question: Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table.*/

-- Answer:
WITH MonthlyRentals AS (
    SELECT
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS number_of_rentals
    FROM
        rental
    GROUP BY
        rental_month
)
SELECT
    rental_month,
    number_of_rentals
FROM
    MonthlyRentals
ORDER BY
    rental_month;
    
/* Q 11. CTE and Self-Join:
 Question:
 a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
 together, using the film_act.*/

-- Answer:
WITH ActorFilmPairs AS (
    SELECT
        fa1.film_id,
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id
    FROM
        film_actor fa1
    JOIN
        film_actor fa2 ON fa1.film_id = fa2.film_id
        AND fa1.actor_id < fa2.actor_id
)
SELECT
    f.title,
    a1.first_name AS actor1_first_name,
    a1.last_name AS actor1_last_name,
    a2.first_name AS actor2_first_name,
    a2.last_name AS actor2_last_name
FROM
    ActorFilmPairs afp
JOIN
    film f ON afp.film_id = f.film_id
JOIN
    actor a1 ON afp.actor1_id = a1.actor_id
JOIN
    actor a2 ON afp.actor2_id = a2.actor_id
ORDER BY
    f.title;
    
/* Q 12. CTE for Recursive Search:
  a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 
  considering the reports_to column.*/

-- Answer
WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: Select the initial manager
    SELECT
        staff_id,
        first_name,
        last_name,
        reports_to,
        0 AS level
    FROM
        staff
    WHERE
        staff_id = MANAGER_STAFF_ID -- Replace with the manager's staff_id

    UNION ALL

    -- Recursive member: Find employees who report to the staff from the previous step
    SELECT
        e.staff_id,
        e.first_name,
        e.last_name,
        e.reports_to,
        eh.level + 1
    FROM
        staff e
    JOIN
        EmployeeHierarchy eh ON e.reports_to = eh.staff_id
)
SELECT
    staff_id,
    first_name,
    last_name,
    reports_to,
    level
FROM
    EmployeeHierarchy;
