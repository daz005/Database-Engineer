-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondb` DEFAULT CHARACTER SET utf8mb3 ;
USE `littlelemondb` ;

-- -----------------------------------------------------
-- Table `littlelemondb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`customers` (
  `CustomerID` INT NOT NULL,
  `FirstName` VARCHAR(100) NOT NULL,
  `LastName` VARCHAR(100) NOT NULL,
  `PhoneNumber` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menuitems` (
  `MenuItemID` INT NOT NULL,
  `ItemName` VARCHAR(45) NOT NULL,
  `ItemPrice` DECIMAL(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menu` (
  `MenuID` INT NOT NULL,
  `Cuisine` VARCHAR(100) NOT NULL,
  `Starter` VARCHAR(100) NOT NULL,
  `Course` VARCHAR(100) NOT NULL,
  `Drinks` VARCHAR(100) NOT NULL,
  `Desserts` VARCHAR(100) NOT NULL,
  `MenuItemID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `menu_menuitem_fk_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `menu_menuitem_fk`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `littlelemondb`.`menuitems` (`MenuItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NOT NULL,
  `OrderQuantity` INT NOT NULL,
  `OrderType` VARCHAR(55) NULL DEFAULT NULL,
  `TotalCost` DECIMAL(10,2) NULL DEFAULT NULL,
  `MenuID` INT NULL DEFAULT NULL,
  `MenuItemID` INT NULL DEFAULT NULL,
  `CustomerID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `orders_menu_fk_idx` (`MenuID` ASC) VISIBLE,
  INDEX `orders_menuitems_fk_idx` (`MenuItemID` ASC) VISIBLE,
  INDEX `orders_customers_fk` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `orders_customers_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemondb`.`customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `orders_menu_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemondb`.`menu` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `orders_menuitems_fk`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `littlelemondb`.`menuitems` (`MenuItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`staff` (
  `StaffID` INT NOT NULL,
  `FirstName` VARCHAR(100) NOT NULL,
  `LastName` VARCHAR(100) NOT NULL,
  `Role` VARCHAR(100) NOT NULL,
  `salary` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NOT NULL,
  `TableNumber` INT NOT NULL,
  `CustomerID` INT NULL DEFAULT NULL,
  `OrderID` INT NULL DEFAULT NULL,
  `StaffID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `bookings_customers_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `bookings_orders_fk_idx` (`OrderID` ASC) VISIBLE,
  INDEX `bookings_staff_fk_idx` (`StaffID` ASC) VISIBLE,
  CONSTRAINT `bookings_customers_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemondb`.`customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `bookings_orders_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `littlelemondb`.`orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `bookings_staff_fk`
    FOREIGN KEY (`StaffID`)
    REFERENCES `littlelemondb`.`staff` (`StaffID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orderdelivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orderdelivery` (
  `OrderDeliveryID` INT NOT NULL,
  `OrderDeliveryDate` DATE NULL DEFAULT NULL,
  `OrderDeliveryStatus` VARCHAR(100) NULL DEFAULT NULL,
  `OrderID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`OrderDeliveryID`),
  INDEX `orderdelivery_orders_fk_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `orderdelivery_orders_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `littlelemondb`.`orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `littlelemondb` ;

-- -----------------------------------------------------
-- procedure AddBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`metauser`@`%` PROCEDURE `AddBooking`(p_BookingID INT, p_CustomerID INT,p_TableNumber INT, p_BookingDate DATE )
BEGIN

INSERT INTO Bookings(BookingID,CustomerID,TableNumber,Date) VALUES (p_BookingID, p_CustomerID, p_TableNumber, DATE(p_BookingDate));
SELECT CONCAT('New booking added') AS 'Confirmation';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddValidBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CancelBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`metauser`@`%` PROCEDURE `CancelBooking`(p_BookingID INT)
BEGIN
DELETE FROM Bookings WHERE BookingID = p_BookingID;
SELECT CONCAT('Booking ', p_BookingID, ' cancelled') AS 'Confirmation';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CancelOrder
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`metauser`@`%` PROCEDURE `CancelOrder`(Order_ID int)
BEGIN
DELETE FROM Orders WHERE OrderID = Order_ID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CheckBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
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




END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetMaxQuantity
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`metauser`@`%` PROCEDURE `GetMaxQuantity`()
select MAX(OrderQuantity) AS "Max Quantity in Order" FROM Orders$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`metauser`@`%` PROCEDURE `UpdateBooking`(p_BookingID int,p_BookingDate DATE)
BEGIN

UPDATE Bookings SET Date = (DATE(p_BookingDate)) WHERE BookingID = p_BookingID ;
SELECT CONCAT('Booking ',p_BookingID,' updated') AS 'Confirmation';
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
