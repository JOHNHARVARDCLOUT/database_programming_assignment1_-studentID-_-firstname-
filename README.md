# Database Programming Assignment 1

## Business Scenario

### Business Problem

This project is based on a **Sales Management System**. The company
needs a database to manage customers, products, and customer orders
efficiently. The database stores customer information, available
products, and sales transactions. It helps the business track purchases,
analyze sales performance, and generate reports using SQL queries,
Common Table Expressions (CTEs), and Window Functions.

## Database Schema

### SM_CUSTOMERS

-   CustomerID (Primary Key)
-   CustomerName
-   City

### SM_PRODUCTS

-   ProductID (Primary Key)
-   ProductName
-   Price

### SM_ORDERS

-   OrderID (Primary Key)
-   CustomerID (Foreign Key)
-   ProductID (Foreign Key)
-   Quantity
-   TotalAmount

## ER Diagram

SM_CUSTOMERS (1) ---- (M) SM_ORDERS (M) ---- (1) SM_PRODUCTS

## CTE Implementations

-   Simple CTE to display customer orders.
-   Recursive CTE to demonstrate recursive SQL processing.

## Window Function Implementations

Implemented: - ROW_NUMBER() - RANK() - DENSE_RANK() - NTILE() - LAG() -
LEAD() - CUME_DIST()

Each implementation includes SQL code, screenshots, and interpretation.

## Analysis and Findings

### Descriptive Analysis

Customer purchases were successfully recorded and ranked.

### Diagnostic Analysis

Different purchasing patterns resulted in different total sales values.

### Prescriptive Analysis

Reward loyal customers, restock popular products, promote low-selling
products, and continue monitoring sales using SQL analytics.

## References

-   Oracle SQL Documentation
-   Oracle SQL Developer Documentation
-   Database Programming Course Notes
-   GitHub Documentation

## Academic Integrity Statement

I declare that this assignment is my own original work and complies with
the university's academic integrity policy.
