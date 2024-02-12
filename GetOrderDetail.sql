PREPARE GetOrderDetail FROM
'SELECT Orders.OrderID, Orders.OrderQuantity,Orders.TotalCost 
FROM Orders JOIN Customers USING(CustomerID)
WHERE Customers.CustomerID = ? ;'
