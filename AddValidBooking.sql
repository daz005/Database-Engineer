CREATE DEFINER=`metauser`@`%` PROCEDURE `AddValidBooking`(p_BookingDate DATE, p_TableNumber int)
BEGIN

DECLARE v_tablestatus INT;

    -- Start the transaction
    START TRANSACTION;

    -- Check if the table is already booked on the specified date
    SELECT COUNT(*)
    INTO v_tablestatus
    FROM Bookings
    WHERE Date = DATE(p_BookingDate) AND TableNumber = p_TableNumber;

    -- Insert a new booking record if the table is available
    IF v_tablestatus = 0 THEN
        INSERT INTO Bookings (Date, TableNumber)
        VALUES (p_BookingDate, p_TableNumber);

        -- Commit the transaction if the insert is successful
        COMMIT;
        SELECT CONCAT('Table ',p_TableNumber,' - Booking added successfully for ',p_BookingDate) AS 'Booking Status';
    ELSE
        -- Rollback the transaction if the table is already booked
        ROLLBACK;
        SELECT CONCAT('Table ',p_TableNumber, ' is already booked - booking cancelled') AS 'Booking Status';
    END IF;

END