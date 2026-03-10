-- Мета: обчислити відсоток повернених товарів (Return Rate).
-- Порівнюється кількість повернутих позицій із загальною кількістю проданих позицій.
-- LEFT JOIN використовується, щоб врахувати всі замовлені товари.
-- Результат подається у відсотках і округлюється до 2 знаків.

SELECT
  ROUND(
    COUNT(DISTINCT fr.order_item_id) * 1.0 / COUNT(DISTINCT foi.order_item_id) * 100,
    2
  ) AS return_rate_percent
FROM
  fact_order_items foi
  LEFT JOIN fact_returns fr ON fr.order_item_id = foi.order_item_id;