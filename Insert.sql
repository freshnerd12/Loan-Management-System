--- SEED DATA SECTION

-- Insert data into Members table
INSERT INTO Members (Member_ID, First_Name, Middle_Name, Last_Name, Email)
VALUES (member_id_seq.NEXTVAL, 'Himadri', 'M', 'Nath', 'himadrinath@utexas.edu');

COMMIT;


INSERT INTO Members (Member_ID, First_Name, Middle_Name, Last_Name, Email)
VALUES (member_id_seq.NEXTVAL, 'Nancy', 'Nine', 'Nickel', 'nancynine@utexas.edu');

COMMIT;


-- Insert data into Member_Address table 
-- Member 1 addresses (hn5954)
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


-- Insert data into Member_Phone table 
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
