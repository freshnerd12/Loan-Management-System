
-- Create indexes on foreign keys and other fields for optimization 
CREATE INDEX idx_fk_member_id_loan ON Loans(Member_ID);
CREATE INDEX idx_fk_employee_id ON Loans(Employee_ID);
CREATE INDEX idx_fk_loan_number ON Transaction_History(Loan_Number);
CREATE INDEX idx_fk_branch_id ON Employees(Branch_ID);
CREATE INDEX idx_fk_member_id_phone ON Member_Phone(Member_ID);
CREATE INDEX idx_fk_amount ON Transaction_History(Amount);
CREATE INDEX idx_fk_first_name_members ON Members(First_Name);
CREATE INDEX idx_fk_first_name_employees ON Employees(First_Name);
