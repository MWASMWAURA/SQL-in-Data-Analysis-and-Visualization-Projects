-- creating views in MySql
CREATE OR REPLACE VIEW salary_range_calculator AS 
SELECT e.first_name, s.hourly_pay
FROM employee e
INNER JOIN accountdetails a ON e.employee_id = a.employee_id
INNER JOIN salary s ON a.account_id = s.account_id 
WHERE s.hourly_pay = 30;

-- using the views
SELECT * FROM salary_range_calculator;

-- creating materialized views 

	/*they store data queried physically hence need to be refreshed at certain intervals to reflect what's in the tables
	 since mysql doesn't have materialized views natively, but you can simulate it with a table and a scheduled job to refresh the data*/

DROP TABLE education_view;
	-- create a table to simulate the materialized view
CREATE TABLE education_view AS 
SELECT degree , count(degree) AS degree_count
FROM education
GROUP BY degree;
	-- to refresh the table , you can periodically run this:
TRUNCATE TABLE education_view;
INSERT INTO education_view
SELECT degree,count(degree)
FROM education
GROUP BY degree;

 
-- using cursors in mysql

/**supports cursors but only within stored procedures*/
DELIMITER // -- changes the statement delimiter from ; to // so that the entired stored procedure can be defined as a single block without being prematurely terminated by ;
CREATE PROCEDURE GetSalaries(IN p_hourly INT) -- takes one input parameter  p_hourly of type INT 
BEGIN -- marks the start of the stored procedure's body
	DECLARE done INT DEFAULT 0;
    DECLARE sal_id INT;-- to store salary_id fetched by the cursor
    DECLARE cur CURSOR FOR 
		SELECT salary_id 
        FROM salary 
		WHERE hourly_pay = p_hourly;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Open the cursor, making it ready to fetch rows
    OPEN cur;
    
    -- Loop through the result set
    read_loop: LOOP
		FETCH cur INTO sal_id; -- fetches the next row from the cursor and stored the value of salary_id into the variable sal_id
        IF done THEN 
			LEAVE read_loop;
		END IF;
        -- Process each row 
        SELECT sal_id;
	END LOOP;
    -- close the cursor
    CLOSE cur;
END //

DELIMITER ; /*When to use cursors: process each row individually in a way that isn't feasible with a single SQL statement */
	-- execute the GetSalaries procedure with an hourly_pay value of 50
CALL GetSalaries(50);


-- creating triggers
CREATE TRIGGER salary_update_trigger
BEFORE  UPDATE ON salary -- the trigger should fire before an update operation is performed on the salary table
FOR EACH ROW 
BEGIN 	
	IF NEW.hourly_pay > 50 THEN 
		SIGNAL SQLSTATE  '45000' SET MESSAGE_TEXT = 'hourly pay cannot exceed 50!';
	END IF;
END;
		-- NEW refers to the new data being inserted or updated
        -- SIGNAL SQLSTATE '45000' raises an error with a custom message
        
	-- Test the trigger
UPDATE salary
SET hourly_pay = 60
WHERE salary_id = 1;

DROP TRIGGER IF EXISTS salary_update_trigger;

-- creating events
-- enabling the event scheduler
SHOW VARIABLES LIKE 'event_scheduler'; -- to check if it's on or off 
/*SET GLOBAL event_scheduler = ON */ -- uncomment if it's off to turn it on

	-- creating a basic event
		/*An event is created and can be specified if it runs ONCE or REPEATEDLY*/
		
        -- RUNNING A ONE-TIME EVENT
CREATE EVENT delete_inactive_employees
ON SCHEDULE AT '2025-10-01 00:00:00'
DO 
	DELETE FROM employee WHERE hire_date < '2022-01-01 00:00:00';  -- this event will execute once on the scheduled time 
    
	-- creating a recurring event 
		-- i.e you may want to archive old records every month at midnight
        
CREATE TABLE archived_employee(
    employee_id INT,
    name VARCHAR(255),
    hire_date DATE);-- create a table to archive old records using event scheduler

CREATE EVENT archive_old_records
ON SCHEDULE EVERY 30 DAY
STARTS '2025-09-18 00:00:00'
DO 
	INSERT INTO archived_employee
    SELECT * FROM employee WHERE hire_date <'2023-01-01';
    
-- modify events
ALTER EVENT archive_old_records 
ON SCHEDULE EVERY 2 MONTH;

-- disable or enable an Event
ALTER EVENT archive_old_records DISABLE;
ALTER EVENT archive_old_records ENABLE;

-- viewing existing events
SHOW EVENTS;

-- drop / delete an Event
DROP EVENT IF EXISTS archive_old_records;
    
    
