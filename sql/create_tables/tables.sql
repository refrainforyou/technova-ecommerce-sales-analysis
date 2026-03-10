-- Таблиця клієнтів
CREATE TABLE dim_customers (
    customer_id SERIAL PRIMARY KEY,
    birth_date DATE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    country VARCHAR(50),
    city VARCHAR(50),
    marketing_channel VARCHAR(50),
    device_type VARCHAR(30)
);

-- Таблиця категорій
CREATE TABLE dim_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- Таблиця підкатегорій
CREATE TABLE dim_subcategories (
    subcategory_id SERIAL PRIMARY KEY,
    subcategory_name VARCHAR(50) NOT NULL,
    category_id INT REFERENCES dim_categories(category_id)
);

-- Таблиця продуктів
CREATE TABLE dim_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    subcategory_id INT REFERENCES dim_subcategories(subcategory_id),
    brand VARCHAR(50),
    price NUMERIC(10,2),
    cost NUMERIC(10,2)
);

-- Таблиця замовлень
CREATE TABLE fact_orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES dim_customers(customer_id),
    order_date DATE NOT NULL,
    discount_amount NUMERIC(12,2),
    shipping_amount NUMERIC(12,2),
    order_status VARCHAR(20),
    payment_type VARCHAR(30)
);

-- Таблиця позицій замовлень
CREATE TABLE fact_order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES fact_orders(order_id),
    product_id INT REFERENCES dim_products(product_id),
    quantity INT
);

-- Таблиця повернень
CREATE TABLE fact_returns (
    return_id SERIAL PRIMARY KEY,
    order_item_id INT REFERENCES fact_order_items(order_item_id),
    return_date DATE NOT NULL,
    return_reason VARCHAR(100)
);