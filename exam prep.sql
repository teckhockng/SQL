
/*******************************************************************************************/
/*                               The lab for lesson 6                                      */
/*******************************************************************************************/

/* This lab requires you to use the customers.sql file.  Be sure to run in all 25,040 lines of sql statements in order.*/


/*Question 1 - How many customers are in the database?*/
SELECT count(*)
FROM customers;

/*Question 2 - How many females are in the DB?*/
SELECT count(*)
FROM customers
WHERE gender = 'female';

/*Question 3 - write a query that will return the amount of males and the amount of females in 1 table*/
SELECT gender, COUNT(*)
FROM customers
GROUP BY gender;

/*Question 4 - is this table in 1NF? If it is not, then put it in 1NF*/
-- Rule 1 - Unique identifier required, there is no primary key
DESCRIBE customers;
-- Rule 2 - Each row must have atomic data
SELECT * FROM customers LIMIT 10;

-- both rules of 1NF are violated, we need to add a primary key and make the data
ALTER TABLE customers
ADD customerID INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

SELECT * FROM customers;

-- now we need to break up the full address into street and city
ALTER TABLE customers
ADD streetAddress VARCHAR(60) AFTER full_address,
ADD city VARCHAR(60) AFTER streetAddress;

SELECT * FROM customers;

-- Step 1 - write a query to ensure we get the correct data before updating the table
SELECT substring_index(full_address,',',1)
FROM customers;

SET SQL_SAFE_UPDATES = 0;

UPDATE customers
SET streetAddress = substring_index(full_address,',',1);

SELECT trim(substring_index(full_address,',',-1)),full_address
FROM customers;

UPDATE customers
SET city = trim(substring_index(full_address,',',-1));

SELECT * FROM customers

ALTER TABLE customers
DROP COLUMN full_address;


/*Question 5 - add a column to customers called city_population - it should represent whole numbers
               and be positioned to the right of the city column*/
ALTER TABLE customers
ADD cityPopulation INT AFTER city;


/*Question 6 - set the city_populations as follows using 1 CASE command*/
/*             Barrie      =   177,061
               Toronto     = 2,480,000
               Collingwood =    17,290
               Thunder Bay =   108,359       */
UPDATE customers
SET cityPopulation = 
CASE
	WHEN city = 'Barrie' THEN 177061
	WHEN city = 'Toronto' THEN 2480000
    WHEN city = 'Collingwood' THEN 17290
    WHEN city = 'Thunder Bay' THEN 108359
END;

SELECT * FROM customers;
/*Question 7 - show all the cities that have populations defined.  Note cities should not be duplicated and 
  should be ordered alphabetically*/
SELECT city, cityPopulation
FROM customers
WHERE cityPopulation IS NOT NULL
GROUP BY city
ORDER BY city ASC;

SELECT DISTINCT city
FROM customers
WHERE cityPopulation IS NOT NULL
ORDER BY city;

/*Question 8 - Display all of the surnames in upper case, sorted alphabetically without duplicates       */
/*             NOTE:  Do not change the original table, just display it in upper case                    */
SELECT DISTINCT UPPER(surname)
FROM customers
ORDER BY surname ASC;


/*Question 9 - Display all of the emailaddress's in lower case  */
/*             NOTE:  Do not change the original table, just display it in lower case                    */
SELECT LCASE(emailaddress)
FROM customers; 

/*Question 10 - why would it be valuable to put the output in upper or lower case? */
/*
	If we have a table where the email address is the primary key
	Jaret.Wright@GeorgianCollege.ca and jaret.wright@georgiancollege.CACHE INDEX

	With UPPER and LOWER we can force everythingn that is stored to be consistent
*/


/*Question 11 - Display all columns of the customers table ordered alphabetically from A-Z using the surname, then by the given name*/
SELECT *
FROM customers
ORDER BY surname, givenname;


/***********************************************************************************/
/* We have a large number of customers, let's start tracking their purchases       */
/* An easy way to do that is to give them a loyality card, that way everytime they */
/* make a purchase, that info can go into our DB                                   */
/***********************************************************************************/

CREATE TABLE products
(
	productID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(300),
    price DEC(6,2) NOT NULL,
    manufacturer VARCHAR(40)
);

INSERT INTO products (description, price, manufacturer) VALUES 
	('THP 15.6" Laptop - Black (Intel Celeron N2840 / 500GB HDD / 4GB RAM / Windows 8.1)',329.99, 'HP'),
    ('ASUS X Series 15.6" Laptop - Black (Intel Dual-Core Celeron N2830/500GB HDD/4GB RAM/Windows 8.1)',349.99, 'ASUS'),
    ('Dell Inspiron 15.6" Laptop - Silver (Intel Core i7-4510U / 1TB HDD / 8GB RAM / Windows 8.1)',799.99, 'Dell'),
    ('Dell Inspiron i3542 15.6" Laptop - Black (Intel Pentium 3558U Processor/500GB HDD/4GB RAM)', 549.99, 'Dell'),
    ('Lenovo G50 15.6" Laptop - Black (AMD A6-6310 / 1TB HDD / 8GB RAM / Windows 8.1)',599.99,'Lenovo'),
    ('Eurocom Scorpius 3D 17.3" Gaming Laptop (Intel Core i7/16GB RAM/128GB SSD/1TB HDD/Windows 7)',4899.99,'Eurocom'),
    ('EUROCOM Scorpius 3D 17.3" Gaming Laptop-Black (Intel Core i7-3840QM/120GB mSATA SSD/2TB HDD)',4899.99,'Eurocom'),
    ('Apple MacBook Pro 15.4" Intel Core i7 2.8GHz Laptop with Retina Display',3399.99,'Apple'),
    ('EUROCOM X5 17.3" Gaming Laptop - Black (Intel Core i7-4800MQ/1TB HDD/24GB RAM/Windows 8)',2999.99,'Eurocom');
    
    SELECT * FROM products;
    
-- Now we have a list of products that people can purchase.  Let's create a table to track those purchases.

CREATE TABLE purchases
(
	purchaseID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	customerID INT NOT NULL,
    productID INT NOT NULL,
    purchaseDate TIMESTAMP,
    purchasePrice DEC(6,2),
    FOREIGN KEY (customerID) REFERENCES customers(customerID),
    FOREIGN KEY (productID) REFERENCES products(productID)
);


INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (5604, 5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (15604,1, NOW(), 300);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (5332, 2, NOW(), 349.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (4,    8, NOW(), 3000.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (763,  5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (564,  5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (504,  5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (604,  5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (560,  5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (15604,5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (204,  5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (555,  5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (8,    5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (9,    5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (1023, 5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (2345, 5, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (6543, 1, NOW(), 329.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (7893, 1, NOW(), 270.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (9823, 2, NOW(), 330.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (1234, 3, NOW(), 650.34);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (2345, 4, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (3456, 9, NOW(), 2734.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (4567, 1, NOW(), 300.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (5678, 2, NOW(), 324.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (6789, 3, NOW(), 750.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (10789,3, NOW(), 750.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (1189, 3, NOW(), 750.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (1200, 2, NOW(), 250.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (1302, 8, NOW(), 3050.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (1234, 3, NOW(), 550.99);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (2234, 7, NOW(), 4500);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (2345, 8, NOW(), 3802);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (784,  9, NOW(), 2750);
INSERT INTO purchases (customerID, productID, purchaseDate, purchasePrice) VALUES (1342, 1, NOW(), 302.99);

SELECT *
FROM purchases, customers
WHERE purchases.customerID = customers.customerID;

/*Who has spent the most money at our store?*/
SELECT customerID, SUM(purchasePrice)
FROM purchases
GROUP BY customerID
ORDER BY 2 DESC;

-- Join it with customer table to see who the customer is
SELECT customers.customerID, givenname, surname, emailaddress, SUM(purchasePrice)
FROM purchases INNER JOIN customers ON purchases.customerID = customers.customerID
GROUP BY customerID
ORDER BY 5 DESC
limit 1;

SELECT customers.customerID, givenname, surname, emailaddress, SUM(purchasePrice)
FROM purchases INNER JOIN customers ON purchases.customerID = customers.customerID
GROUP BY customerID
HAVING sum(purchasePrice) = (SELECT sum(purchasePrice)
							FROM purchases
                            GROUP BY customerID
                            ORDER BY 1 DESC
                            LIMIT 1);
                            
-- Write a query that will return all columns of the customers and purchases table
-- Hint: ensure the customerID's are the same in each table
SELECT * 
FROM purchases INNER JOIN customers ON purchases.customerID = customers.customerID;

SELECT * 
FROM customers INNER JOIN purchases ON purchases.customerID = customers.customerID;

-- Write a query that will return the customerID, first name, last name, and product
-- description for each purchases
SELECT purchases.customerID, givenname, surname, description
FROM customers INNER JOIN purchases ON customers.customerID = purchases.customerID
				INNER JOIN products ON purchases.productID = products.productID;



/*What are our top volume products?  Show all the products sold based on volume and the average purchase price for each product*/
SELECT purchases.productID, description, COUNT(purchasePrice), ROUND(AVG(purchasePrice),2) AS 'Average Purchase Price'
FROM purchases INNER JOIN products ON purchases.productID = products.productID
GROUP BY productID
ORDER BY 3 DESC,4 DESC;

-- List the products and description ordered by the highest revenue to the lowest
-- Step 1 - Identify which table can give us the sales/revenue information
SELECT products.productID, description, (purchasePrice) AS 'Revenue'
FROM purchases INNER JOIN products ON purchases.productID = products.productID
GROUP BY productID
ORDER BY 3 DESC;
/*************************************************************************/
/*                         Recreate the donuts table                     */
/*************************************************************************/
DROP TABLE IF EXISTS doughnuts;
DROP TABLE IF EXISTS donuts;

CREATE TABLE donuts (
    donutName VARCHAR(20) NOT NULL,
    donutType VARCHAR(20) NOT NULL,
    cost DEC(3,2) NOT NULL DEFAULT 1.00,
    customer_rating INT
);

INSERT INTO donuts (name, type, customer_rating) VALUES ('maple', 'ring', 4);
INSERT INTO donuts (name, type, cost, customer_rating) VALUES ('apple fritter', 'cruller', 1.70, 3);
INSERT INTO donuts (name, type, cost, customer_rating) VALUES ('chocolate', 'ring', 2.00, NULL);
INSERT INTO donuts (name, type, cost, customer_rating) VALUES ('caramel', 'ring', 2.50, 4);
INSERT INTO donuts (name, type, cost, customer_rating) VALUES ('jelly', 'filled', 2.50, NULL);
INSERT INTO donuts (name, type, cost, customer_rating) VALUES ('honey dip', 'ring', 3.00, NULL);
INSERT INTO donuts (name, type, cost, customer_rating) VALUES ('vanilla', 'ring', 4.50, 2);
INSERT INTO donuts (name, type, cost, customer_rating) VALUES ('walnut crunch', 'cruller', 2.50, 3);
INSERT INTO donuts (name, type, cost, customer_rating) VALUES ('blueberry', 'filled', 2.50, 4);
INSERT INTO donuts (name, type, cost, customer_rating) VALUES ('plain', 'ring', 1, NULL);
INSERT INTO donuts (name, type, cost, customer_rating) VALUES ('glazed', 'cruller', 4, 3);

/*Question 11 - find the average cost of all donuts.  The column should be labeled 'Average Cost $' and only have 2 decimal points*/


/*Question 12 - show the mininum donut rating.  Label the column 'Minimum Customer Rating*/

 
/*Question 13 - show the highest donut rating*/


/*Question 14 - count how many donuts do not have a rating.  Label the column '# of donuts without ratings'*/


/*Question 15 - find the average rating for each type of donut, display the donut type and rating accurate to 1 decimal point*/


/*Question 16 - Find the donut(s) with the minimum rating.  Use a nested query*/



/*Question 17 - Find the donut(s) with the maximum rating.  Use a nested query*/


/*Question 18 - Is this table in 1NF?  Describe why or why not*/


/*Question 19 - If the table is not in 1NF, ALTER it to be in 1NF*/



/*Question 20 - display the first, 2nd and 3rd donuts in the table with the highest customer rating*/


/*Question 21 - What does CRUD stand for?*/


/*Question 22 - What does SQL stand for?*/


/*Question 23 - Write a query that will calculate the tax on $10.00.  Hint: the formula is 10*0.13 and you do not need a table name*/


/*Question 24 - display all the donuts that start with a c*/


/*Question 25 - remove all the donuts that do not have a customer rating*/
