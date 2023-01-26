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
With german_orders AS(SELECT OrderID
FROM Orders
WHERE CustomerID IN(
SELECT CustomerID
FROM Customers
WHERE Country='Germany')),
total_german_orders AS( 
SELECT o.ProductID, SUM(o.Quantity) TotalOrders
FROM OrderDetails o
JOIN german_orders g ON g.OrderID=o.OrderID
GROUP BY g.OrderID)
SELECT p.ProductName, t.TotalOrders
FROM total_german_orders t
JOIN Products p ON t.ProductID=p.ProductID
ORDER BY 2 DESC
LIMIT 1;
```

***'Chang'* was the most purchased product from customers residing in germany with 160 orders just merely passing *'Northwoods Cranberry Sauce'* which had 159 orders.** 
![Screenshot_20230126_020945](https://user-images.githubusercontent.com/107050974/214777063-bc7c5a08-7019-401f-9912-f6090a4fe662.png)
