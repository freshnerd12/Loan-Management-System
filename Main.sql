-- Homework 2 : DDL Script Assignment Himadri Nath (hn5954)

--- DROP Section

ALTER TABLE Transaction_History DROP CONSTRAINT fk_loan_number;
ALTER TABLE Loans DROP CONSTRAINT fk_employee_id;
ALTER TABLE Loans DROP CONSTRAINT fk_member_id_loan;
ALTER TABLE Employees DROP CONSTRAINT fk_branch_id_employees;
ALTER TABLE Member_Phone DROP CONSTRAINT fk_member_id;
ALTER TABLE Member_Address_Link DROP CONSTRAINT fk_member_id_link;
ALTER TABLE Member_Address_Link DROP CONSTRAINT fk_address_id_link;
ALTER TABLE Member_Tax_ID DROP CONSTRAINT fk_member_tax_id;

-- Drop unique constraints 
ALTER TABLE Members DROP CONSTRAINT member_unique_email;
ALTER TABLE Member_Tax_ID DROP CONSTRAINT fk_tax_id;
ALTER TABLE Branch DROP CONSTRAINT branch_name_unique;

-- Drop indexes 
DROP INDEX idx_fk_member_id_loan;
DROP INDEX idx_fk_employee_id;
DROP INDEX idx_fk_loan_number;
DROP INDEX idx_fk_branch_id;
DROP INDEX idx_fk_member_id_phone;
DROP INDEX idx_fk_amount;
DROP INDEX idx_fk_first_name_members;
DROP INDEX idx_fk_first_name_employees;


-- Drop Tables 
DROP TABLE Member_Address_Link;
DROP TABLE Member_Tax_ID;
DROP TABLE Transaction_History;
DROP TABLE Loans;
DROP TABLE Employees;
DROP TABLE Branch;
DROP TABLE Member_Address;
DROP TABLE Member_Phone;
DROP TABLE Members;

-- Drop sequences 
DROP SEQUENCE transaction_id_seq;
DROP SEQUENCE employee_id_seq;
DROP SEQUENCE member_id_seq;
DROP SEQUENCE address_id_seq;
DROP SEQUENCE phone_id_seq;

--- CREATE TABLES and SEQUENCES 

-- Create sequences 
CREATE SEQUENCE member_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE transaction_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE employee_id_seq START WITH 90000 INCREMENT BY 1;
CREATE SEQUENCE address_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE phone_id_seq START WITH 1 INCREMENT BY 1;

-- Create Members Table 
CREATE TABLE Members (
Member_ID NUMBER(10, 0) DEFAULT member_id_seq.NEXTVAL PRIMARY KEY,
First_Name VARCHAR2(100),
Middle_Name VARCHAR2(100) NULL,
Last_Name VARCHAR2(100),
Email VARCHAR2(200) CONSTRAINT email_length_check CHECK (LENGTH(Email) >= 7),
CONSTRAINT member_unique_email UNIQUE (Email)
);

-- Create Member_Phone table 
CREATE TABLE Member_Phone (
Phone_ID NUMBER(10, 0) PRIMARY KEY,
Phone_Number CHAR(12),
Phone_Type VARCHAR2(10),
Member_ID NUMBER(10, 0),
CONSTRAINT fk_member_id FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID)
);

-- Create Member_Address Table
CREATE TABLE Member_Address (
Address_ID NUMBER PRIMARY KEY,
Address_1 VARCHAR(100),
Address_2 VARCHAR2(100) NULL,
City VARCHAR(100),
Member_State CHAR(2),
Zip_Code CHAR(5)
);

-- Create Branch table 
CREATE TABLE Branch (
Branch_ID NUMBER PRIMARY KEY,
Branch_Name VARCHAR2(100),
Address_1 VARCHAR2(100),
Address_2 VARCHAR2(100) NULL,
City VARCHAR2(100),
Branch_State CHAR(2),
Zip_Code CHAR(5),
CONSTRAINT branch_name_unique UNIQUE (Branch_Name)
);

-- Create Employees table 
CREATE TABLE Employees (
Employee_ID NUMBER DEFAULT employee_id_seq.NEXTVAL PRIMARY KEY,
Branch_ID NUMBER,
First_Name VARCHAR2(255),
Last_Name VARCHAR2(255),
Tax_ID_Number VARCHAR2(255),
Birthday DATE,
Mailing_Address VARCHAR2(255),
Mailing_City VARCHAR2(255),
Mailing_State CHAR(2),
Mailing_Zip CHAR(5),
Phone_Number CHAR(12),
Email VARCHAR2(255),
Emp_Level CHAR(1) CHECK (Emp_Level IN ('1', '2', '3', '4', '5')),
CONSTRAINT fk_branch_id_employees FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID)
);

-- Create Loans table 
CREATE TABLE Loans (
Loan_Number NUMBER PRIMARY KEY,
Member_ID NUMBER,
Loan_Type VARCHAR2(2),
Original_Amount NUMBER(10, 2),
Origination_Date DATE,
Num_of_Payments NUMBER,
Interest_Rate NUMBER(5, 3),
Payment_Amount NUMBER(10, 2),
Maturity_Date DATE,
Loan_Notes VARCHAR2(250) NULL,
Employee_ID NUMBER,
Loan_Status CHAR(1) CHECK (Loan_Status IN ('A', 'R', 'P', 'D', 'C')),
CONSTRAINT fk_member_id_loan FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
CONSTRAINT fk_employee_id FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID),
CONSTRAINT maturity_date_check CHECK (Maturity_Date >= Origination_Date)
);

-- Create Transaction_History table 
CREATE TABLE Transaction_History (
Transaction_ID NUMBER PRIMARY KEY,
Loan_Number NUMBER,
Transaction_Date DATE DEFAULT SYSDATE,
Amount NUMBER(10, 2),
Transaction_Description VARCHAR2(100),
Updated_Balance NUMBER(10, 2) CHECK (Updated_Balance >= 0),
CONSTRAINT fk_loan_number FOREIGN KEY (Loan_Number) REFERENCES Loans(Loan_Number)
);

-- Create Member_Tax_ID table 
CREATE TABLE Member_Tax_ID (
Member_ID NUMBER PRIMARY KEY,
Tax_ID CHAR(9),
CONSTRAINT fk_member_tax_id FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
CONSTRAINT fk_tax_id UNIQUE (Tax_ID)
);

-- Create Member_Address_Link table 
CREATE TABLE Member_Address_Link (
Member_ID NUMBER,
Address_ID NUMBER,
Address_Status CHAR(1),
CONSTRAINT pk_member_address_link PRIMARY KEY (Member_ID, Address_ID),
CONSTRAINT fk_member_id_link FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
CONSTRAINT fk_address_id_link FOREIGN KEY (Address_ID) REFERENCES Member_Address(Address_ID),
CONSTRAINT chk_address_status CHECK (Address_Status IN ('P', 'A', 'I', 'O'))
);

--- SEED DATA SECTION 

-- Insert data into Members table 
INSERT INTO Members (Member_ID, First_Name, Middle_Name, Last_Name, Email)
VALUES (member_id_seq.NEXTVAL, 'Himadri', 'M', 'Nath', 'himadrinath@utexas.edu');

COMMIT;


INSERT INTO Members (Member_ID, First_Name, Middle_Name, Last_Name, Email)
VALUES (member_id_seq.NEXTVAL, 'Nancy', 'Nine', 'Nickel', 'nancynine@utexas.edu');

COMMIT;


-- Insert data into Member_Address table 
-- Member 1 addresses 
INSERT INTO Member_Address (Address_ID, Address_1, Address_2, City, Member_State, Zip_Code)
VALUES (address_id_seq.NEXTVAL, '3020 Fairview Dr', 'Room 1', 'Grand Prairie', 'TX', '75052');

COMMIT;


INSERT INTO Member_Address (Address_ID, Address_1, Address_2, City, Member_State, Zip_Code)
VALUES (address_id_seq.NEXTVAL, '2300 Nueces St', 'Apt 420', 'Austin', 'TX', '78705');

COMMIT;


-- Member 2 addresses 
INSERT INTO Member_Address (Address_ID, Address_1, Address_2, City, Member_State, Zip_Code)
VALUES (address_id_seq.NEXTVAL, '3018 Fairview Dr', 'Room 2', 'Grand Prairie', 'TX', '75052');

COMMIT;


INSERT INTO Member_Address (Address_ID, Address_1, Address_2, City, Member_State, Zip_Code)
VALUES (address_id_seq.NEXTVAL, '2300 Nueces St', 'Apt 420', 'Austin', 'TX', '78705');

COMMIT;


-- Insert data into Member_Phone table (hn5954)
-- Member 1 phones 
INSERT INTO Member_Phone (Phone_ID, Phone_Number, Phone_Type, Member_ID)
VALUES (phone_id_seq.NEXTVAL, '817-846-8911', 'home', 1);

COMMIT;


INSERT INTO Member_Phone (Phone_ID, Phone_Number, Phone_Type, Member_ID)
VALUES (phone_id_seq.NEXTVAL, '899-877-8666', 'cell', 1);

COMMIT;


-- Member 2 phones 
INSERT INTO Member_Phone (Phone_ID, Phone_Number, Phone_Type, Member_ID)
VALUES (phone_id_seq.NEXTVAL, '122-133-1444', 'home', member_id_seq.CURRVAL);

COMMIT;


INSERT INTO Member_Phone (Phone_ID, Phone_Number, Phone_Type, Member_ID)
VALUES (phone_id_seq.NEXTVAL, '133-144-122', 'cell', member_id_seq.CURRVAL);

COMMIT;


-- Insert data into Branch table 
INSERT INTO Branch (Branch_ID, Branch_Name, Address_1, Address_2, City, Branch_State, Zip_Code)
VALUES (1, 'Pflugerville', '873 Oop St', 'Suite 100', 'Austin', 'TX', '78701');

COMMIT;


INSERT INTO Branch (Branch_ID, Branch_Name, Address_1, Address_2, City, Branch_State, Zip_Code)
VALUES (2, 'Central', '996 Oppers St', 'Suite 200', 'Austin', 'TX', '78703');

COMMIT;


-- Insert data into Employees table 
INSERT INTO Employees (Employee_ID, Branch_ID, First_Name, Last_Name, Tax_ID_Number, Birthday, Mailing_Address, Mailing_City, Mailing_State, Mailing_Zip, Phone_Number, Email, Emp_Level)
VALUES (employee_id_seq.NEXTVAL, 1, 'Jon', 'Doe', '876543210', TO_DATE('2003-01-15', 'YYYY-MM-DD'), '873 Oop St', 'Austin', 'TX', '78701', '111-111-1111', 'jondoe@pnc.com', '1');

COMMIT;


INSERT INTO Employees (Employee_ID, Branch_ID, First_Name, Last_Name, Tax_ID_Number, Birthday, Mailing_Address, Mailing_City, Mailing_State, Mailing_Zip, Phone_Number, Email, Emp_Level)
VALUES (employee_id_seq.NEXTVAL, 1, 'Jay', 'Raj', '567890123', TO_DATE('2003-03-20', 'YYYY-MM-DD'), '873 Oop St', 'Austin', 'TX', '78701', '222-222-2222', 'jayraj@pnc.com', '2');

COMMIT;


INSERT INTO Employees (Employee_ID, Branch_ID, First_Name, Last_Name, Tax_ID_Number, Birthday, Mailing_Address, Mailing_City, Mailing_State, Mailing_Zip, Phone_Number, Email, Emp_Level)
VALUES (employee_id_seq.NEXTVAL, 2, 'Krane', 'Kalls', '789012345', TO_DATE('2003-05-05', 'YYYY-MM-DD'), '996 Oppers St', 'Austin', 'TX', '78704', '555-123-1245', 'kranekalls@pnc.com', '3');

COMMIT;


INSERT INTO Employees (Employee_ID, Branch_ID, First_Name, Last_Name, Tax_ID_Number, Birthday, Mailing_Address, Mailing_City, Mailing_State, Mailing_Zip, Phone_Number, Email, Emp_Level)
VALUES (employee_id_seq.NEXTVAL, 2, 'Lee', 'Bruce', '345678901', TO_DATE('2002-07-20', 'YYYY-MM-DD'), '996 Oppers St', 'Austin', 'TX', '78704', '423-532-1252', 'leebruce@pnc.com', '4');

COMMIT;



-- Insert data into Loans table --
-- Member 1 loans 

INSERT INTO Loans (Loan_Number, Member_ID, Loan_Type, Original_Amount, Origination_Date, Num_of_Payments, Interest_Rate, Payment_Amount, Maturity_Date, Loan_Notes, Employee_ID, Loan_Status)
VALUES (1, 1, 'P', 10000.00, TO_DATE('2023-01-21', 'YYYY-MM-DD'), 12, 5.500, 925.88, TO_DATE('2023-12-21', 'YYYY-MM-DD'), 'Active Loan', 90000, 'P');

COMMIT;


-- Insert data into Transaction_History for the active loan 
-- Payment 1 
INSERT INTO Transaction_History (Transaction_ID, Loan_Number, Transaction_Date, Amount, Transaction_Description, Updated_Balance)
VALUES (transaction_id_seq.NEXTVAL, 1, TO_DATE('2023-01-21', 'YYYY-MM-DD'), 925.88, 'Payment 1', 10074.12);

COMMIT;


-- Payment 2 
INSERT INTO Transaction_History (Transaction_ID, Loan_Number, Transaction_Date, Amount, Transaction_Description, Updated_Balance)
VALUES (transaction_id_seq.NEXTVAL, 1, TO_DATE('2023-02-21', 'YYYY-MM-DD'), 925.88, 'Payment 2', 10000.24);

COMMIT;



INSERT INTO Loans (Loan_Number, Member_ID, Loan_Type, Original_Amount, Origination_Date, Num_of_Payments, Interest_Rate, Payment_Amount, Maturity_Date, Loan_Notes, Employee_ID, Loan_Status)
VALUES (2, 1, 'C', 5000.00, TO_DATE('2023-01-18', 'YYYY-MM-DD'), 5, 4.560, 852.00, TO_DATE('2023-06-18', 'YYYY-MM-DD'), 'Closed Loan', 90001, 'C');

COMMIT;


-- Member 2 loans 
INSERT INTO Loans (Loan_Number, Member_ID, Loan_Type, Original_Amount, Origination_Date, Num_of_Payments, Interest_Rate, Payment_Amount, Maturity_Date, Loan_Notes, Employee_ID, Loan_Status)
VALUES (3, 2, 'D', 8000.00, TO_DATE('2023-03-10', 'YYYY-MM-DD'), 8, 6.000, 1032.50, TO_DATE('2023-11-10', 'YYYY-MM-DD'), 'Delinquent Loan', 90002, 'D');

COMMIT;


INSERT INTO Loans (Loan_Number, Member_ID, Loan_Type, Original_Amount, Origination_Date, Num_of_Payments, Interest_Rate, Payment_Amount, Maturity_Date, Loan_Notes, Employee_ID, Loan_Status)
VALUES (4, 2, 'R', 7500.00, TO_DATE('2023-04-20', 'YYYY-MM-DD'), 9, 4.750, 847.50, TO_DATE('2023-12-20', 'YYYY-MM-DD'), 'Rejected Loan', 90003, 'R');

COMMIT;





-- Create indexes on foreign keys and other fields for optimization 
CREATE INDEX idx_fk_member_id_loan ON Loans(Member_ID);
CREATE INDEX idx_fk_employee_id ON Loans(Employee_ID);
CREATE INDEX idx_fk_loan_number ON Transaction_History(Loan_Number);
CREATE INDEX idx_fk_branch_id ON Employees(Branch_ID);
CREATE INDEX idx_fk_member_id_phone ON Member_Phone(Member_ID);
CREATE INDEX idx_fk_amount ON Transaction_History(Amount);
CREATE INDEX idx_fk_first_name_members ON Members(First_Name);
CREATE INDEX idx_fk_first_name_employees ON Employees(First_Name);


