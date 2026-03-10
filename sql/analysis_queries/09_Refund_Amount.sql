-- Мета: обчислити загальну суму повернених товарів.
-- Враховуються всі позиції замовлень, які були повернуті клієнтами.
-- Сума повернення розраховується як (ціна товару * кількість).
-- Результат округлюється до 2 знаків після коми.

SELECT
  ROUND(SUM(dp.price * foi.quantity), 2) AS total_returns_amount
FROM
  fact_returns fr
  JOIN fact_order_items foi ON foi.order_item_id = fr.order_item_id
  JOIN dim_products dp ON dp.product_id = foi.product_id;