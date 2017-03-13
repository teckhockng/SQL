-- Create table to store values
USE gc200349362;
CREATE TABLE movies_200349362
(
	Movie_name VARCHAR(30),
    Release_date DATE,
    Cost_Mil INT,
	Revenue_Mil INT
);

-- insert values into table
INSERT INTO movies_200349362 VALUES ('Toy Story', '1995-11-22', '31','365');
INSERT INTO movies_200349362 VALUES ('Toy Story 2', '1999-11-24', '90','512');
INSERT INTO movies_200349362 VALUES ('Toy Story 3', '2010-06-18', '200','1070');
INSERT INTO movies_200349362 VALUES ('A Bugs Life', '1998-11-25', '60','363');
INSERT INTO movies_200349362 VALUES ('Monsters Inc', '2001-11-02', '115','560');
INSERT INTO movies_200349362 VALUES ('Finding Nemo', '2003-05-30', '94','906');
INSERT INTO movies_200349362 VALUES ('The Incredibles', '2005-11-04', '92','615');
INSERT INTO movies_200349362 VALUES ('Cars', '2006-06-09', '120','462');
INSERT INTO movies_200349362 VALUES ('Cars 2', '2011-06-24', '200','560');
INSERT INTO movies_200349362 VALUES ('Ratatouille', '2007-06-29', '150','626');
INSERT INTO movies_200349362 VALUES ('Wall-E', '2008-06-27', '180','533');
INSERT INTO movies_200349362 VALUES ('Up', '2009-05-29', '175','731');
INSERT INTO movies_200349362 VALUES ('Brave', '2012-06-22', '185','555');
INSERT INTO movies_200349362 VALUES ('Monsters University', '2013-06-21', '200','744');
INSERT INTO movies_200349362 VALUES ('Planes', '2013-08-09', '50','220');
INSERT INTO movies_200349362 VALUES ('Inside Out', '2015-06-19', '245','850');
INSERT INTO movies_200349362 VALUES ('The Good Dinosaur', '2015-11-25', '188','299');
INSERT INTO movies_200349362 VALUES ('Finding Dory', '2016-06-17', '200','1022');

-- Show all movies and revenue sorted by release dates (oldest to newest)  
SELECT *
FROM movies_200349362
ORDER BY Release_date ASC;

-- Show the movie that had the maximum ROI
SELECT Movie_name, MAX(ROUND((Revenue_Mil-Cost_Mil)/Cost_Mil,2)) as ROI
FROM movies_200349362;

-- What was the total revenue for all of the movies made between Jan 1, 1990 to Dec 31, 1999
SELECT SUM(Revenue_Mil) AS 'Total Revenue(Mil)'
FROM movies_200349362
WHERE Release_date >= '1990-01-01' AND Release_date <= '1999-12-31';

-- Average revenue for all movies made in 2000-2015
SELECT ROUND(AVG(Revenue_Mil),2) AS 'Average Revenue(Mil)'
FROM movies_200349362
WHERE Release_date >= '2000-01-01' AND Release_date <= '2015-12-31';

-- e.	List all of the months that movies were released in.  For each month, show how many movies were released in that month. 
-- There should be 2 columns “month” and “num_of_movies”. 
SELECT monthname(Release_date) AS Month, count(Movie_name)
FROM movies_200349362
GROUP BY monthname(Release_date)
ORDER BY 1;

-- Total cost for all films
SELECT sum(Cost_Mil) AS 'Total Cost(Mil)'
FROM movies_200349362;

-- Net Income
SELECT sum(Revenue_Mil - Cost_Mil) AS 'Total Profit'
FROM movies_200349362;

-- Add movie “Fun times at Georgian”, released Jan 15, 2017, budget $63M, revenue $25M  
INSERT INTO movies_200349362 VALUES('Fun times at Georgian', '2017-01-17', 63,25);

-- 	Change any budgets under $90M to $100M
SELECT * 
FROM movies_200349362
WHERE Cost_Mil <= 90;

UPDATE movies_200349362
SET Cost_Mil = 100
WHERE Cost_Mil <= 90;

-- Change the column called “revenue” to be named “gross_income” 
ALTER TABLE movies_200349362
CHANGE COLUMN Revenue_Mil gross_income INT;

-- Change all instances of the word “Cars” to “Zip-Cars”.  
-- This should use 1 command to find all instance of the word Cars.  For example Cars 2 should be changed to Zip Cars 2. 
SELECT *
FROM movies_200349362
WHERE Movie_name LIKE '%car%';

UPDATE movies_200349362
SET Movie_name = concat('Zip', ' ', Movie_name)
WHERE Movie_name LIKE '%car%';

SELECT * 
FROM movies_200349362;

-- reomve all movies with the word “of” in the title
DELETE FROM movies_200349362
WHERE Movie_name LIKE '%of%';

-- reomve any movie that had a ROI less than 100% 
SELECT Movie_name, ROUND((gross_income-Cost_Mil)/Cost_Mil,2) as ROI
FROM movies_200349362
WHERE ROUND((gross_income-Cost_Mil)/Cost_Mil,2) <= 1.0;

DELETE FROM movies_200349362
WHERE ROUND((gross_income-Cost_Mil)/Cost_Mil,2) <= 1.0;
