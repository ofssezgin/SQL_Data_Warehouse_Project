/* 
This script performs quality checks to validate the integrity, consistency,
and accuracy of the gold layer.

Uniqueness of surrogate keys in dimension tables.
Referantial integrity between fact and dimension tables.
Validation of relationships in the data model for analytical purposes.

Run these checks after data loading Silver layer.
*/

SELECT DISTINCT
	ci.cst_gndr,
	ca.gen,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- crm is the master for gender info
		 ELSE COALESCE(ca.gen, 'n/a')
	END AS new_gen
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON		  ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON		  ci.cst_key = la.cid
ORDER BY 1,2

-- Quality check
SELECT * FROM gold.dim_customers

SELECT DISTINCT gender FROM gold.dim_customers

SELECT * FROM gold.dim_products

SELECT * FROM gold.fact_sales


-- Check if there are duplicates expectation: no result
SELECT prd_key, COUNT(*) FROM (
	SELECT
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	pc.cat,
	pc.subcat,
	pc.maintenance
	FROM silver.crm_prd_info pn
	LEFT JOIN silver.erp_px_cat_g1v2 pc
	ON pn.cat_id = pc.id
	WHERE prd_end_dt IS NULL -- filter out all historical data
)T GROUP BY prd_key
HAVING COUNT(*) < 1

-- Foreign key integrity (dimensions)
SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
--WHERE c.customer_key IS NULL
WHERE p.product_key IS NULL
