CREATE DEFINER=`metauser`@`%` PROCEDURE `UpdateBooking`(p_BookingID int,p_BookingDate DATE)
BEGIN

UPDATE Bookings SET Date = (DATE(p_BookingDate)) WHERE BookingID = p_BookingID ;
SELECT CONCAT('Booking ',p_BookingID,' updated') AS 'Confirmation';
END