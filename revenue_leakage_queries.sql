create database customer_support

use customer_support
select * from customer_support_data

CREATE VIEW Low_CSAT_Alerts AS
SELECT 
    category,
    `Sub-category`,
    COUNT(unique_id) AS total_complaints,
    ROUND(AVG(connected_handling_time), 2) AS avg_resolution_time_minutes,
    ROUND(AVG(item_price), 2) AS avg_impacted_revenue,
    -- Grouping text complaints for GenAI processing
    GROUP_CONCAT(customer_remarks SEPARATOR ' | ') AS aggregated_raw_feedback
FROM customer_support_data
WHERE `CSAT_Score` <= 2 -- Focus on severely unhappy customers
GROUP BY category, `Sub-category`
HAVING total_complaints > 10
ORDER BY avg_impacted_revenue DESC;

select * from Low_CSAT_Alerts
