SHOW DATABASES;
USE w17s1;

CREATE TABLE weatherInfo
(
	forecastDay DATE,
    maxTemp INT,
    minTemp INT
);

INSERT INTO weatherInfo VALUES ('2017-01-27',0,-4);
INSERT INTO weatherInfo VALUES ('2017-01-28',0,-7);
INSERT INTO weatherInfo VALUES ('2017-01-29',-6,-13);
INSERT INTO weatherInfo VALUES ('2017-01-30',-7,-11);
INSERT INTO weatherInfo VALUES ('2017-01-31',-2,-7);
INSERT INTO weatherInfo VALUES ('2017-02-01',12,-7);
INSERT INTO weatherInfo VALUES ('2017-02-02',12,-7);

SELECT * FROM weatherInfo;

-- write a query to return the average max temperature
SELECT ROUND(AVG(maxTemp), 0) AS 'Average max temp'
FROM weatherInfo;

-- Write a query that will return the day name for each
-- forecast day in our table
SELECT *
FROM weatherInfo;

SELECT DAYNAME(forecastDay), forecastDay, maxTemp, minTemp
FROM weatherInfo;

-- Write a query that will return the warmest day in our table
SELECT MAX(maxTemp), forecastDay 
FROM weatherInfo;

SELECT *
FROM weatherInfo;

-- step 1 - figure out what is the warmest day
SELECT MAX(maxTemp) 
FROM weatherInfo;

-- step 2 - "hard code" this into a query
SELECT *
FROM weatherInfo
WHERE maxTemp = 12;

-- step 3 - make the query dynamic
SELECT *
FROM weatherInfo
WHERE maxTemp = (SELECT MAX(maxTemp)
				 FROM weatherInfo);
                 
-- write a query that returns the coldest day(s) of the forecast
SELECT DAYNAME(forecastDay) AS 'Coldest Day(s)', minTemp
FROM weatherInfo
WHERE minTemp = (SELECT MIN(minTemp)
				 FROM weatherInfo);
          
SELECT DAYNAME(forecastDay) AS 'Coldest Day(s)', minTemp
FROM weatherInfo
ORDER BY minTemp LIMIT 1;

-- write a query that will return all the days with a max temp
-- below the average max temp
-- step 1 - figure out the average
SELECT AVG(maxTemp)
FROM weatherInfo;

-- step 2 - write a nested query to return all days below that number
SELECT *
FROM weatherInfo
WHERE maxTemp < (SELECT AVG(maxTemp)
				 FROM weatherInfo);

-- using limits
SELECT *
FROM weatherInfo
LIMIT 3;

SELECT *
FROM weatherInfo
LIMIT 4,2;

-- working with the doughnuts table
SELECT *
FROM doughnuts;

-- update all the ring doughnuts to $1.00
-- step 1 - write a query that can return all the ring doughnuts
SELECT *
FROM doughnuts
WHERE type = 'ring';

-- step 2 - write the UPDATE command
SET SQL_SAFE_UPDATES = 0;

UPDATE doughnuts
SET cost = 1.00
WHERE type = 'ring';

SELECT *
FROM doughnuts
WHERE type = 'cruller';

UPDATE doughnuts
SET cost = 2.00
WHERE type = 'cruller';

UPDATE doughnuts
SET cost = 1.50
WHERE type = 'filled';

SELECT *
FROM doughnuts
WHERE customer_rating = 4 OR customer_rating = 5;

UPDATE doughnuts
SET cost = 2.50
WHERE customer_rating = 4 OR customer_rating = 5;

UPDATE doughnuts
SET customer_rating  = customer_rating+1;

SELECT *
FROM doughnuts
WHERE customer_rating < 4;

UPDATE doughnuts
SET customer_rating = NULL
WHERE customer_rating < 4;

-- this will not work because nothing is equal to NULL
SELECT *
FROM doughnuts
WHERE customer_rating = NULL;

-- we need to use the "IS" operator
SELECT *
FROM doughnuts
WHERE customer_rating IS NULL;


SELECT * 
FROM weatherInfo;

-- delete the plain donut
-- step 1 - build a query to test your "where" condition
SELECT *
FROM doughnuts
WHERE name='plain';

DELETE FROM doughnuts
WHERE name='plain';

-- delete doughnuts without a customer rating
SELECT *
FROM doughnuts
WHERE customer_rating IS NULL;

DELETE FROM doughnuts
WHERE customer_rating IS NULL;

-- delete doughnuts with a customer rating of <2 or cost = 1.50
SELECT *
FROM doughnuts
WHERE customer_rating < 2 OR cost = 1.50;
 
-- delete all crullers except the apple fritter
SELECT *
FROM doughnuts
WHERE type = 'cruller' AND name != 'apple fritter';

SELECT *
FROM doughnuts
WHERE type = 'cruller' AND NOT name = 'apple fritter';


DELETE FROM doughnuts
WHERE type = 'cruller' AND name != 'apple fritter';
 
SELECT * 
FROM doughnuts
WHERE type = 'cruller';
 
-- using the nascar.sql file
SELECT *
FROM texasmotorspeedway;

-- list the # of wins for each make of car
SELECT make, COUNT(winner) AS '# of wins'
FROM texasmotorspeedway
GROUP BY make
ORDER BY 2 DESC;

SELECT winner, make
FROM texasmotorspeedway
ORDER BY make, winner;

-- how many events happen in each month
SELECT MONTHNAME(raceDay) AS 'Month', COUNT(*) AS '# of races'
FROM texasmotorspeedway
GROUP BY MONTHNAME(raceDay)
ORDER BY MONTH(raceDay);

