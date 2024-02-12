SELECT 
    Customers.CustomerID,
    Orders.OrderID,
    Orders.TotalCost,
    Menu.Cuisine,
    Menu.Starter,
    Menu.Course,
    MenuItems.ItemName
FROM
    Orders
        INNER JOIN
    Customers ON Customers.CustomerID = Orders.CustomerID
        INNER JOIN
    Menu ON Orders.MenuID = Menu.MenuID
        INNER JOIN
    MenuItems ON Orders.MenuItemID = MenuItems.MenuItemID
WHERE
    Orders.TotalCost > 150;