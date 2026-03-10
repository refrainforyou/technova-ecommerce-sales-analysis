-- Мета: визначити топ-10 клієнтів за доходом.
-- Для кожного клієнта обчислюється сума замовлень з урахуванням знижки.
-- Враховуються лише завершені замовлення; результат сортується за спаданням доходу.

SELECT
  fo.customer_id,
  SUM(
    dp.price * foi.quantity * (1 - fo.discount_amount)
  ) AS customer_revenue
FROM
  fact_orders fo
  JOIN fact_order_items foi ON foi.order_id = fo.order_id
  JOIN dim_products dp ON dp.product_id = foi.product_id
WHERE
  fo.order_status = 'Completed'
GROUP BY
  fo.customer_id
ORDER BY
  customer_revenue DESC
LIMIT
  10;