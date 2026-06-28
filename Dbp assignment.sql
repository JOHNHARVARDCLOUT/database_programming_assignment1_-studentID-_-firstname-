CREATE TABLE SM_CUSTOMERS (
    CustomerID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(100),
    City VARCHAR2(50)
);
CREATE TABLE SM_PRODUCTS (
    ProductID NUMBER PRIMARY KEY,
    ProductName VARCHAR2(100),
    Price NUMBER(10,2)
);
CREATE TABLE SM_ORDERS (
    OrderID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    ProductID NUMBER,
    Quantity NUMBER,
    TotalAmount NUMBER(10,2),
    OrderDate DATE,
    CONSTRAINT fk_sm_customer
        FOREIGN KEY (CustomerID)
        REFERENCES SM_CUSTOMERS(CustomerID),
    CONSTRAINT fk_sm_product
        FOREIGN KEY (ProductID)
        REFERENCES SM_PRODUCTS(ProductID)
);
INSERT INTO SM_CUSTOMERS VALUES (1, 'John Doe', 'Kigali');
INSERT INTO SM_CUSTOMERS VALUES (2, 'Mary Smith', 'Musanze');
INSERT INTO SM_CUSTOMERS VALUES (3, 'Peter Johnson', 'Huye');
INSERT INTO SM_CUSTOMERS VALUES (4, 'Alice Brown', 'Rubavu');
INSERT INTO SM_CUSTOMERS VALUES (5, 'David Wilson', 'Kigali');
COMMIT;
INSERT INTO SM_PRODUCTS VALUES (101, 'Laptop', 850.00);
INSERT INTO SM_PRODUCTS VALUES (102, 'Mouse', 25.00);
INSERT INTO SM_PRODUCTS VALUES (103, 'Keyboard', 45.00);
INSERT INTO SM_PRODUCTS VALUES (104, 'Printer', 200.00);
INSERT INTO SM_PRODUCTS VALUES (105, 'Monitor', 300.00);

COMMIT;
INSERT INTO SM_ORDERS VALUES (1001, 1, 101, 1, 850.00, DATE '2026-06-20');
INSERT INTO SM_ORDERS VALUES (1002, 2, 102, 2, 50.00, DATE '2026-06-21');
INSERT INTO SM_ORDERS VALUES (1003, 3, 103, 1, 45.00, DATE '2026-06-22');
INSERT INTO SM_ORDERS VALUES (1004, 1, 104, 1, 200.00, DATE '2026-06-23');
INSERT INTO SM_ORDERS VALUES (1005, 4, 105, 2, 600.00, DATE '2026-06-24');
INSERT INTO SM_ORDERS VALUES (1006, 5, 101, 1, 850.00, DATE '2026-06-25');
INSERT INTO SM_ORDERS VALUES (1007, 2, 105, 1, 300.00, DATE '2026-06-26');
INSERT INTO SM_ORDERS VALUES (1008, 4, 102, 3, 75.00, DATE '2026-06-27');
COMMIT;
SELECT * FROM SM_CUSTOMERS;
SELECT * FROM SM_PRODUCTS;
SELECT * FROM SM_ORDERS;
WITH KigaliCustomers AS
(
    SELECT CustomerID,
           CustomerName,
           City
    FROM SM_CUSTOMERS
    WHERE City = 'Kigali'
) 
SELECT * FROM KigaliCustomers;

WITH CustomerOrders AS
(
    SELECT CustomerID,
           COUNT(OrderID) AS TotalOrders
    FROM SM_ORDERS
    GROUP BY CustomerID
),
CustomerSales AS
(
    SELECT CustomerID,
           SUM(TotalAmount) AS TotalSpent
    FROM SM_ORDERS
    GROUP BY CustomerID
)

SELECT
    c.CustomerID,
    c.CustomerName,
    co.TotalOrders,
    cs.TotalSpent
FROM SM_CUSTOMERS c
JOIN CustomerOrders co
ON c.CustomerID = co.CustomerID
JOIN CustomerSales cs
ON c.CustomerID = cs.CustomerID
ORDER BY cs.TotalSpent DESC;

WITH Numbers (Num) AS
(
    SELECT 1
    FROM DUAL

    UNION ALL

    SELECT Num + 1
    FROM Numbers
    WHERE Num < 10
)
SELECT *
FROM Numbers;

WITH ProductSales AS
(
    SELECT
        ProductID,
        SUM(TotalAmount) AS TotalSales
    FROM SM_ORDERS
    GROUP BY ProductID
)
SELECT
    p.ProductName,
    ps.TotalSales
FROM SM_PRODUCTS p
JOIN ProductSales ps
    ON p.ProductID = ps.ProductID
ORDER BY ps.TotalSales DESC;

WITH OrderDetails AS
(
    SELECT
        OrderID,
        CustomerID,
        ProductID,
        Quantity,
        TotalAmount
    FROM SM_ORDERS
)
SELECT
    od.OrderID,
    c.CustomerName,
    p.ProductName,
    od.Quantity,
    od.TotalAmount
FROM OrderDetails od
JOIN SM_CUSTOMERS c
    ON od.CustomerID = c.CustomerID
JOIN SM_PRODUCTS p
    ON od.ProductID = p.ProductID
ORDER BY od.OrderID;

SELECT
    OrderID,
    CustomerID,
    TotalAmount,
    ROW_NUMBER() OVER (ORDER BY TotalAmount DESC) AS Row_Num
FROM SM_ORDERS;

SELECT
    OrderID,
    CustomerID,
    TotalAmount,
    RANK() OVER (ORDER BY TotalAmount DESC) AS Rank_Num
FROM SM_ORDERS;

SELECT
    OrderID,
    CustomerID,
    TotalAmount,
    DENSE_RANK() OVER (ORDER BY TotalAmount DESC) AS Dense_Rank
FROM SM_ORDERS;

SELECT
    OrderID,
    CustomerID,
    TotalAmount,
    NTILE(4) OVER (ORDER BY TotalAmount DESC) AS Quartile
FROM SM_ORDERS;

SELECT
    OrderID,
    TotalAmount,
    LAG(TotalAmount, 1) OVER (ORDER BY OrderID) AS PreviousAmount
FROM SM_ORDERS;

SELECT
    OrderID,
    TotalAmount,
    LEAD(TotalAmount, 1) OVER (ORDER BY OrderID) AS NextAmount
FROM SM_ORDERS;

SELECT
    OrderID,
    CustomerID,
    TotalAmount,
    CUME_DIST() OVER (ORDER BY TotalAmount) AS Cumulative_Distribution
FROM SM_ORDERS;

