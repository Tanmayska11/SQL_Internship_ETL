# SQL ETL Pipeline Simulation Using SQLite

## Project Overview
This project simulates a professional Extract, Transform, Load (ETL) pipeline using SQLite and DB Browser for SQLite. It demonstrates the process of importing raw data, cleaning and transforming it, and loading it into production tables with automated audit logging via triggers. The project aims to replicate real-world data engineering workflows using SQL, ensuring data quality and traceability.

## Features
- Import raw sales data from CSV into a staging table
- Data cleaning: removing duplicates and rows with null values
- Transform and load clean data into production tables
- Audit logging for all inserts using SQL triggers
- Automated staging table cleanup after data load
- Export final cleaned data for reporting and analysis

## Tools Used
- **SQLite:** Lightweight, file-based SQL database engine
- **DB Browser for SQLite:** GUI tool to create, manage, and query SQLite databases
- **SQL:** For schema creation, data transformation, triggers, and ETL logic
- **CSV files:** Data input and output format

## Project Structure
- `etl_pipeline.sql` — SQL script containing all table definitions, triggers, and ETL logic
- `raw_sales.csv` — Raw input sales dataset (to be imported into staging)
- `clean_sales.csv` — Exported cleaned and transformed production data after ETL
- `audit_log.csv` — Exported audit log capturing data insert activities

## How to Run
1. Open or create a new SQLite database using DB Browser for SQLite.
2. Execute `etl_pipeline.sql` to create tables and triggers.
3. Import `raw_sales.csv` into the `staging_sales` table via DB Browser's CSV import feature.
4. Run the INSERT query from the ETL script to clean and move data from staging to production.
5. Query `production_sales` and `audit_log` tables to verify data and logs.
6. Export the cleaned production data and audit logs as CSV files for reporting.

## Learning Outcomes
- Hands-on experience building ETL pipelines using only SQL
- Data cleaning and transformation techniques
- Using triggers for audit logging and automation
- Managing SQLite databases with DB Browser GUI tools

---

Feel free to customize this README with your personal info or project links. Want me to prepare a GitHub-ready ZIP or anything else? Just ask!
