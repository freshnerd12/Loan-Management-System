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
