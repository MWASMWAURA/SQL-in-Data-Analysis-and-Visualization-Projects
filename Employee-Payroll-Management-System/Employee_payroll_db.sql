create database  employee_payroll_MS;
USE employee_payroll_MS;

CREATE TABLE `Employee` (
    `employee_id` int  NOT NULL ,
    `first_name` varchar(25)  NOT NULL ,
    `last_name` varchar(25)  NOT NULL ,
    `hire_date` date  NOT NULL ,
    PRIMARY KEY (
        `employee_id`
    )
);

CREATE TABLE `Department` (
    `department_id` int  NOT NULL ,
    `department_name` varchar(30)  NOT NULL ,
    PRIMARY KEY (
        `department_id`
    )
);

CREATE TABLE `Salary` (
    `salary_id` int  NOT NULL ,
    `gross_salary` int  NOT NULL ,
    `hourly_pay` decimal(3,2)  NOT NULL ,
    `state_tax` int  NOT NULL ,
    `federal_tax` int  NOT NULL ,
    `account_id` int  NOT NULL ,
    PRIMARY KEY (
        `salary_id`
    )
);

CREATE TABLE `DepartmentProjectBridge` (
    `department_id` int  NOT NULL ,
    `project_id` int  NOT NULL 
);

CREATE TABLE `Project` (
    `project_id` int  NOT NULL ,
    `project_name` varchar(30)  NOT NULL ,
    `project_descr` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `project_id`
    )
);

CREATE TABLE `AccountDetails` (
    `account_id` int  NOT NULL ,
    `bank_name` varchar(50)  NOT NULL ,
    `account_number` varchar(50)  NOT NULL ,
    `employee_id` int  NOT NULL ,
    PRIMARY KEY (
        `account_id`
    )
);

CREATE TABLE `Education` (
    `education_id` int  NOT NULL ,
    `employee_id` int  NOT NULL ,
    `degree` varchar(30)  NOT NULL ,
    `graduation_year` year  NOT NULL 
);

CREATE TABLE `Leave` (
    `leave_id` int  NOT NULL ,
    `employee_id` int  NOT NULL ,
    `leave_date` date  NOT NULL 
);

CREATE TABLE `Employeeattendance` (
    `employee_id` int  NOT NULL ,
    `attendance_id` int  NOT NULL 
);

CREATE TABLE `Attendance` (
    `attendance_id` int  NOT NULL ,
    `hours_worked` int  NOT NULL 
);
CREATE TABLE Worklocation ( location_id int NOT NULL , 
	location VARCHAR(25), no_of_employees int , city VARCHAR(25) ,state VARCHAR(25));

ALTER TABLE Salary MODIFY COLUMN hourly_pay INT;

ALTER TABLE `Salary` ADD CONSTRAINT `fk_Salary_account_id` FOREIGN KEY(`account_id`)
REFERENCES `AccountDetails` (`account_id`);

ALTER TABLE `DepartmentProjectBridge` ADD CONSTRAINT `fk_DepartmentProjectBridge_department_id` FOREIGN KEY(`department_id`)
REFERENCES `Department` (`department_id`);

ALTER TABLE `DepartmentProjectBridge` ADD CONSTRAINT `fk_DepartmentProjectBridge_project_id` FOREIGN KEY(`project_id`)
REFERENCES `Project` (`project_id`);

ALTER TABLE `AccountDetails` ADD CONSTRAINT `fk_AccountDetails_employee_id` FOREIGN KEY(`employee_id`)
REFERENCES `Employee` (`employee_id`);

ALTER TABLE `Education` ADD CONSTRAINT `fk_Education_employee_id` FOREIGN KEY(`employee_id`)
REFERENCES `Employee` (`employee_id`);

ALTER TABLE `Leave` ADD CONSTRAINT `fk_Leave_employee_id` FOREIGN KEY(`employee_id`)
REFERENCES `Employee` (`employee_id`);

ALTER TABLE `Employeeattendance` ADD CONSTRAINT `fk_Employeeattendance_employee_id` FOREIGN KEY(`employee_id`)
REFERENCES `Employee` (`employee_id`);

ALTER TABLE worklocation ADD constraint fk_Location_location_id PRIMARY KEY  (location_id)  ;
ALTER TABLE Employeeattendance ADD CONSTRAINT uq_Employeeattendance_attendance_id UNIQUE (attendance_id);

ALTER TABLE Employee ADD COLUMN city VARCHAR(25);
ALTER TABLE Employee ADD COLUMN state VARCHAR(25);

-- Try altering the table as below

-- ALTER TABLE `Employeeattendance` ADD CONSTRAINT `fk_Employeeattendance_attendance_id` FOREIGN KEY(`attendance_id`)
-- REFERENCES `Attendance` (`attendance_id`);

-- INSERTING VALUES
INSERT INTO Employee VALUES (101,'Ojas','Phansekar',str_to_date('14-APR-16', '%d-%b-%y'),'New York City','New York');
INSERT INTO Employee VALUES (102,'Vrushali','Patil',str_to_date('21-JUN-18', '%d-%b-%y'),'Boston','Massachusetts');
INSERT INTO Employee VALUES (103,'Pratik','Parija',str_to_date('13-SEP-19', '%d-%b-%y'),'Chicago','Illinois');
INSERT INTO Employee VALUES (104,'Chetan','Mistry',str_to_date('12-APR-11', '%d-%b-%y'),'Miami','Florida');
INSERT INTO Employee VALUES (105,'Anugraha','Varkey',str_to_date('16-AUG-17', '%d-%b-%y'),'Atlanta','Georgia');
INSERT INTO Employee VALUES (106,'Rasagnya','Reddy',str_to_date('25-JUL-18', '%d-%b-%y'),'San Mateo','California');
INSERT INTO Employee VALUES (107,'Aishwarya','Boralkar',str_to_date('18-DEC-10', '%d-%b-%y'),'San Francisco','California');
INSERT INTO Employee VALUES (108,'Shantanu','Savant',str_to_date('27-NOV-15', '%d-%b-%y'),'Seattle','Washington');
INSERT INTO Employee VALUES (109,'Kalpita','Malvankar',str_to_date('24-APR-16', '%d-%b-%y'),'Boston','Massachusetts');
INSERT INTO Employee VALUES (110,'Saylee','Bhagat',str_to_date('21-MAY-14', '%d-%b-%y'),'San Francisco','California');


INSERT INTO Department VALUES (1,'Human Resources');
INSERT INTO Department VALUES (2,'Software Development');
INSERT INTO Department VALUES (3,'Data Analysis');
INSERT INTO Department VALUES (4,'Data Science');
INSERT INTO Department VALUES (5,'Business Intelligence');
INSERT INTO Department VALUES (6,'Data Engineering');
INSERT INTO Department VALUES (7,'Manufacturing');
INSERT INTO Department VALUES (8,'Quality Control');

INSERT INTO Project VALUES (21,'Dev','Whatever');
INSERT INTO Project VALUES (22,'Prod','do something');
INSERT INTO Project VALUES (23,'Test','focus');
INSERT INTO Project VALUES (24,'Nothing','do nothing');
INSERT INTO Project VALUES (25,'Research','focus on everything');
INSERT INTO Project VALUES (26,'Next Steps','find some way out');

INSERT INTO AccountDetails VALUES (40,'Santander','S12344',101);
INSERT INTO AccountDetails VALUES (41,'Santander','S12345',102);
INSERT INTO AccountDetails VALUES (42,'Santander','S12346',103);
INSERT INTO AccountDetails VALUES (43,'Santander','S12347',104);
INSERT INTO AccountDetails VALUES (44,'Chase','C12344',105);
INSERT INTO AccountDetails VALUES (45,'Chase','C12345',106);
INSERT INTO AccountDetails VALUES (46,'Chase','C12347',107);
INSERT INTO AccountDetails VALUES (47,'Chase','C12334',108);
INSERT INTO AccountDetails VALUES (48,'BOFA','C12378',109);
INSERT INTO AccountDetails VALUES (49,'BOFA','C12390',110);

INSERT INTO Education VALUES (10,101,'MS',2017);
INSERT INTO Education VALUES (11,102,'MS',2019);
INSERT INTO Education VALUES (12,104,'MS',2011);
INSERT INTO Education VALUES (13,108,'MS',2015);
INSERT INTO Education VALUES (14,109,'Bachelor',2013);
INSERT INTO Education VALUES (15,107,'Bachelor',2008);
INSERT INTO Education VALUES (16,106,'Bachelor',2007);


INSERT INTO `Leave` VALUES (51,104,str_to_date('1-DEC-19', '%d-%b-%y'));
INSERT INTO `Leave` VALUES (52,108,str_to_date('2-DEC-19', '%d-%b-%y'));
INSERT INTO `Leave` VALUES (53,109,str_to_date('3-DEC-19', '%d-%b-%y'));
INSERT INTO `Leave` VALUES (54,107,str_to_date('4-DEC-19', '%d-%b-%y'));
INSERT INTO `Leave` VALUES (55,106,str_to_date('5-DEC-19', '%d-%b-%y'));
INSERT INTO `Leave` VALUES (56,104,str_to_date('6-DEC-19', '%d-%b-%y'));
INSERT INTO `Leave` VALUES (57,108,str_to_date('7-DEC-19', '%d-%b-%y'));
INSERT INTO `Leave` VALUES (58,109,str_to_date('7-DEC-19', '%d-%b-%y'));
INSERT INTO `Leave` VALUES (59,107,str_to_date('8-DEC-19', '%d-%b-%y'));
INSERT INTO `Leave` VALUES (60,106,str_to_date('9-DEC-19', '%d-%b-%y'));

INSERT INTO Attendance VALUES (90,10);
INSERT INTO Attendance VALUES (91,20);
INSERT INTO Attendance VALUES (92,30);
INSERT INTO Attendance VALUES (93,40);
INSERT INTO Attendance VALUES (94,45);
INSERT INTO Attendance VALUES (95,56);
INSERT INTO Attendance VALUES (96,58);

INSERT INTO worklocation VALUES (71,'North',4,'New York City','New York');
INSERT INTO worklocation VALUES (72,'North',4,'Boston','Massachusetts');
INSERT INTO worklocation VALUES (73,'North',4,'Chicago','Illinois');
INSERT INTO worklocation VALUES (74,'North',89,'Miami','Florida');
INSERT INTO worklocation VALUES (75,'South',90,'Atlanta','Georgia');
INSERT INTO worklocation VALUES (76,'South',100,'San Mateo','California');
INSERT INTO worklocation VALUES (77,'South',4,'San Francisco','California');
INSERT INTO worklocation VALUES (78,'South',2,'Seattle','Washington');
INSERT INTO worklocation VALUES (79,'South',25,'Alpharetta','Georgia');
INSERT INTO worklocation VALUES (80,'South',20,'Keene','New Hampshire');
INSERT INTO worklocation VALUES (81,'South',22,'Hampton','New Hampshire');



INSERT INTO EmployeeAttendance VALUES (101,90);
INSERT INTO EmployeeAttendance VALUES (102,91);
INSERT INTO EmployeeAttendance VALUES (103,92);
INSERT INTO EmployeeAttendance VALUES (104,93);
INSERT INTO EmployeeAttendance VALUES (105,94);
INSERT INTO EmployeeAttendance VALUES (106,95);
INSERT INTO EmployeeAttendance VALUES (107,96);
INSERT INTO EmployeeAttendance VALUES (108,97);
INSERT INTO EmployeeAttendance VALUES (109,98);
INSERT INTO EmployeeAttendance VALUES (110,99);

INSERT INTO DepartmentProjectBridge VALUES (1,21);
INSERT INTO DepartmentProjectBridge VALUES (2,22);
INSERT INTO DepartmentProjectBridge VALUES (3,23);
INSERT INTO DepartmentProjectBridge VALUES (4,24);
INSERT INTO DepartmentProjectBridge VALUES (5,25);
INSERT INTO DepartmentProjectBridge VALUES (6,26);
INSERT INTO DepartmentProjectBridge VALUES (7,21);
INSERT INTO DepartmentProjectBridge VALUES (8,24);

INSERT INTO Salary VALUES (1,57600,30,200,1000,40);
INSERT INTO Salary VALUES (2,76800,40,300,1300,41);
INSERT INTO Salary VALUES (3,96000,50,400,1500,42);
INSERT INTO Salary VALUES (4,115200,60,500,1700,43);
INSERT INTO Salary VALUES (5,57600,30,200,1000,44);
INSERT INTO Salary VALUES (6,76800,40,300,1300,45);
INSERT INTO Salary VALUES (7,96000,50,400,1500,46);
INSERT INTO Salary VALUES (8,115200,60,500,1700,47);
INSERT INTO Salary VALUES (9,57600,30,200,1000,48);
INSERT INTO Salary VALUES (10,76800,40,300,1300,49);


