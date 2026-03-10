-- Мета: розрахувати повну суму кожного замовлення.
-- Обчислюється загальна вартість товарів (gross_amount), сума знижки та доставка.
-- Після цього визначається фінальна сума замовлення з урахуванням знижки та доставки.
-- Враховуються лише замовлення зі статусом 'Completed'.

SELECT
  fi.order_id,
  SUM(dp.price * fi.quantity) AS gross_amount,
  SUM(dp.price * fi.quantity) * fo.discount_amount AS discount_value,
  fo.shipping_amount,
  SUM(dp.price * fi.quantity) * (1 - fo.discount_amount) + fo.shipping_amount AS total_order_amount
FROM
  fact_orders fo
  JOIN fact_order_items fi ON fo.order_id = fi.order_id
  JOIN dim_products dp ON fi.product_id = dp.product_id
WHERE
  fo.order_status = 'Completed'
GROUP BY
  fi.order_id,
  fo.discount_amount,
  fo.shipping_amount;