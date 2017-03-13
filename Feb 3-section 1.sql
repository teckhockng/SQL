USE w17s1;

CREATE TABLE musicInfo
(
	songTitle VARCHAR(50),
    artist VARCHAR(50),
    lengthInSec INT,
    yearReleased INT,
    starRanking INT(1)
);

INSERT INTO musicInfo VALUES ('Whiter shade of pale','Procol Harium',
							   249, 1967, 5);
INSERT INTO musicInfo VALUES ('Eleanor Rigby', 'Beatles',127,1966,5);
INSERT INTO musicInfo VALUES ('Long Time','Boston',185,1977,5);
INSERT INTO musicInfo VALUES ('Panga','Diljit',189, 2009, 3);
INSERT INTO musicInfo VALUES ('Forest Whitaker','Bad Books',244, 2012, 1);
INSERT INTO musicInfo VALUES ('Allstar','Smash Mouth',203,1995,5);

SELECT *
FROM musicInfo;

-- Write a query that returns the song(s) with the highest ranking
SELECT *
FROM musicInfo
WHERE starRanking = (5);

-- write a query that returns the highest star ranking
SELECT MAX(starRanking)
FROM musicInfo;

-- combine the queries together
SELECT *
FROM musicInfo
WHERE starRanking = (SELECT MAX(starRanking)
					 FROM musicInfo);
                     
UPDATE musicInfo
SET starRanking = 11
WHERE songTitle = 'AllStar';

SET SQL_SAFE_UPDATES = 0;

-- return the average length of songs
SELECT *
FROM musicInfo;

SELECT ROUND(AVG(lengthInSec),0) AS 'Average time in seconds'
FROM musicInfo;

-- make the songTitle column capable of support 60 characters
ALTER TABLE musicInfo
CHANGE COLUMN songTitle songTitle VARCHAR(60);

SELECT * FROM musicInfo;

-- make the yearReleased the first column
ALTER TABLE musicInfo
CHANGE COLUMN yearReleased yearReleased INT FIRST;

-- Add a genre field, update it and then take a break
ALTER TABLE musicInfo
ADD COLUMN genre VARCHAR(30) AFTER artist;

SELECT * FROM musicInfo;

SELECT lengthInSec / starRanking
FROM musicinfo;

SELECT LEFT(songTitle, 3), songTitle
FROM musicinfo;

-- returns the area code of a phone number
SELECT LEFT('705-555-1224',3);

-- returs the right most characters
SELECT RIGHT(songTitle, 3), songTitle
FROM musicInfo;

-- selects the the string starting at character 3
SELECT SUBSTRING(songTitle, 3), songTitle
FROM musicInfo;

-- returns part of string starting at position 3, ending at position 6
SELECT SUBSTRING(songTitle, 3, 6), songTitle
FROM musicInfo;

-- returns the string up to the specified delimeter
SELECT SUBSTRING_INDEX('Allstar.why.hmmm' , '.', 1);

SELECT SUBSTRING_INDEX('Allstar.why.hmmm' , '.', 2);

-- returns the string starting from the left hand side
SELECT SUBSTRING_INDEX('Allstar.why.hmmm' , '.', -1);

SELECT SUBSTRING_INDEX('Allstar.why.hmmm' , '.', -2);

SELECT CONCAT('favourite','songs','are fun','to listen to');

-- return 1 column that has the song title by artist
SELECT CONCAT(songTitle, ' by ', artist) AS 'our favourite songs'
FROM musicInfo;

ALTER TABLE musicInfo
ADD COLUMN combinedColum VARCHAR(80);

SELECT * FROM musicInfo;

UPDATE musicInfo
SET combinedColum = CONCAT(songTitle, ' by ', artist);

CREATE TABLE grade_center
(
    firstName VARCHAR(30),
    lastName  VARCHAR(30),
    course    VARCHAR(20),
    grade     INT
);

INSERT INTO grade_center (firstName, lastName, course, grade) VALUES
    ('Phineas', 'Flynn',         'COMP2003',  88),
    ('Ferb',    'Fletcher',      'COMP2003', 100),
    ('Candace', 'Fletcher',      'COMP2003',  60),
    ('Blajeet', ' ',             'COMP2003', 100),
    ('Major',   'Monogram',      'COMP2003',  50),
    ('Dr.',     'Doofenshmirtz', 'COMP2003',  55),
    ('Isabella','Garcia-Shapiro','COMP2003',  90),
    ('Phineas', 'Flynn',         'COMP2007',  88),
    ('Ferb',    'Fletcher',      'COMP2007', 100),
    ('Candace', 'Fletcher',      'COMP2007',  60),
    ('Blajeet', ' ',             'COMP2007', 100),
    ('Major',   'Monogram',      'COMP2007',  50),
    ('Dr.',     'Doofenshmirtz', 'COMP2007',  55),
    ('Isabella','Garcia-Shapiro','COMP2007',  90);

SELECT * FROM grade_center;

-- what is the average grade for the school?
SELECT ROUND(AVG(grade),0) AS 'Average Grade'
FROM grade_center;


-- how many courses has each student taken?
SELECT firstName, lastName, COUNT(*)
FROM grade_center
GROUP BY firstName, lastName
ORDER BY 3 DESC;

-- show how many courses a person took, and achieved 80 or more
SELECT firstName, lastName, COUNT(*)
FROM grade_center
WHERE grade >= 80
GROUP BY firstName, lastName
HAVING COUNT(course) >= 2
ORDER BY lastName ASC;

UPDATE grade_center
SET grade = 78
WHERE firstName = 'Ferb' AND course = 'COMP2003';

