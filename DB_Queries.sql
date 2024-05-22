-- if you want to create DB
CREATE DATABASE DB_Name 

-- if i want to change DB name 
ALTER DATABASE DB_oldName Modify Name = DB_newName

-- another way to change DB name by using a stored procedure

sp_renameDB 'DB_oldName', 'DB_newName'

-- if you want to delete the DB ... REMEMBER you can't delete system DBs
DROP DATABASE DB_newName

-- Creating Table 
CREATE TABLE Departments
(
  DepartmentId INT IDENTITY(1,1) PRIMARY KEY,
  DepartmentName NVARCHAR(100) NOT NULL,
 -- CONSTRAINT PK_Departments PRIMARY KEY (DepartmentId)
)
GO

CREATE TABLE Students
(
    StudentId INT IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    DOB DATE NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    Mobile NVARCHAR(50) NOT NULL,
    DepartmentId INT NOT NULL,
    CONSTRAINT PK_Students PRIMARY KEY (StudentId),
    CONSTRAINT FK_Students_Departments FOREIGN KEY (DepartmentId) REFERENCES Departments(DepartmentId)
)

-- if you forget to add foreign key after creating table you can use
ALTER TABLE Students ADD CONSTRAINT student_department_FK FOREIGN KEY DepartmentId REFERENCES Departments(DepartmentId)

-- if you want to add a default value for a column by using default constraint
-- if you give the col value null in insertion its value will be null not that default value
ALTER TABLE table_name ADD CONSTRAINT constraintName DEFAULT 'value' FOR colName

-- Deleting a Constraint 
ALTER TABLE table_name DROP CONSTRAINT constraintName

/*
Cascading Referential Integrity
    By using cascading referential integrity constraints, you can define the actions
    that the Database Engine takes when a user tries to delete or update
    a key to which existing foreign keys point.

    cascading actions can be(NO ACTION - CASCADE - SET NULL - SET DEFAULT)
*/

-- Check Constraint used to check the inserted value into col .. but NULL value will pass anyway
ALTER TABLE Person ADD CONSTRAINT CK_person_age CHECK (Age > 0 and Age < 70)


-- to reset the identity col 
DBCC CHECKIDENT(table_name,reseed,0)

-- get the last generated identity column value 
-- 3 ways (SCOPE_IDENTITY(), @@IDENTITY, IDENT_CURRENT('table_name'))
SELECT SCOPE_IDENTITY()          -- same session and same scope
SELECT @@IDENTITY                -- same session and across any scope
SELECT IDENT_CURRENT('Person')   -- any session and across any scope 


-- Select statement
SELECT col1,col2 
FROM table_name

-- select all cols
SELECT *
FROM table_name

-- select distinct rows 
SELECT DISTINCT col
FROM table_name

-- filtering with where

-- selecting persons lives in cairo
SELECT *
FROM Person 
WHERE City = 'Cairo'


-- selecting persons with age 20,21 or 22
SELECT *
FROM Person 
WHERE Age IN (20,21,22)

-- selecting persons with age 20,21 or 22
SELECT *
FROM Person 
WHERE Age BETWEEN 20 AND 22

-- selecting persons lives in cairo
SELECT *
FROM Person 
WHERE City LIKE 'Cairo'

-- selecting persons lives in any city starts with C letter
SELECT *
FROM Person 
WHERE City LIKE 'C%'

-- selecting persons not live in cairo
SELECT *
FROM Person 
WHERE City NOT LIKE 'Cairo'

-- selecting persons with names starts with M or S or T
SELECT *
FROM Person 
WHERE FirstName LIKE '[MST]%'

-- selecting persons with names not starts with M or S or T
SELECT *
FROM Person 
WHERE FirstName LIKE '[^MST]%'

-- sorting selected data
SELECT *
FROM Person 
ORDER BY FirstName

-- sorting selected data
SELECT *
FROM Person 
ORDER BY FirstName desc

-- selecting first 20 rows
SELECT TOP 20
FROM Person 
ORDER BY FirstName desc

-- selecting first 20% rows
SELECT TOP 20 percent
FROM Person 
ORDER BY FirstName desc

/*
Group BY tatement groups rows that have the same values into summary rows
The GROUP BY statement is often used with aggregate functions to group the result-set by one or more columns.
*/

SELECT City,Sum(Salary) as [Total Salary]
FROM person
GROUP BY City

-- using having to filter with groupby

SELECT City,Sum(Salary) as [Total Salary]
FROM person
GROUP BY City
HAVING City = 'Cairo'
