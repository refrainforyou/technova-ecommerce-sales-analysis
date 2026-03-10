-- Мета: визначити 10 найбільш продаваних товарів.
-- Для кожного товару обчислюється загальна кількість проданих одиниць.
-- Використовується RANK() для ранжування товарів за обсягом продажів.
-- У результаті відбираються лише товари з топ-10 за кількістю продажів.

SELECT
  *
FROM
  (
    SELECT
      p.product_name,
      SUM(foi.quantity) AS total_sold,
      RANK() OVER (
        ORDER BY
          SUM(foi.quantity) DESC
      ) AS product_rank
    FROM
      fact_order_items foi
      JOIN dim_products p ON foi.product_id = p.product_id
    GROUP BY
      p.product_name
  ) ranked_products
WHERE
  product_rank <= 10;