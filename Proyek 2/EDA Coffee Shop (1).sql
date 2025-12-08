-- Bagaimana pola penjualan setiap bulan, dan kapan priode puncak penjualan terjadi?
SELECT FORMAT_DATE('%B', transaction_date) month,
      ROUND(SUM(sales),2) total_sales
FROM `coffee-shop-20231.coffee_shop.transactions-coffeeeshop` 
GROUP BY 1
ORDER BY 2 DESC;

-- Lokasi mana yang memiliki pendapatan terbesar dan berapa jumlah transaksi pada setiap lokasi?
SELECT store_location lokasi
      ,ROUND(SUM(sales),2) total_sale
      ,COUNT(transaction_id) jumlah_transaksi

from `coffee-shop-20231.coffee_shop.transactions-coffeeeshop`
GROUP BY 1
ORDER BY 2 DESC;

-- Kapan periode waktu yang memiliki jumlah transaksi terbanyak? 
-- time_period
SELECT 
      CASE 
        WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
        WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
        WHEN transaction_time BETWEEN '17:00:00' AND '22:00:00' THEN 'Night'
        ELSE 'Late Night'
    END time_period,
    COUNT(transaction_id) total_transaction,
    COUNT(transaction_id) / SUM(COUNT(transaction_id)) OVER() * 100 AS percentage_transaction
FROM `coffee-shop-20231.coffee_shop.transactions-coffeeeshop`
GROUP BY 1
ORDER BY 2 DESC;


-- Pada hari apa pendapatan tertinggi terjadi?
SELECT format_date('%A', transaction_date) day_name,
      ROUND(SUM(sales),2) total_sale
FROM `coffee-shop-20231.coffee_shop.transactions-coffeeeshop`
GROUP BY 1
ORDER BY 2 DESC;


-- Produk apa (category, type) yang paling laris dan memiliki kontribusi terbesar terhadap pendapatan?
-- Top 5 produk category paling laris
SELECT product_category,
      SUM(transaction_qty) total_unit
FROM `coffee-shop-20231.coffee_shop.transactions-coffeeeshop` 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Top 5 produk category dengan pendapatan terbesar
SELECT product_category,
      ROUND(SUM(sales),2) total_sales
FROM `coffee-shop-20231.coffee_shop.transactions-coffeeeshop` 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Top 10 produk type paling laris
SELECT product_type,
      SUM(transaction_qty) total_unit
FROM `coffee-shop-20231.coffee_shop.transactions-coffeeeshop` 
GROUP BY 1
ORDER BY 2 DESC;

-- Top 10 produk type dengan pendapatan terbesar
SELECT product_type,
      ROUND(SUM(sales),2) total_sales
FROM `coffee-shop-20231.coffee_shop.transactions-coffeeeshop` 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- produk type paling laris dan harga
SELECT product_type,
      unit_price,
      SUM(transaction_qty) total_unit
FROM `coffee-shop-20231.coffee_shop.transactions-coffeeeshop` 
GROUP BY 1, 2
ORDER BY 3 DESC;

