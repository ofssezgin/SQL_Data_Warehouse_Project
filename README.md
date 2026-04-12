# Modern Data Warehouse Implementation (SQL Server)

## 📌 Project Overview
This project is an end-to-end Data Warehousing solution built from scratch using **Microsoft SQL Server**. It demonstrates the implementation of the **Medallion Architecture** (Bronze, Silver, and Gold layers) to extract, transform, and load (ETL) data from disparate sources (CRM and ERP systems) into a centralized, analytical data model. 

The primary goal of this project is to transform raw, inconsistent data into a structured, high-quality Star Schema ready for Business Intelligence (BI) reporting and Exploratory Data Analysis (EDA).

## 🏛️ Architecture & Data Flow (Medallion Architecture)
The data pipeline follows a structured, three-layered approach:

1. **Bronze Layer (Raw Data):**
   - Acts as the landing zone for raw data extracted from source systems.
   - Data is ingested "as-is" without any transformations to maintain a historical record of the original state.
2. **Silver Layer (Cleansed & Conformed Data):**
   - The core ETL transformation phase.
   - Applies data cleansing, standardizes formats, handles `NULL` values, and normalizes categorical fields.
   - Utilizes an **Idempotent** Full-Load strategy (`TRUNCATE` and `INSERT`) to ensure data pipelines can be re-run safely without creating duplicate records.
3. **Gold Layer (Business/Analytical Data):**
   - Implements dimensional data modeling (**Star Schema**).
   - Data is structured into `Fact` and `Dimension` tables (e.g., `fact_sales`, `dim_customers`, `dim_products`).
   - Optimized for complex analytical queries, reporting, and dashboarding.

## 🛠️ Tech Stack & Tools
* **Database Engine:** Microsoft SQL Server (T-SQL)
* **IDE:** SQL Server Management Studio (SSMS)
* **Concepts:** Data Warehousing, ETL/ELT Pipelines, Dimensional Modeling (Star Schema), Data Cleansing, Idempotency.

## 🚀 Key Features & Engineering Practices
* **Automated Data Cleansing:** Handled missing values (e.g., using `ISNULL`), manipulated strings (`SUBSTRING`, `REPLACE`), and standardized inconsistent categorical data using `CASE WHEN` statements.
* **Robust Data Quality Checks (QC):** Developed extensive SQL scripts to validate data integrity across layers. Checks include:
  - Primary Key uniqueness and `NULL` validations.
  - Identification of unwanted spaces (`TRIM` validations).
  - Logical date boundaries (e.g., ensuring `start_date` is before `end_date`).
  - Negative value checks for financial metrics (e.g., `cost` and `price`).
* **Relational Data Modeling:** Designed a highly performant analytical model by securely joining sales details with corresponding customer and product dimensions using `LEFT JOIN` and surrogate keys.

## 📁 Repository Structure
* `datasets/` — Raw source data files (CSV, JSON, etc.) used for ingestion.
* `docs/` — Project documentation, architecture diagrams, and data catalogs.
* `scripts/` — SQL scripts for DDL, ETL processes (Bronze, Silver, Gold), and views.
* `tests/` — Data quality checks and validation scripts.
* `LICENSE` — Project license file.
* `README.md` — Project overview and instructions.

## 📊 Analytical Reporting
The Gold layer powers various business insights, including:
* **Change Over Time Analysis:** Tracking sales trends and revenue growth.
* **Performance Analysis:** Identifying top-performing products and high-value customer segments.
* **Cumulative Analysis:** Calculating running totals for financial metrics.
* **Data Segmentation:** Categorizing customers and products based on business rules for targeted reporting.

## 💡 How to Run the Project
1. **Clone the Repository:** Download the project files to your local machine.
2. **Database Connection:** Open Microsoft SQL Server Management Studio (SSMS) and connect to your SQL Server instance.
3. **Initialization:** Run the database creation scripts located in the `scripts` folder.
4. **ETL Execution:** Execute the scripts in the following order to populate the layers: `Bronze` -> `Silver` -> `Gold`.
5. **Validation:** Run the scripts in the `tests` folder to ensure all data quality checks pass.
6. **Analysis:** Use the scripts in the `scripts` folder (analytics/views) to explore the data and generate reports.
