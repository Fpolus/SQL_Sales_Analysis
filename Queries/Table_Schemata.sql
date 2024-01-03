CREATE TABLE Invoices (
    Invoice_ID VARCHAR(20) NOT NULL PRIMARY KEY,
    Branch VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Customer_type VARCHAR(50) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Product_Line VARCHAR(50) NOT NULL,
    Unit_Price DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    Tax5 DECIMAL(10, 2) NOT NULL,
    Total DECIMAL(10, 2) NOT NULL,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Payment VARCHAR(50) NOT NULL,
    COGS DECIMAL(10, 2) NOT NULL,
    Gross_Margin_Percentage DECIMAL(5, 2) NOT NULL,
    Gross_Income DECIMAL(10, 2) NOT NULL,
    Rating DECIMAL(3, 1) NOT NULL
);