USE littlelemondb;

INSERT INTO customers (CustomerID, FirstName, LastName, PhoneNumber) VALUES
(1, 'John', 'Doe', '123-456-7890'),
(2, 'Jane', 'Smith', '987-654-3210'),
(3, 'Alice', 'Johnson', '555-123-4567'),
(4, 'Bob', 'Williams', '888-999-0000'),
(5, 'Eva', 'Brown', '444-777-1111'),
(6, 'Charlie', 'Davis', '222-333-4444'),
(7, 'Grace', 'Moore', '111-222-3333'),
(8, 'Daniel', 'White', '999-888-7777'),
(9, 'Olivia', 'Miller', '777-555-9999'),
(10, 'Liam', 'Taylor', '444-666-8888');


INSERT INTO menuitems (MenuItemID, ItemName, ItemPrice) VALUES
(1, 'Chicken Curry', 12.99),
(2, 'Vegetarian Pizza', 9.99),
(3, 'Salmon Steak', 18.50),
(4, 'Pasta Carbonara', 15.75),
(5, 'Chocolate Cake', 6.99),
(6, 'Margarita Cocktail', 8.50),
(7, 'Caesar Salad', 10.25),
(8, 'Beef Burger', 14.99),
(9, 'Fruit Sorbet', 5.25),
(10, 'Iced Coffee', 4.50);


INSERT INTO menu (MenuID, Cuisine, Starter, Course, Drinks, Desserts, MenuItemID) VALUES
(1, 'Italian', 'Garlic Bread', 'Lasagna', 'Chianti', 'Tiramisu', 1),
(2, 'American', 'Onion Rings', 'BBQ Ribs', 'Soda', 'Brownie', 8),
(3, 'Japanese', 'Edamame', 'Sushi', 'Green Tea', 'Mochi Ice Cream', 3),
(4, 'Indian', 'Samosa', 'Chicken Curry', 'Lassi', 'Gulab Jamun', 6),
(5, 'Mediterranean', 'Hummus', 'Grilled Lamb', 'White Wine', 'Baklava', 2),
(6, 'Mexican', 'Guacamole', 'Tacos', 'Margarita', 'Churros', 4),
(7, 'French', 'Escargot', 'Coq au Vin', 'Red Wine', 'Crème Brûlée', 7),
(8, 'Chinese', 'Spring Rolls', 'Kung Pao Chicken', 'Jasmine Tea', 'Fortune Cookie', 9),
(9, 'Thai', 'Tom Yum Soup', 'Pad Thai', 'Thai Iced Tea', 'Mango Sticky Rice', 5),
(10, 'Greek', 'Spanakopita', 'Moussaka', 'Ouzo', 'Baklava', 10);


INSERT INTO orders (OrderID, OrderDate, OrderQuantity, OrderType, TotalCost, MenuID, MenuItemID, CustomerID) VALUES
(1, '2023-01-15', 2, 'Dine-in', 180.50, 1, 1, 3),
(2, '2023-02-10', 1, 'Takeout', 120.75, 2, 4, 5),
(3, '2023-03-22', 4, 'Delivery', 200.25, 3, 7, 8),
(4, '2023-04-05', 3, 'Dine-in', 175.00, 4, 10, 1),
(5, '2023-05-18', 2, 'Takeout', 160.00, 5, 2, 7),
(6, '2023-06-30', 1, 'Dine-in', 152.75, 6, 5, 9),
(7, '2023-07-12', 3, 'Delivery', 165.50, 7, 8, 2),
(8, '2023-08-25', 2, 'Takeout', 185.75, 8, 9, 4),
(9, '2023-09-08', 1, 'Dine-in', 160.00, 9, 3, 6),
(10, '2023-10-19', 5, 'Delivery', 210.30, 10, 6, 10);


INSERT INTO staff (StaffID, FirstName, LastName, Role, Salary) VALUES
(1, 'Michael', 'Johnson', 'Chef', 50000.00),
(2, 'Emily', 'Anderson', 'Waiter', 25000.00),
(3, 'David', 'Smith', 'Bartender', 30000.00),
(4, 'Sophia', 'Clark', 'Manager', 60000.00),
(5, 'James', 'Miller', 'Hostess', 20000.00),
(6, 'Emma', 'Davis', 'Chef', 48000.00),
(7, 'Daniel', 'White', 'Waiter', 27000.00),
(8, 'Olivia', 'Johnson', 'Bartender', 32000.00),
(9, 'Liam', 'Taylor', 'Manager', 58000.00),
(10, 'Grace', 'Moore', 'Hostess', 22000.00);



INSERT INTO bookings (BookingID, Date, TableNumber, CustomerID, OrderID, StaffID) VALUES
(1, '2023-01-15', 4, 3, 1, 2),
(2, '2023-02-10', 8, 5, 2, 4),
(3, '2023-03-22', 2, 8, 3, 8),
(4, '2023-04-05', 5, 1, 4, 6),
(5, '2023-05-18', 10, 7, 5, 10),
(6, '2023-06-30', 3, 9, 6, 3),
(7, '2023-07-12', 7, 2, 7, 7),
(8, '2023-08-25', 9, 4, 8, 9),
(9, '2023-09-08', 1, 6, 9, 1),
(10, '2023-10-19', 6, 10, 10, 5);


INSERT INTO orderdelivery (OrderDeliveryID, OrderDeliveryDate, OrderDeliveryStatus, OrderID) VALUES
(1, '2023-01-15', 'Delivered', 1),
(2, '2023-03-22', 'In Progress', 3),
(3, '2023-05-18', 'Delivered', 5),
(4, '2023-07-12', 'Pending', 7),
(5, '2023-09-08', 'Delivered', 9),
(6, '2023-10-19', 'Pending', 10),
(7, '2023-12-01', 'In Progress', 2),
(8, '2023-12-01', 'Pending', 4),
(9, '2023-12-01', 'Delivered', 6),
(10, '2023-12-01', 'In Progress', 8);
