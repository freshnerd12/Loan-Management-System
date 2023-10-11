--- CREATE TABLES and SEQUENCES 

-- Create sequences (hn5954)
CREATE SEQUENCE member_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE transaction_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE employee_id_seq START WITH 90000 INCREMENT BY 1;
CREATE SEQUENCE address_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE phone_id_seq START WITH 1 INCREMENT BY 1;

-- Create Members Table (hn5954)
CREATE TABLE Members (
Member_ID NUMBER(10, 0) DEFAULT member_id_seq.NEXTVAL PRIMARY KEY,
First_Name VARCHAR2(100),
Middle_Name VARCHAR2(100) NULL,
Last_Name VARCHAR2(100),
Email VARCHAR2(200) CONSTRAINT email_length_check CHECK (LENGTH(Email) >= 7),
CONSTRAINT member_unique_email UNIQUE (Email)
);

-- Create Member_Phone table (hn5954)
CREATE TABLE Member_Phone (
Phone_ID NUMBER(10, 0) PRIMARY KEY,
Phone_Number CHAR(12),
Phone_Type VARCHAR2(10),
Member_ID NUMBER(10, 0),
CONSTRAINT fk_member_id FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID)
);

-- Create Member_Address Table (hn5954)
CREATE TABLE Member_Address (
Address_ID NUMBER PRIMARY KEY,
Address_1 VARCHAR(100),
Address_2 VARCHAR2(100) NULL,
City VARCHAR(100),
Member_State CHAR(2),
Zip_Code CHAR(5)
);

-- Create Branch table (hn5954)
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

-- Create Employees table (hn5954)
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

-- Create Loans table (hn5954)
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

-- Create Transaction_History table (hn5954)
CREATE TABLE Transaction_History (
Transaction_ID NUMBER PRIMARY KEY,
Loan_Number NUMBER,
Transaction_Date DATE DEFAULT SYSDATE,
Amount NUMBER(10, 2),
Transaction_Description VARCHAR2(100),
Updated_Balance NUMBER(10, 2) CHECK (Updated_Balance >= 0),
CONSTRAINT fk_loan_number FOREIGN KEY (Loan_Number) REFERENCES Loans(Loan_Number)
);

-- Create Member_Tax_ID table (hn5954)
CREATE TABLE Member_Tax_ID (
Member_ID NUMBER PRIMARY KEY,
Tax_ID CHAR(9),
CONSTRAINT fk_member_tax_id FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
CONSTRAINT fk_tax_id UNIQUE (Tax_ID)
);

-- Create Member_Address_Link table (hn5954)
CREATE TABLE Member_Address_Link (
Member_ID NUMBER,
Address_ID NUMBER,
Address_Status CHAR(1),
CONSTRAINT pk_member_address_link PRIMARY KEY (Member_ID, Address_ID),
CONSTRAINT fk_member_id_link FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
CONSTRAINT fk_address_id_link FOREIGN KEY (Address_ID) REFERENCES Member_Address(Address_ID),
CONSTRAINT chk_address_status CHECK (Address_Status IN ('P', 'A', 'I', 'O'))
);
