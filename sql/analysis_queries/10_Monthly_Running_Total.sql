-- Мета: обчислити щоденний дохід та накопичений дохід за місяці року.
-- Для кожного замовлення розраховується сума з урахуванням знижки та доставки.
-- Накопичений дохід обчислюється за допомогою віконної функції SUM() OVER PARTITION BY YEAR.

SELECT
  order_date,
  ROUND(SUM(order_amount), 2) AS daily_revenue,
  ROUND(
    SUM(SUM(order_amount)) OVER (
      PARTITION BY YEAR(order_date)
      ORDER BY
        MONTH(order_date)
    ),
    2
  ) AS running_total_revenue
FROM
  (
    SELECT
      fo.order_id,
      fo.order_date,
      SUM(dp.price * foi.quantity) * (1 - fo.discount_amount) + fo.shipping_amount AS order_amount
    FROM
      fact_orders fo
      JOIN fact_order_items foi ON foi.order_id = fo.order_id
      JOIN dim_products dp ON dp.product_id = foi.product_id
    WHERE
      fo.order_status = 'Completed'
    GROUP BY
      fo.order_id,
      fo.order_date,
      fo.discount_amount,
      fo.shipping_amount
  ) t
GROUP BY
  order_date
ORDER BY
  order_date;
