-- Мета: визначити підкатегорії товарів із доходом понад 100 000 у 2025 році.
-- Дохід розраховується як (ціна * кількість) з урахуванням знижки + доставка.
-- Враховуються лише завершені замовлення за період 2025 року.
-- У результаті відображаються підкатегорії з revenue ≥ 100000, відсортовані за спаданням.

SELECT
  sub.subcategory_name,
  SUM(
    dp.price * foi.quantity * (1 - fo.discount_amount) + fo.shipping_amount
  ) AS revenue_2025
FROM
  fact_orders fo
  JOIN fact_order_items foi ON foi.order_id = fo.order_id
  JOIN dim_products dp ON dp.product_id = foi.product_id
  JOIN dim_subcategories sub ON sub.subcategory_id = dp.subcategory_id
WHERE
  fo.order_status = 'Completed'
  AND fo.order_date >= '2025-01-01'
  AND fo.order_date < '2026-01-01'
GROUP BY
  sub.subcategory_name
HAVING
  SUM(
    dp.price * foi.quantity * (1 - fo.discount_amount) + fo.shipping_amount
  ) >= 100000
ORDER BY
  revenue_2025 DESC;