# DatafestAfrica-January-2023-Data-Science-Challenge
Solution to Question 2 of the Datafest January Challenge

The database can be gotten from [HERE](https://www.w3schools.com/SQL/TRYSQL.ASP?FILENAME=TRYSQL_SELECT_ALL)

## QUESTIONS
a. How many orders were shipped by Speedy Express in total?

*In this query I joined the 'Orders' table and the 'Shippers' table using the 'ShipperID' column and then used the **WHERE** clause to filter out orders that were shipped by 'Speedy Express' then counted those orders using **COUNT and DISTINCT** functions*

```sql
SELECT s.ShipperName, COUNT(DISTINCT (o.OrderID)) TotalOrders
FROM Orders o
JOIN Shippers s ON o.ShipperID=s.ShipperID
WHERE s.ShipperName="Speedy Express";
```
**A total of *54* Orders were shipped by *Speedy Express***
![Screenshot_20230126_015856](https://user-images.githubusercontent.com/107050974/214775568-7d48b373-ab78-46aa-a28c-847e2126ee7b.png)

b. What is the last name of the employee with the most orders?

*In this query I performed a process similar to the query above **(question a)**. I aggregated the data using the **GROUP BY** function to return orders handled by each employee and used the **COUNT** function to get the total orders. I arranged the data in descending order and used the **LIMIT** function to return the highest number of orders handled by an employee.*

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

*In this query I began by creating a **CTE** called 'german_orders', here I filtered out orders made by customers residing in Germany. Afterwardrs I created another **CTE** called 'total_german_orders', I joined the OrderDetails table with the **CTE** I intially created using the 'OrderID' column to return the products ID and it's respective quantity ordered by the customers residing in Germany.*

*Lastly I joined my second **CTE** to the Products table to retrive each prodcut's name. I aggregated the data by the 'ProductID' column and summed the 'Quantity' column using the **SUM** function.*

```sql
With german_orders AS(
                    SELECT OrderID
                    FROM Orders
                    WHERE CustomerID IN(
                                      SELECT CustomerID
                                      FROM Customers
                                      WHERE Country='Germany')),
total_german_orders AS( 
                    SELECT o.OrderID, o.ProductID, o.Quantity Qty
                    FROM OrderDetails o
                    JOIN german_orders g ON g.OrderID=o.OrderID
                    )
SELECT p.ProductName, SUM(t.Qty) TotalOrders
FROM total_german_orders t
JOIN Products p ON t.ProductID=p.ProductID
GROUP BY t.ProductID
ORDER BY 2 DESC
LIMIT 1;
```

***'Boston Crab Meat'* was the most purchased product from customers residing in Germany with 160 orders passing *'Gorgonzola Telino'* which had 125 orders.** 
![Screenshot_20230129_021015](https://user-images.githubusercontent.com/107050974/215311050-ef815f8d-9ff9-4485-8b75-17c765869af2.png)

