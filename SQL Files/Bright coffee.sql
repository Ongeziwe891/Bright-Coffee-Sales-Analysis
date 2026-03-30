--------------------------------------------------------------
---Combining functions to get a clean and enhanced dataset
-----------------------------------------------------------------

select 
       transaction_id,
       transaction_date,
      transaction_time,
      transaction_qty,
      unit_price,
      store_id,
      store_location,
      product_id,
      product_category,
      product_type,
      product_detail,
     
----Adding columns for better insights

dayname(transaction_date) as Day_NAME,
monthname(transaction_date) as Month_NAME,
dayofmonth(transaction_date) as Date_of_month,
CASE
    WHEN dayname(transaction_date) In ('Sun','Sat') Then 'weekends'
    Else 'weekdays'
    END as day_classification,
---time buckets
    CASE
    WHEN date_format(transaction_time,'HH:MM:SS') between '05:00:00' and '08:59:59' then '01.RUSH HOUR'
    WHEN date_format(transaction_time,'HH:MM:SS') between '09:00:00' and '11:59:59' then '02.MID Morning'
    WHEN date_format(transaction_time,'HH:MM:SS') between '12:00:00' and '15:59:59' then '02.Afternoon'
    WHEN date_format(transaction_time,'HH:MM:SS') between '16:00:00' and '18:00:00' then 'Evening'
    ELSE 'Late Night'
    END as time_classification,

---Spend Bucket
CASE
    WHEN (transaction_qty*unit_price) <= 50 then '01.Low'
    WHEN (transaction_qty*unit_price) between 51 and 200 then '02.Medium'
    WHEN (transaction_qty*unit_price) between 201 and 300 then '03.High'
   
    ELSE '04.Very High'
    END as spend_bucket,
----revenue
transaction_qty*unit_price AS REVENUE_PER_TRANS

 from workspace.default.case_study_bright_coffee_shop_analysis;
