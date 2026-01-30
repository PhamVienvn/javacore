DELIMITER $$
CREATE PROCEDURE procedure_not_param()
	BEGIN
		SELECT * from Account;
        select * from department;
	END $$
DELIMITER ;
CALL procedure_not_param(); # Sử dụng hàm vừa tạo
DROP PROCEDURE IF EXISTS procedure_not_param; -- xóa
---------------------------------------------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE procedure_param_input(IN account_id int)
BEGIN
   SELECT * from Account A
   WHERE A.accountID = account_id;
END $$
DELIMITER ;


CALL procedure_param_input(1)
;
--  (muốn gọi 2 accountID thì phần trên phải khai báo 2 biển account_id_1  int, account_id_2 int) xem 22:03 trong video 

DROP PROCEDURE IF EXISTS procedure_param_input;  -- xóa

----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE procedure_param_output(OUT count_account int)
BEGIN
   SELECT COUNT(*) INTO count_account from Account;
END $$
DELIMITER ;

# tạo 1 biến
set @count_account_var = 1;

# Gọi câu lệnh store
CALL procedure_param_output( @count_account_var);
# Kiểm tra lại giá trị của biến
SELECT @count_account_var;

----------------------------------------------------------------------------------------
--  insert dữ liệu vào bảng account
-- trả về danh sách account mới nhất 
-- lưu trữ , update lại biến count_account_var
DELIMITER $$
CREATE PROCEDURE insert_acc_st(IN var_email varchar(100), IN var_userName(100), IN var_fullName varchar(100),
IN var_departmentID int, IN var_PostionID int, 
Out count_account int
) 
--  (xem record 22:31)-------------------------------------------------------------------

BEGIN
   -- SELECT COUNT(*) INTO count_account from Account;
   insert into `Account`(email, userName, fullName, DepartmentID, PostionID, CreateDate)
Values (var_email, var_userName, var_fullName, var_DepartmentID, var_PostionID, now());


   
END $$
DELIMITER ;

-- *************************************************************************************************************************************

SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER $$
CREATE FUNCTION calculateTotalPrice(quantity INT, unitPrice DECIMAL(10,2))    
-- DECIMAL(10,2) kiểu số thực 10 chữ số, tối đa 2 số sau dấu phẩy


   RETURNS DECIMAL(10,2)   --  10 phần nguyển và hai phần thâp phân
   
BEGIN
   DECLARE totalPrice DECIMAL(10,2); # Tạo 1 biến để trả về
   SET totalPrice = quantity * unitPrice; # Câu lệnh SQL để gán giá trị cho biến vừa tạo
   RETURN totalPrice;
END $$
DELIMITER ;


# Gọi hàm
SELECT calculateTotalPrice(2, 2.2)

# xóa hàm
DROP FUNCTION IF EXISTS calculateTotalPrice;



