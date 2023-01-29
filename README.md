# DatafestAfrica-January-2023-Data-Science-Challenge
Solution to Question 2 of the Datafest January Challenge

a. How many orders were shipped by Speedy Express in total?

```sql
SELECT s.ShipperName, COUNT(DISTINCT (o.OrderID)) TotalOrders
FROM Orders o
JOIN Shippers s ON o.ShipperID=s.ShipperID
WHERE s.ShipperName="Speedy Express";
```
**A total of *54* Orders were shipped by *Speedy Express***
![Screenshot_20230126_015856](https://user-images.githubusercontent.com/107050974/214775568-7d48b373-ab78-46aa-a28c-847e2126ee7b.png)

b. What is the last name of the employee with the most orders?
```sql
SELECT e.LastName, COUNT(o.OrderID) TotalOrders
FROM Employees e
JOIN Orders o ON o.EmployeeID=e.EmployeeID
GROUP BY o.EmployeeID
ORDER BY 2 DESC
LIMIT 1;
```
**Employee *'Peacock'* had the most orders recording 40 orders and Employee *'Leverling'* following in behind with 31 Orders**
![Screenshot_20230126_011955](https://user-images.githubusercontent.com/107050974/214776108-b1982dcb-ab7d-4c3b-882b-217cebddc5ef.png)

c. What product was ordered the most by customers in Germany?

```sql
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
                    GROUP BY g.OrderID)
SELECT p.ProductName, SUM(t.Qty) TotalOrders
FROM total_german_orders t
JOIN Products p ON t.ProductID=p.ProductID
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
```

***'Steeleye Stout'* was the most purchased product from customers residing in Germany with 100 orders just merely passing *'Chang'* which had 84 orders.** 
![Screenshot_20230129_010206](https://user-images.githubusercontent.com/107050974/215308170-858cbe13-5386-497a-a52e-ca801fdc0ac3.png)

