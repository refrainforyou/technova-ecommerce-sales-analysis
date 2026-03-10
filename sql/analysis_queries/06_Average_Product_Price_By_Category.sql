-- Мета: визначити середню ціну товарів у кожній категорії.
-- Дані агрегуються по категоріях через зв’язок товар → підкатегорія → категорія.
-- Використовується AVG() для розрахунку середньої ціни.
-- Результат округлюється до 2 знаків після коми.

SELECT
  c.category_id,
  c.category_name,
  ROUND(avg(dp.price), 2) AS avg_price
FROM
  dim_products dp
  JOIN dim_subcategories ds ON ds.subcategory_id = dp.subcategory_id
  JOIN dim_categories c ON c.category_id = ds.category_id
GROUP BY
  c.category_id,
  c.category_name;