-- Мета: підрахувати кількість замовлень для кожного клієнта.
-- Для кожного клієнта визначається загальна кількість оформлених замовлень.
-- За допомогою CASE клієнти сегментуються на категорії: Premium, Pro або Basic.
-- Результат відсортовано за кількістю замовлень у спадному порядку.

SELECT
  dc.customer_id,
  dc.first_name,
  dc.last_name,
  COUNT(fo.order_id) AS total_orders,
  CASE
    WHEN COUNT(fo.order_id) >= 20 THEN 'Premium'
    WHEN COUNT(fo.order_id) >= 10 THEN 'Pro'
    ELSE 'Basic'
  END
FROM
  dim_customers dc
  LEFT JOIN fact_orders fo ON dc.customer_id = fo.customer_id
GROUP BY
  dc.customer_id,
  dc.first_name,
  dc.last_name
ORDER BY
  total_orders DESC;