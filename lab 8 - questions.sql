/*Let's get back into playing with Databases by using a large DB file.  Open the file called "Big list of customers.sql" in Workbench.  Note: this file is too big to copy and paste.*/
/*How many customers are in our DB?*/


/*What percentage of the DB is female?*/


/*What is the average height of men in the DB?*/


/*What is the average age of people in the database?*/


/*What is the average age of women in the database*/

USE gc200349362;

DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees
(
    employee_ID   INT(5)  ZEROFILL NOT NULL AUTO_INCREMENT,
    first_name    VARCHAR(30),
    last_name     VARCHAR(30),
	streetAddress VARCHAR(100),
	province      CHAR(2),
    PRIMARY KEY (employee_ID)
);

/*Add some employees*/
INSERT INTO employees (first_name, last_name, streetAddress, province) VALUES 
							('Fred', 'Flintstone', '23 Bedrock Ave', 'ON'), 
							('Barney', 'Rubble','24 Bedrock Ave', 'ON'), 
                            ('Bam Bam', 'Rubble','24 Bedrock Ave', 'ON'), 
                            ('Wilma', 'Flintstone','23 Bedrock Ave', 'ON');

SELECT * FROM employees;

/*Table to track equipment*/
CREATE TABLE equipment
(
    equipment_ID   INT(8) ZEROFILL NOT NULL AUTO_INCREMENT,
    employee_ID    INT(5) ZEROFILL NOT NULL,
    equipment_desc VARCHAR(100),
    PRIMARY KEY (equipment_ID),
    FOREIGN KEY (employee_ID) REFERENCES employees (employee_ID)
);
DESC equipment;

INSERT INTO equipment (employee_ID, equipment_desc) VALUES
    (1, 'Parrot'),          (1, 'extra large dinosaur'),
    (2, 'small dinosaur'),  (4, 'dish washer dinosaur');

SELECT * FROM equipment;
SELECT * FROM employees;

INSERT INTO employees VALUES(5, 'Betty','Rubble','23 Bedrock Ave','ON');
/*Lets see what is actually happening when we combine the tables*/
SELECT * 
FROM employees, equipment;

-- use an INNER JOIN with conditions
SELECT *
FROM employees INNER JOIN equipment ON employees.employee_ID = equipment.employee_ID;

/*Display, the first name, last name and equipment signed out for each piece of equipment*/
SELECT first_name, last_name, equipment_desc
FROM employees INNER JOIN equipment ON employees.employee_ID = equipment.employee_ID;

/*Try to enter an invalid employee # into the equipment table.  Think about referential integrity*/
INSERT INTO equipment (employee_ID, equipment_desc) VALUES  (6, 'Rock blasting duck');   


/*Display all the equipment signed out by Fred Flintstone*/
SELECT first_name, last_name, equipment_desc 
FROM employees INNER JOIN equipment ON employees.employee_ID = equipment.employee_ID
WHERE first_name = 'Fred' AND last_name = 'Flintstone';


/*Display, the first name, last name and equipment signed out for each piece of equipment using RIGHT OUTER JOIN*/
SELECT first_name, last_name, equipment_desc 
FROM employees RIGHT JOIN equipment ON employees.employee_ID = equipment.employee_ID;

/*Run the same query, but change it to LEFT OUTER JOIN*/
SELECT first_name, last_name, equipment_desc 
FROM employees LEFT JOIN equipment ON employees.employee_ID = equipment.employee_ID;

/*Why are the results different?*/


/*Write a query to return the column name & equipment_desc for just Fred Flintstone using INNER JOIN*/


/*Which employees do not have any equipment?*/
SELECT *
FROM employees LEFT JOIN equipment ON employees.employee_ID = equipment.employee_ID
WHERE equipment_desc IS NULL;

/*********************************/
/*             JOINS             */
/*********************************/

DROP TABLE IF EXISTS grade_center;  /*drop the grade_center table if you have it in your DB*/
DROP TABLE IF EXISTS gradecenter;
DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;
DESC students;

/*create a table to hold students*/
CREATE TABLE students
(
    student_num INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name  VARCHAR(30) NOT NULL,
    PRIMARY KEY (student_num)
);

/*add some students*/
INSERT INTO students VALUES (20011234, 'Phineas', 'Fletcher');
INSERT INTO students (first_name, last_name) VALUES ('Ferb',    'Flynn');
INSERT INTO students (first_name, last_name) VALUES ('Candace', 'Fletcher');
INSERT INTO students (first_name, last_name) VALUES ('Baljeet', 'Singh');
INSERT INTO students (first_name, last_name) VALUES ('Major',   'Monogram ');
INSERT INTO students (first_name, last_name) VALUES ('Dr.',     'Doofenshmirtz');
INSERT INTO students (first_name, last_name) VALUES ('Isabella','Garcia-Shapiro');

SELECT * FROM students;

/*create a table to hold courses*/
CREATE TABLE courses
(
    course_name VARCHAR(50) NOT NULL,
    course_num  CHAR(11) NOT NULL,      /*typical format COMP2003-02*/
    start_date  DATE
);

/*add some courses*/
INSERT INTO courses 
VALUES ('Introduction to Relational DB', 'COMP2003-02', '2013-09-03'),
       ('Introduction to Relational DB', 'COMP2003-03', '2013-09-03'),
       ('Project Management for IT',     'MGMT2008-01', '2011-01-04'),
       ('Systems Analysis and Design',   'COMP2005-01', '2012-09-04');

/*Confirm the courses look correct*/
SELECT * FROM courses;

/*create an associative entity called "grade center"*/
CREATE TABLE grade_center
(
    grade_id INT NOT NULL AUTO_INCREMENT,
    course_num VARCHAR(30) NOT NULL,
    student_num INT NOT NULL,
    final_grade INT,
    PRIMARY KEY (grade_id)
);

/*add some grades*/
INSERT INTO grade_center (course_num, student_num, final_grade) 
VALUES ('COMP2003-02', 20011234, 88),
       ('COMP2003-02', 20011235, 77),
       ('COMP2003-02', 20011236, 65),
       ('COMP2003-02', 20011237, 53),
       ('COMP2003-02', 20011238, 98),
       ('COMP2003-02', 20011239, 98),
       ('COMP2003-02', 20011240, 83),
       ('MGMT2008-01', 20011234, 78),
       ('MGMT2008-01', 20011235, 67),
       ('MGMT2008-01', 20011236, 55),
       ('MGMT2008-01', 20011237, 43),
       ('MGMT2008-01', 20011238, 88),
       ('MGMT2008-01', 20011239, 88),
       ('MGMT2008-01', 20011240, 93),
       ('COMP2005-01', 20011234, 79),
       ('COMP2005-01', 20011235, 68),
       ('COMP2005-01', 20011236, 56),
       ('COMP2005-01', 20011237, 44),
       ('COMP2005-01', 20011238, 89),
       ('COMP2005-01', 20011239, 92),
       ('COMP2005-01', 20011240, 94);

/*confirm that the grades are entered ok*/
SELECT * FROM grade_center;

/*Question 1 - Draw the ERD of this DB*/


/*Question 2 - Add the appropriate foreign keys to ensure data integrity*/
DESC grade_center;
-- Add a reference to the students table
ALTER TABLE grade_center
ADD FOREIGN KEY (student_num) REFERENCES students(student_num);

-- this will not work yet because the courses table does not have a primary key
ALTER TABLE grade_center
ADD FOREIGN KEY (course_num) REFERENCES courses (course_num);

ALTER TABLE courses
ADD PRIMARY KEY (course_num);

ALTER TABLE grade_center
ADD FOREIGN KEY (course_num) REFERENCES courses (course_num);

DESC courses;

/*test your FOREIGN KEYS by running the following line - it should create an error*/
INSERT INTO grade_center (course_num, student_num, final_grade) 
VALUES ('COMP2008-02', 20011234, 88);

/*Question 3 - Are the tables in 1NF?  If not, convert them to 1NF*/
DESC grade_center;
DESC students;
-- Yes, they are in INF

SELECT * FROM grade_center;
/*Question 4 - List the first name, last name and course num where any student achieved a mark >= 80   */
/*             using INNER JOIN                                                                        */
SELECT first_name, last_name, course_num
FROM students INNER JOIN grade_center ON grade_center.student_num = students.student_num
WHERE final_grade >= 80;

/*Question 5 - List first name, last name, student # and the average grade (rounded to 1 decimal)
               for each student using INNER JOIN*/
SELECT first_name, last_name, students.student_num, round(avg(final_grade),1) AS 'Average Mark'
FROM students INNER JOIN grade_center ON grade_center.student_num = students.student_num
GROUP BY first_name, last_name;



