CREATE DEFINER=`metauser`@`%` PROCEDURE `CheckBooking`(p_BookingDate DATE, p_TableNumber INT)
BEGIN
DECLARE v_bookingstatus VARCHAR(100);

    -- Check if the table is booked on the specified date
SELECT 
    CASE
        WHEN
            EXISTS( SELECT 
                    1
                FROM
                    Bookings
                WHERE
                    Date = DATE(p_BookingDate)
                        AND TableNumber = p_TableNumber)
        THEN
            CONCAT('Table ',
                    p_TableNumber,
                    ' is already booked')
        ELSE CONCAT('Table', p_TableNumber, 'is available')
    END
INTO v_bookingstatus;

    -- Return the booking status
SELECT v_bookingstatus AS BookingStatus;




END