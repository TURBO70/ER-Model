-- Create Tables
CREATE TABLE Department (
    DepartmentID SERIAL PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

CREATE TABLE Manager (
    ManagerID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DepartmentID INT REFERENCES Department(DepartmentID)
);

CREATE TABLE Employee (
    EmployeeID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Position VARCHAR(100),
    DepartmentID INT REFERENCES Department(DepartmentID),
    ManagerID INT REFERENCES Manager(ManagerID)
);

CREATE TABLE Client (
    ClientID SERIAL PRIMARY KEY,
    ClientName VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(100)
);

CREATE TABLE Project (
    ProjectID SERIAL PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    ClientID INT REFERENCES Client(ClientID)
);

CREATE TABLE Assignment (
    AssignmentID SERIAL PRIMARY KEY,
    EmployeeID INT REFERENCES Employee(EmployeeID),
    ProjectID INT REFERENCES Project(ProjectID),
    HoursWorked INT
);

-- Insert Dummy Data into Department
INSERT INTO Department (DepartmentName, Location) VALUES
('Sales', 'New York'),
('HR', 'Los Angeles'),
('IT', 'San Francisco'),
('Finance', 'Chicago'),
('Marketing', 'Miami'),
('Operations', 'Dallas'),
('R&D', 'Seattle'),
('Support', 'Boston'),
('Legal', 'Washington DC'),
('Admin', 'Austin');

-- Insert Dummy Data into Manager
INSERT INTO Manager (Name, DepartmentID) VALUES
('Alice Johnson', 1),
('Bob Smith', 2),
('Charlie Brown', 3),
('David Wilson', 4),
('Eva Green', 5),
('Frank White', 6),
('Grace Lee', 7),
('Henry Brown', 8),
('Ivy Davis', 9),
('Jack Miller', 10);

-- Insert Dummy Data into Employee
INSERT INTO Employee (Name, Position, DepartmentID, ManagerID) VALUES
('John Doe', 'Sales Associate', 1, 1),
('Jane Smith', 'HR Specialist', 2, 2),
('Mike Johnson', 'Software Engineer', 3, 3),
('Sarah Lee', 'Financial Analyst', 4, 4),
('Chris Brown', 'Marketing Manager', 5, 5),
('Emily Davis', 'Operations Manager', 6, 6),
('Daniel Wilson', 'Researcher', 7, 7),
('Laura White', 'Support Specialist', 8, 8),
('Kevin Green', 'Legal Advisor', 9, 9),
('Olivia Taylor', 'Admin Assistant', 10, 10);

-- Insert Dummy Data into Client
INSERT INTO Client (ClientName, ContactInfo) VALUES
('ABC Corp', 'abc@example.com'),
('XYZ Inc', 'xyz@example.com'),
('Tech Solutions', 'tech@example.com'),
('Global Finance', 'finance@example.com'),
('Creative Agency', 'creative@example.com'),
('Health Plus', 'health@example.com'),
('EduTech', 'edu@example.com'),
('Green Energy', 'green@example.com'),
('Foodies', 'food@example.com'),
('Travel World', 'travel@example.com');

-- Insert Dummy Data into Project
INSERT INTO Project (ProjectName, StartDate, EndDate, ClientID) VALUES
('Sales Campaign', '2023-01-01', '2023-06-30', 1),
('HR System Upgrade', '2023-02-01', '2023-08-31', 2),
('IT Infrastructure', '2023-03-01', '2023-09-30', 3),
('Financial Audit', '2023-04-01', '2023-10-31', 4),
('Marketing Strategy', '2023-05-01', '2023-11-30', 5),
('Operations Optimization', '2023-06-01', '2023-12-31', 6),
('R&D Innovation', '2023-07-01', '2024-01-31', 7),
('Support Portal', '2023-08-01', '2024-02-28', 8),
('Legal Compliance', '2023-09-01', '2024-03-31', 9),
('Admin Automation', '2023-10-01', '2024-04-30', 10);

-- Insert Dummy Data into Assignment
INSERT INTO Assignment (EmployeeID, ProjectID, HoursWorked) VALUES
(1, 1, 40),
(2, 2, 35),
(3, 3, 50),
(4, 4, 45),
(5, 5, 30),
(6, 6, 55),
(7, 7, 60),
(8, 8, 25),
(9, 9, 40),
(10, 10, 20);

--SQL queries

--1. Count Employees in Each Department:
SELECT Department.DepartmentName, COUNT(Employee.EmployeeID) AS EmployeeCount
FROM Department
JOIN Employee ON Department.DepartmentID = Employee.DepartmentID
GROUP BY Department.DepartmentName;

--2. Total Hours Worked on Each Project:
SELECT Project.ProjectName, SUM(Assignment.HoursWorked) AS TotalHours
FROM Project
JOIN Assignment ON Project.ProjectID = Assignment.ProjectID
GROUP BY Project.ProjectName;

--3. Number of Projects per Client:
SELECT Client.ClientName,  COUNT(Project.ProjectID) AS ProjectCount
FROM Client
JOIN Project ON Client.ClientID = Project.ClientID
GROUP BY Client.ClientName;

--4.4. Average Hours Worked by Employees:
SELECT Employee.Name, AVG(Assignment.HoursWorked) AS AvgHoursWorked
FROM Employee
JOIN Assignment ON Employee.EmployeeID = Assignment.EmployeeID
GROUP BY Employee.Name;

--5.Employees and Their Managers:
SELECT Employee.Name AS EmployeeName, Manager.Name AS ManagerName
FROM Employee
JOIN Manager ON Employee.ManagerID = Manager.ManagerID;
