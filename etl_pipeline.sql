-- STEP 1: Create staging table
DROP TABLE IF EXISTS staging_sales;
CREATE TABLE staging_sales (
    idx INTEGER,
    Date TEXT,
    Customer_ID INTEGER,
    Transaction_ID INTEGER,
    SKU_Category TEXT,
    SKU TEXT,
    Quantity INTEGER,
    Sales_Amount REAL
);

-- STEP 2: Create production table
DROP TABLE IF EXISTS production_sales;
CREATE TABLE production_sales (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Date TEXT,
    Customer_ID INTEGER,
    Transaction_ID INTEGER,
    SKU_Category TEXT,
    SKU TEXT,
    Quantity INTEGER,
    Sales_Amount REAL,
    Inserted_At DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- STEP 3: Create audit log table
DROP TABLE IF EXISTS audit_log;
CREATE TABLE audit_log (
    Log_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Table_Name TEXT,
    Inserted_Row_ID INTEGER,
    Inserted_At DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- STEP 4: Create trigger for logging inserts
DROP TRIGGER IF EXISTS trg_insert_production_sales_audit;
CREATE TRIGGER trg_insert_production_sales_audit
AFTER INSERT ON production_sales
BEGIN
    INSERT INTO audit_log (Table_Name, Inserted_Row_ID)
    VALUES ('production_sales', NEW.ID);
END;

-- Importing CSV into staging_sales using DB Browser 

-- STEP 5: Clean, Transform, Load
INSERT INTO production_sales (Date, Customer_ID, Transaction_ID, SKU_Category, SKU, Quantity, Sales_Amount)
SELECT
    Date,
    Customer_ID,
    Transaction_ID,
    SKU_Category,
    SKU,
    Quantity,
    Sales_Amount
FROM staging_sales
WHERE
    Date IS NOT NULL AND
    Customer_ID IS NOT NULL AND
    Transaction_ID IS NOT NULL AND
    SKU_Category IS NOT NULL AND
    SKU IS NOT NULL AND
    Quantity IS NOT NULL AND
    Sales_Amount IS NOT NULL
GROUP BY
    Date, Customer_ID, Transaction_ID, SKU_Category, SKU, Quantity, Sales_Amount
HAVING COUNT(*) = 1;

-- STEP 6: Optional cleanup of staging
DROP TRIGGER IF EXISTS trg_cleanup_staging;
CREATE TRIGGER trg_cleanup_staging
AFTER INSERT ON production_sales
WHEN (SELECT COUNT(*) FROM production_sales) > 0
BEGIN
    DELETE FROM staging_sales;
END;

-- STEP 7: Verification
SELECT * FROM production_sales;
SELECT * FROM audit_log;
