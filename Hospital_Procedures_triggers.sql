-- ✅ Stored Procedure: Calculate Total Bill for an Appointment
DELIMITER $$

CREATE PROCEDURE CalculateTotalBill(IN app_id INT)
BEGIN
    DECLARE total_cost INT;
    
    SELECT SUM(total_amount) INTO total_cost
    FROM Billing
    WHERE appointment_id = app_id;
    
    SELECT total_cost AS Total_Bill;
END $$

DELIMITER ;

-- 📌 Usage: CALL CalculateTotalBill(1);

-- ✅ Stored Procedure: Get Patient's Medical History
DELIMITER $$

CREATE PROCEDURE GetPatientHistory(IN pat_id INT)
BEGIN
    SELECT * FROM Medical_report WHERE patient_id = pat_id;
END $$

DELIMITER ;

-- 📌 Usage: CALL GetPatientHistory(2);

-- ✅ Trigger: Automatically Update Room Status After Patient Discharge
DELIMITER $$

CREATE TRIGGER UpdateRoomStatus
AFTER UPDATE ON Room_assignments
FOR EACH ROW
BEGIN
    IF NEW.end_date IS NOT NULL THEN
        UPDATE Rooms 
        SET status = 'Available'
        WHERE room_id = NEW.room_id;
    END IF;
END $$

DELIMITER ;

-- ✅ Trigger: Prevent Negative Stock in Pharmacy
DELIMITER $$

CREATE TRIGGER PreventNegativeStock
BEFORE UPDATE ON Medicine
FOR EACH ROW
BEGIN
    IF NEW.stock < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock cannot be negative';
    END IF;
END $$

DELIMITER ;
