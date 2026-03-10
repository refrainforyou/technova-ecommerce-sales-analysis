-- Мета: визначити середню вартість замовлення (Average Order Value) для кожного маркетингового каналу.
-- Для кожного замовлення обчислюється сума: (ціна * кількість) з урахуванням знижки + доставка.
-- Потім розраховується середнє значення суми замовлення для кожного marketing_channel.
-- У результаті канали сортуються за середньою вартістю замовлення у спадному порядку.

SELECT
  marketing_channel,
  ROUND(AVG(total_order_amount), 2) AS avg_order_value
FROM
  (
    SELECT
      fo.order_id,
      c.marketing_channel,
      SUM(dp.price * foi.quantity) * (1 - fo.discount_amount) + fo.shipping_amount AS total_order_amount
    FROM
      fact_orders fo
      JOIN fact_order_items foi ON foi.order_id = fo.order_id
      JOIN dim_products dp ON dp.product_id = foi.product_id
      JOIN dim_customers c ON c.customer_id = fo.customer_id
    WHERE
      fo.order_status = 'Completed'
    GROUP BY
      fo.order_id,
      c.marketing_channel,
      fo.discount_amount,
      fo.shipping_amount
  ) t
GROUP BY
  marketing_channel
ORDER BY
  avg_order_value DESC;