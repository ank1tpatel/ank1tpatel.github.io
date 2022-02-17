use gpurple1_database;

Drop Table Franchisees;
Drop Table Suppliers;
Drop Table Staff;
Drop Table Orders;
Drop Table Customers;
Drop Table Location;

CREATE TABLE Location(
LocationNo  INT(10) NOT NULL, 
Address VARCHAR (25),
City VARCHAR(25),
State VARCHAR(100),
PRIMARY KEY (LocationNo)
);
CREATE TABLE Customers(
CustNo INT(10) NOT NULL, 
CustFirst VARCHAR (25),
CustLast VARCHAR(25),
LocationNo INT (10),
PRIMARY KEY (CustNo),
Foreign Key (LocationNo)
References Location(LocationNo)
);
CREATE TABLE Orders(
OrderNo INT(10) NOT NULL, 
Calories INT(25),
ProteinType VARCHAR(25),
NumberVeggies VARCHAR(100),
NumberSauces VARCHAR(100),
OrderDate DATE,
OrderPrice Float(10),
CustNo INT(10),
LocationNo INT(10),
PRIMARY KEY (OrderNo),
Foreign Key (CustNo)
References Customers(CustNo),
FOREIGN KEY (LocationNo)
REFERENCES Location(LocationNo)
);
CREATE TABLE Staff(
StaffNo INT(10) NOT NULL, 
StaffFirst VARCHAR (25),
StaffLast VARCHAR(25),
Title VARCHAR(100),
Salary VARCHAR(100),
LocationNo INT(10), 
INDEX pard_ind(LocationNo),
PRIMARY KEY (StaffNo),
FOREIGN KEY (LocationNo)
REFERENCES location(LocationNo)
);
CREATE TABLE Franchisees(
FranchNo INT(10) NOT NULL, 
FranchFirst VARCHAR (25),
FranchLast VARCHAR(25),
HomeTown VARCHAR(35),
PRIMARY KEY (FranchNo)
);
CREATE TABLE Suppliers(
SupplierID INT(10) NOT NULL, 
SupplierCity VARCHAR (25),
SupplierType VARCHAR(100),
TransactionDate DATE,
DeliveryDate DATE,
PRIMARY KEY (SupplierID)
);

INSERT INTO Location (LocationNo, Address, City, State)
VALUES ('0001', '400 Poydras St', 'New Orleans', 'LA'),
('0002', '2328 25th Ave', 'Gulfport', 'MS'),
('0003', '4415 Skyland Blvd E', 'Tuscaloosa', 'AL'),
('0004', '1251 Airport Rd', 'Destin', 'FL'),
('0005', '183 Edgewood Ave NE', 'Atlanta', 'GA'),
('0006', '127 W State St', 'Baton Rouge', 'LA'),
('0007', '425 W Capitol Ave', 'Little Rock', 'AR'),
('0008', '4321 N State St', 'Jackson', 'MS'),
('0009', '1302 Elm St', 'Dallas', 'TX'),
('0010', '2270 Holcombe Blvd', 'Houston', 'TX');

INSERT INTO Customers (CustNo, CustFirst, CustLast, LocationNo)
VALUES ('0001', 'Alexander', 'Muir', '3'),
('0002', 'Maksim', 'Gale', '5'),
('0003', 'Jaspal', 'Black', '7'),
('0004', 'Riley-Jay', 'Tanner', '3'),
('0005', 'Antoni', 'Gaines', '4'),
('0006', 'Jeanette', 'Grimes', '9'),
('0007', 'Phillipa', 'Neville', '4'),
('0008', 'Ahsan', 'Oneil', '9'),
('0009', 'Eadie', 'Knox', '3'),
('0010', 'Ivie', 'Parsons', '8'),
('0011', 'Buster', 'Hancock', '1'),
('0012', 'Zakariya', 'Enriquez', '4'),
('0013', 'Lily-Grace', 'Guzman', '9'),
('0014', 'Jo', 'Ruiz', '9'),
('0015', 'Aliyah', 'Emery', '5'),
('0016', 'Ali', 'Dickson', '3'),
('0017', 'Jaxx', 'Hoffman', '2'),
('0018', 'Nyle', 'Ashley', '8'),
('0019', 'Roseanne', 'Barber', '8'),
('0020', 'Amaya', 'Churchill', '3'),
('0021', 'Jayden-Lee', 'Braun', '4'),
('0022', 'Koby', 'Chapman', '2'),
('0023', 'Justin', 'Burris', '9'),
('0024', 'Eshaal', 'Reed', '9'),
('0025', 'Adeline', 'Burrows', '1'),
('0026', 'Cormac', 'Amin', '3'),
('0027', 'Tasnim', 'Gardner', '4'),
('0028', 'Bryson', 'Marquez', '1'),
('0029', 'Hamza', 'Christensen', '5'),
('0030', 'Nyla', 'Carty', '3'),
('0031', 'Awais', 'Lewis', '3'),
('0032', 'Naya', 'Rayner', '8'),
('0033', 'Bertha', 'Keith', '3'),
('0034', 'Cecil', 'Bruce', '2'),
('0035', 'Ewan', 'Bowen', '8'),
('0036', 'Emir', 'Lane', '7'),
('0037', 'Brandon-Lee', 'Connelly', '6'),
('0038', 'Hywel', 'Mcclain', '9'),
('0039', 'Shani', 'Bowden', '5'),
('0040', 'Taio', 'Donnelly', '3'),
('0041', 'Aaliya', 'Wilde', '10'),
('0042', 'Asmaa', 'Browning', '2'),
('0043', 'Isadora', 'Holder', '10'),
('0044', 'Jarrod', 'Weston', '7'),
('0045', 'Teodor', 'Gonzales', '5'),
('0046', 'Zac', 'Calvert', '6'),
('0047', 'Roza', 'Davis', '1'),
('0048', 'Fahad', 'Smith', '3'),
('0049', 'Phillippa', 'Fenton', '2'),
('0050', 'Chance', 'Joyner', '6');

INSERT INTO Orders (OrderNo, Calories, ProteinType, NumberVeggies, NumberSauces, OrderDate, OrderPrice, CustNo, LocationNo)
VALUES ('1', '772', 'Ham', '10','0','2021-11-25', '9.51', '0008', '03'),
('2', '646', 'Steak', '8','2','2022-08-04', '8.6', '0033', '07'),
('3', '691', 'Tuna', '2','4','2021-10-22', '11.14', '0028', '05'),
('4', '651', 'Steak', '5','2','2021-11-02', '8.74', '0014', '04'),
('5', '930', 'Tuna', '4','2','2022-02-28', '10.09', '0037', '05'),
('6', '637', 'Turkey', '1','2','2022-06-14', '12.26', '0035', '10'),
('7', '902', 'Ham', '9','2','2022-08-29', '10.59', '0001', '01'),
('8', '639', 'Chicken', '10','6','2022-02-01', '7.61', '0012', '02'),
('9', '672', 'Steak', '9','5','2022-01-18', '12.42', '0032', '09'),
('10', '533', 'Meatballs', '0','7','2021-12-04', '12.01', '0041', '07'),
('11', '707', 'Ham', '5','1','2022-04-13', '10.63', '0021', '07'),
('12', '606', 'Turkey', '4','2','2022-07-06', '12.82', '0046', '05'),
('13', '593', 'Bacon', '1','1','2022-10-31', '11.02', '0050', '09'),
('14', '919', 'Turkey', '10','4','2022-02-02', '10.96', '0024', '05'),
('15', '923', 'Chicken', '10','2','2021-10-01', '12.95', '0045', '09'),
('16', '854', 'Tuna', '7','3','2022-06-15', '12.95', '0020', '02'),
('17', '916', 'Steak', '9','3','2021-12-21', '11.8', '0034', '09'),
('18', '535', 'Bacon', '5','3','2021-10-10', '8.09', '0013', '08'),
('19', '939', 'Bacon', '4','5','2022-09-30', '7.72', '0027', '05'),
('20', '705', 'Tuna', '6','4','2021-11-09', '13.48', '0003', '08'),
('21', '704', 'Turkey', '3','0','2022-11-08', '12.42', '0040', '08'),
('22', '500', 'Tuna', '1','6','2022-04-16', '7.61', '0044', '04'),
('23', '955', 'Bacon', '10','7','2021-11-05', '8.09', '0047', '09'),
('24', '968', 'Meatballs', '2','1','2022-08-22', '12.42', '0002', '08'),
('25', '597', 'Meatballs', '8','4','2021-10-14', '10.63', '0005', '05'),
('26', '599', 'Ham', '4','1','2021-12-13', '7.72', '0048', '05'),
('27', '782', 'Meatballs', '8','1','2022-02-26', '11.8', '0011', '06'),
('28', '572', 'Meatballs', '9','5','2022-01-25', '9.51', '0004', '06'),
('29', '528', 'Steak', '10','8','2022-07-09', '10.5', '0038', '10'),
('30', '957', 'Ham', '2','4','2022-06-07', '8.25', '0025', '03'),
('31', '505', 'Turkey', '8','8','2022-05-03', '12.2', '0042', '05'),
('32', '796', 'Chicken', '7','1','2022-01-04', '7.72', '0009', '07'),
('33', '618', 'Bacon', '6','5','2021-10-03', '0', '0029', '07'),
('34', '584', 'Bacon', '3','5','2022-06-19', '8.25', '0026', '08'),
('35', '738', 'Turkey', '6','5','2022-11-10', '8.09', '0010', '06'),
('36', '837', 'Bacon', '1','1','2022-06-01', '7.72', '0006', '03'),
('37', '584', 'Ham', '3','2','2022-08-26', '0', '0039', '10'),
('38', '966', 'Meatballs', '8','7','2021-11-14', '9.51', '0019', '02'),
('39', '873', 'Chicken', '10','1','2022-02-18', '11.8', '0036', '07'),
('40', '733', 'Tuna', '7','5','2021-12-07', '10.96', '0017', '04'),
('41', '824', 'Tuna', '3','7','2022-05-27', '8.6', '0049', '01'),
('42', '813', 'Meatballs', '5','2','2022-10-11', '11.14', '0022', '05'),
('43', '988', 'Chicken', '3','3','2022-05-13', '8.25', '0031', '02'),
('44', '950', 'Turkey', '8','0','2022-01-21', '8.25', '0030', '10'),
('45', '972', 'Ham', '3','3','2021-12-23', '10.44', '0043', '01'),
('46', '751', 'Chicken', '1','3','2022-08-08', '10.96', '0018', '10'),
('47', '678', 'Chicken', '10','7','2021-11-04', '0', '0016', '10'),
('48', '543', 'Steak', '3','7','2022-10-08', '7.72', '0015', '01'),
('49', '891', 'Steak', '7','8','2022-05-23', '11.8', '0007', '09'),
('50', '930', 'Tuna', '8','8','2022-01-09', '8.25', '0023', '02');

INSERT INTO staff (StaffNo, StaffFirst, StaffLast, Title, Salary, LocationNo)
VALUES ('3566', 'Andrew', 'Cameron', 'Manager', '8503', '4'),
('3229', 'Tess', 'Perkins', 'Assistant Manager', '1892', '3'),
('3246', 'Hailey', 'Stewart', 'Worker', '4585', '10'),
('3244', 'Spike', 'Ellis', 'Worker', '1091', '5'),
('3808', 'Maddie', 'Howard', 'Worker', '3635', '7'),
('3818', 'Carlos', 'Dixon', 'Worker', '8716', '6'),
('3439', 'Lucy', 'Warren', 'Cashier', '4708', '1'),
('3645', 'Arnold', 'Taylor', 'Cashier', '6554','9'),
('3822', 'Frederick', 'Williams', 'Cashier', '762', '2'),
('3532', 'Audrey', 'Morris', 'Janitor', '8323', '8');

INSERT INTO franchisees (FranchNo,FranchFirst,FranchLast,HomeTown)
VALUES ('0001', 'Antonio', 'Jensen','New Orleans'),('0002', 'Janet', 'Mills','Dallas'),('0003', 'Francis', 'Stephens','Los Angeles'),('0004', 'Juanita', 'Fuller','Buffalo'),('0005', 'Allan', 'Osborne',null);

INSERT INTO Suppliers (SupplierID,SupplierCity,SupplierType,TransactionDate,DeliveryDate)
VALUES ('2508', 'Baltimore', 'Proteins','2021-01-25','2021-01-30'),
('6701', 'Santa Ana', 'Condiments','2021-02-02','2021-02-05'),
('8863', 'North Hempstead', 'Veggies','2021-03-18','2021-03-22'),
('8788', 'Chandler', 'Disposables','2021-03-31','2021-04-10'),
('757', 'Greensboro', 'Disposables','2021-04-26','2021-04-30'),
('4511', 'Houston', 'Condiments','2021-05-14','2021-05-17'),
('5416', 'New Orleans', 'Veggies','2021-07-12','2021-07-14'),
('9620', 'Cleveland', 'Proteins','2021-08-06','2021-08-10'),
('3756', 'Sacramento', 'Condiments','2021-08-26','2021-08-29'),
('5606', 'Reno', 'Proteins','2021-10-14','2021-10-16');

-- 1. How many different types of positions are available.  
  SELECT count(DISTINCT title) as PositionsAvailiable
  FROM Staff;
 
 -- 2. How many job titles have the word Manager in them.
 SELECT * FROM staff
 WHERE title LIKE'%Manager%'
 ORDER BY staffLast;

-- 3. What is the sum of all the cashiers salaries? 
  SELECT sum(Salary) as CashiersSalaryTotal
  FROM staff
  WHERE title = 'Cashier';

-- 4. Find the customers and their order having more than five veggies 
  SELECT o.CustNo, c.CustFirst, C.CustLast, o.OrderNo, o.NumberVeggies 
  FROM Orders o, Customers c
  WHERE NumberVeggies > 5
  AND c.CustNo = o.CustNo;

--  5. In descending order, report the orders where the calories for each meal are greater than the average of all the recorded calories.  
  SELECT Calories, OrderNo
  FROM orders 
  WHERE Calories > (SELECT AVG(Calories) FROM orders)
  ORDER BY Calories DESC;

-- 6. Find all information for franchisees without a hometown. 
  SELECT * FROM Franchisees
  WHERE HomeTown is null;

-- 7. Report the location of restaurants not in the state of Louisiana in order of location number. 
  SELECT locationNo, City, State
  FROM location
  WHERE State NOT IN ('LA')
  ORDER BY LocationNo;


-- 8. Which orders were delivered within four days?
  SELECT SupplierID, TransactionDate, DeliveryDate, (DeliveryDate - TransactionDate) AS DelTime
  FROM Suppliers
  WHERE (DeliveryDate - TransactionDate) < 4 
  ORDER BY DelTime;

-- 9. For each location with more than five orders, find the number of orders in each location and average number of sauces.
  SELECT locationNo, COUNT(OrderNo) as NumberOfOrders, ROUND(AVG(NumberSauces)) AS AvgSauces
  FROM Orders 
  GROUP BY LocationNo
  HAVING COUNT(OrderNo) > 5
  ORDER BY LocationNo;

-- 10. List all cities and state that have both a franchisee's hometown and a location, as well as the franchisee's name.
  SELECT f.FranchFirst, f.FranchLast, f.HomeTown, l.locationNo, l.city, l.state
  FROM franchisees f, location l
  WHERE f.HomeTown = l.city AND l.city IN
  (SELECT city 
  FROM Location);

-- 11. Find all data from refunded orders(Price = 0) within the month of October 2021?
  SELECT *
  FROM orders
  WHERE orderprice = 0
  AND OrderDate like '%2021-10-%';

-- 12. How many different types of suppliers are there?
  SELECT COUNT(DISTINCT SupplierType) AS SupplierTypesTotal
  FROM suppliers;









