-- Мета: обчислити загальний дохід інтернет-магазину.
-- Для кожного замовлення розраховується сума: (ціна * кількість) з урахуванням знижки + доставка.
-- У підзапиті агрегується сума по кожному замовленню.
-- Враховуються лише замовлення зі статусом 'Completed'.

SELECT SUM(total_order_amount) AS total_revenue
FROM (
    SELECT
        fo.order_id,
        SUM(dp.price * fi.quantity) * (1 - fo.discount_amount)
        + fo.shipping_amount AS total_order_amount
    FROM fact_orders fo
    JOIN fact_order_items fi ON fo.order_id = fi.order_id
    JOIN dim_products dp ON fi.product_id = dp.product_id
    WHERE fo.order_status = 'Completed'
    GROUP BY fo.order_id, fo.discount_amount, fo.shipping_amount
) t;