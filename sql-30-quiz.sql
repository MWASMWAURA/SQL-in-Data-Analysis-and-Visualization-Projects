show databases;
use testdb;


/*	30 Simple SQL Interview Queries	*/
/************************************/

/*1. Delete table Employee ,Department and Company.*/

DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS company;
/*
2. Create tables	*/
 CREATE TABLE department (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(25) NOT NULL
);
CREATE TABLE employee (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(25) NOT NULL,
    department_id INT NOT NULL,
    salary INT NOT NULL,
    FOREIGN KEY (department_id)
        REFERENCES department (id)
);

CREATE TABLE company (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(25) NOT NULL,
    revenue INT
);


/*	4. Add rows into Department table */
 
 INSERT INTO department(name) 
 VALUES 
 ('IT'),
 ('Management'),
 ('IT'),
 ('Support');
 
 /*
 5. Add rows into company table */
 
 INSERT INTO company(name,revenue)
 VALUES
 ('IBM',200000),
 ('GOOGLE',9000000),
 ('APPLE',10000000);
 
 /*5. Add rows into employee table: */
 INSERT INTO employee(name, city ,department_id, salary)
VALUES
('David','London',3,80000),
('Emily', 'London', 3, 70000),
('Peter' , 'Paris', 3, 60000),
('Ava','Paris',3,50000),
('Penny','London',2,110000),
('Jim','London',2,90000),
('Amy','Rome',4,30000),
('Cloe','London',3,110000);
 
 /*
 6. Query all rows from department table
 */
SELECT 
    *
FROM
    department;

/*7. Change the name of department with id = 1 to 'Management'
*/
UPDATE department 
SET 
    name = 'Management'
WHERE
    id = 1;


/*8.Delete employees with salary greater than 100000
*/
DELETE FROM employee 
WHERE
    salary > 100000;

/*SET sql_safe_updates = 0;*/ -- uncomment if unable to run delete due to safe mode then run the delete query again
/*SET sql_safe_updates = 1;*/ -- uncomment this to enable safe mode
/*9. Query the names of companies
*/
SELECT 
    name
FROM
    company;

/*10. Query the name and city of every employee
*/
SELECT 
    name, city
FROM
    employee;

/*11. Query all companies with revenue greater than 5 000 000 */
SELECT 
    *
FROM
    company
WHERE
    revenue > 5000000;

/*12. Query all companies with revenue smaller than 5 000 000 */
SELECT 
    *
FROM
    company
WHERE
    revenue < 5000000;

-- OR 
SELECT 
    *
FROM
    company
WHERE
    NOT revenue >= 5000000;

/*13. Query all companies with revenue smaller than 5 000 000 , but you cannot use the < operator*/

SELECT 
    *
FROM
    company
WHERE
    NOT revenue >= 5000000;

/*14. Query all employees with salary greater than 50 000  and smaller than 70000*/

SELECT 
    *
FROM
    employee
WHERE
    salary BETWEEN 50000 AND 70000;-- the BETWEEN AND includes the boundaries

SELECT 
    *
FROM
    employee
WHERE
    salary >= 50000 AND salary <= 70000;

/*16. Query all employees with salary equal to 80000 */

SELECT 
    *
FROM
    employee
WHERE
    salary = 80000;

/*17. Query all employees with salary not equal to 80000 */

SELECT 
    *
FROM
    employee
WHERE
    salary != 80000;

/*18. Query all names of employees with salary greater than 70000 */

SELECT 
    *
FROM
    employee
WHERE
    salary > 70000;

/*19. Query all employees that work in city that starts with L or ends with S */

SELECT 
    *
FROM
    employee
WHERE
    city LIKE 'L%' OR city LIKE '%S';

/*20. Query all employees that work in city with 'o' somewhere in the middle */

SELECT 
    *
FROM
    employee
WHERE
    city LIKE '%o%';

/*21. Query all departments (each name only once)
 */
SELECT DISTINCT
    name
FROM
    department;

/*22. Query names of all employees together with id of department they work in , but you cannot use JOIN */

SELECT 
    emp.name, dep.id, dep.name
FROM
    employee emp,
    department dep
WHERE
    emp.department_id = dep.id
ORDER BY emp.name , dep.id;

/*23. Query names of all employees together with id of department using JOIN */

SELECT 
    emp.name, dep.id, dep.name
FROM
    employee emp
        JOIN
    department dep ON emp.department_id = dep.id
ORDER BY emp.name , dep.id;

/*24. Query name of every company together with every department without JOIN*/

SELECT com.name , dep.name
FROM company com , department dep 
ORDER BY com.name;

/*25. Query name of every company together with every department with JOIN */

SELECT com.name, dep.name
FROM company com , department dep
WHERE dep.name NOT LIKE 'Support'
ORDER BY com.name;

/*26. Query employee name together with the department name 
*/

SELECT emp.name , dep.name
FROM employee emp , department dep 
WHERE emp.department_id != dep.id;

/*27. Query company name together with other companies name
LIKE:
GOOGLE Apple
GOOGLE IBM
Apple IBM
...
*/

SELECT com1.name ,com2.name
FROM company com1 ,company com2
WHERE com1.name != com2.name 
ORDER BY com1.name ,com2.name;

/*28. Query employee names with salary smaller than 80 000 without using NOT */

SELECT e1.name 
FROM employee e1
WHERE e1.salary < 80000 ;

/*29. Query names of every company and change the column name to 'company'
*/

SELECT name AS Company
FROM company;

/*30. Query all employees that work in same department as Peter */

SELECT 
    e.name
FROM
    employee e
        LEFT JOIN
    department dep ON dep.id = e.department_id
WHERE
    dep.name = (SELECT 
            dep.name
        FROM
            department dep
                LEFT JOIN
            employee e ON dep.id = e.department_id
        WHERE
            e.name = 'Peter');
