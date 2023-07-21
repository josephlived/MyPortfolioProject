/* 
I'm using Northwind Trader database for this project. A free database provided by Microsoft, which is often used for learning SQL
*/

/* 
The Business Problem/Question :

    "As a method of increasing future sales, the company has decided to give   
    employee bonuses for exemplary performance in sales.

    Bonuses will be awarded to those employees who are responsible for the five highest order amounts."

-HOW CAN WE IDENTIFY THOSE EMPLOYEES?-
*/

--Skills Used: Joins, Aggregate, Having Clause, Aliases.



--Join "Employees" and "Order" table Together to Obtain Data for Analysis

SELECT LastName, FirstName, OrderID
FROM Employees
INNER JOIN
Orders
ON employees.employeeID = orders.employeeID
ORDER BY LastName, FirstName


/* 
In order to calculate and isolate the top five orders we need two other tables which is "OrderDetails" and "Products" Tables using their common column 
*/


-- Joining Four Tables "Employees", "Orders", "OrderDetails", "Products".

SELECT LastName, FirstName, Orders.OrderID, Products.ProductID, 
     Quantity, Price
FROM employees
    inner join orders
        on employees.employeeID = orders.employeeid 
    inner join orderDetails
        on orders.orderid = orderdetails.orderid
    inner join products
        on orderdetails.productid = products.productid
ORDER BY lastname, firstname


--Calculate Quantity * Price for each line item on the order.

SELECT LastName, FirstName, Orders.OrderID, Products.ProductID, 
     Quantity, Price, SUM(Quantity * Price) AS SalesAmount
FROM employees
    inner join orders
        on employees.employeeID = orders.employeeid 
    inner join orderDetails
        on orders.orderid = orderdetails.orderid
    inner join products
        on orderdetails.productid = products.productid
GROUP BY Orders.OrderID


--Rank the orders by sales amount and determine the top five orders.

SELECT LastName, FirstName, Orders.OrderID, Products.ProductID, 
     Quantity, Price, SUM(Quantity * Price) AS SalesAmount
FROM employees
    inner join orders
        on employees.employeeID = orders.employeeid 
    inner join orderDetails
        on orders.orderid = orderdetails.orderid
    inner join products
        on orderdetails.productid = products.productid
GROUP BY Orders.OrderID
ORDER BY SalesAmount DESC


--Limit the output to the top Five Orders.

SELECT LastName, FirstName, Orders.OrderID, Products.ProductID, 
     Quantity, Price, SUM(Quantity * Price) AS SalesAmount
FROM employees
    inner join orders
        on employees.employeeID = orders.employeeid 
    inner join orderDetails
        on orders.orderid = orderdetails.orderid
    inner join products
        on orderdetails.productid = products.productid
GROUP BY Orders.OrderID
ORDER BY SalesAmount DESC
LIMIT 5

--As we analyze the data, we found that the data shows that only three employees have earned bonuses in the list of top five orders.

--Two of the employees, Robert King and Margaret Peacock have two orders each and Steven Buchanan has won.

--This would be a good report to provide to the sales manager. However, as data analysts, we might question whether the sales manager planned to give bonuses to five employees.


--List five employees with the highest sales using Having Claus to OrderID.

SELECT DISTINCT LastName, FirstName, Orders.OrderID, Products.ProductID, 
     Quantity, Price, SUM(Quantity * Price) AS SalesAmount
FROM employees
    inner join orders
        on employees.employeeID = orders.employeeid 
    inner join orderDetails
        on orders.orderid = orderdetails.orderid
    inner join products
        on orderdetails.productid = products.productid
GROUP BY Orders.OrderID
HAVING orders.orderID in (10372,10424,10360,10324,10351)
ORDER BY SalesAmount DESC

/* 
    Solution - two reports:

The first report provides the names of employees responsible for the top five orders. The second report provides the names of the five employees who had the orders with the highest sales amounts providing both reports gives our sales manager more data with which to formulate a good business decision in regard to awarding bonuses as a sales incentive.

*/



