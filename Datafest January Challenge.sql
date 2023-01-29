-- a. How many orders were shipped by Speedy Express in total? 
SELECT s.ShipperName, COUNT(DISTINCT (o.OrderID)) TotalOrders
FROM Orders o
JOIN Shippers s ON o.ShipperID=s.ShipperID
WHERE s.ShipperName="Speedy Express";

-- b. What is the last name of the employee with the most orders?
SELECT e.LastName, COUNT(OrderID) TotalOrders
FROM Employees e
RIGHT JOIN Orders o ON o.EmployeeID=e.EmployeeID
GROUP BY o.EmployeeID
ORDER BY 2 DESC
LIMIT 1;

-- c. What product was ordered the most by customers in Germany? 
With german_orders AS(
                    SELECT OrderID
                    FROM Orders
                    WHERE CustomerID IN(
                                      SELECT CustomerID
                                      FROM Customers
                                      WHERE Country='Germany')),
total_german_orders AS( 
                    SELECT o.ProductID, o.Quantity Qty
                    FROM OrderDetails o
                    JOIN german_orders g ON g.OrderID=o.OrderID
                    )
SELECT p.ProductName, t.Qty TotalOrders
FROM total_german_orders t
JOIN Products p ON t.ProductID=p.ProductID
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
