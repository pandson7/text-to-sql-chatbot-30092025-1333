-- Text-to-SQL Database Schema and Sample Data

-- Create tables
CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2)
);

-- Insert sample products
INSERT INTO products (product_name, category, price) VALUES
('iPhone 15 Pro', 'Electronics', 999.99),
('MacBook Air M2', 'Electronics', 1199.99),
('AirPods Pro', 'Electronics', 249.99),
('iPad Air', 'Electronics', 599.99),
('Apple Watch Series 9', 'Electronics', 399.99),
('Nike Air Max', 'Footwear', 129.99),
('Adidas Ultraboost', 'Footwear', 179.99),
('Levi''s 501 Jeans', 'Clothing', 89.99),
('North Face Jacket', 'Clothing', 199.99),
('Ray-Ban Sunglasses', 'Accessories', 149.99),
('Samsung Galaxy S24', 'Electronics', 899.99),
('Sony WH-1000XM5', 'Electronics', 399.99),
('Dell XPS 13', 'Electronics', 1099.99),
('Canon EOS R5', 'Electronics', 3899.99),
('Nintendo Switch', 'Electronics', 299.99),
('Kindle Paperwhite', 'Electronics', 139.99),
('Fitbit Charge 5', 'Electronics', 179.99),
('Bose QuietComfort', 'Electronics', 329.99),
('GoPro Hero 12', 'Electronics', 499.99),
('Tesla Model Y Accessories', 'Automotive', 299.99);

-- Insert sample customers
INSERT INTO customers (customer_name, email) VALUES
('John Smith', 'john.smith@email.com'),
('Sarah Johnson', 'sarah.johnson@email.com'),
('Michael Brown', 'michael.brown@email.com'),
('Emily Davis', 'emily.davis@email.com'),
('David Wilson', 'david.wilson@email.com'),
('Lisa Anderson', 'lisa.anderson@email.com'),
('Robert Taylor', 'robert.taylor@email.com'),
('Jennifer Martinez', 'jennifer.martinez@email.com'),
('William Garcia', 'william.garcia@email.com'),
('Jessica Rodriguez', 'jessica.rodriguez@email.com'),
('Christopher Lee', 'christopher.lee@email.com'),
('Amanda White', 'amanda.white@email.com'),
('Matthew Harris', 'matthew.harris@email.com'),
('Ashley Clark', 'ashley.clark@email.com'),
('Daniel Lewis', 'daniel.lewis@email.com');

-- Insert sample orders (spread across different months)
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
-- Recent orders (last month)
(1, CURRENT_DATE - INTERVAL '5 days', 1449.98),
(2, CURRENT_DATE - INTERVAL '8 days', 249.99),
(3, CURRENT_DATE - INTERVAL '12 days', 1299.98),
(4, CURRENT_DATE - INTERVAL '15 days', 729.98),
(5, CURRENT_DATE - INTERVAL '18 days', 399.99),
(6, CURRENT_DATE - INTERVAL '22 days', 179.99),
(7, CURRENT_DATE - INTERVAL '25 days', 1099.99),
(8, CURRENT_DATE - INTERVAL '28 days', 649.98),

-- Previous month orders
(9, CURRENT_DATE - INTERVAL '35 days', 999.99),
(10, CURRENT_DATE - INTERVAL '42 days', 1549.98),
(11, CURRENT_DATE - INTERVAL '48 days', 329.99),
(12, CURRENT_DATE - INTERVAL '52 days', 899.99),
(13, CURRENT_DATE - INTERVAL '58 days', 439.98),
(14, CURRENT_DATE - INTERVAL '62 days', 179.99),
(15, CURRENT_DATE - INTERVAL '65 days', 1199.99),

-- Older orders (2-3 months ago)
(1, CURRENT_DATE - INTERVAL '75 days', 599.99),
(3, CURRENT_DATE - INTERVAL '82 days', 249.99),
(5, CURRENT_DATE - INTERVAL '88 days', 1099.99),
(7, CURRENT_DATE - INTERVAL '95 days', 399.99),
(9, CURRENT_DATE - INTERVAL '102 days', 149.99),
(2, CURRENT_DATE - INTERVAL '108 days', 3899.99),
(4, CURRENT_DATE - INTERVAL '115 days', 299.99),
(6, CURRENT_DATE - INTERVAL '122 days', 139.99);

-- Insert order items
INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
-- Order 1: iPhone + MacBook
(1, 1, 1, 999.99, 999.99),
(1, 2, 1, 1199.99, 1199.99),

-- Order 2: AirPods
(2, 3, 1, 249.99, 249.99),

-- Order 3: MacBook + AirPods
(3, 2, 1, 1199.99, 1199.99),
(3, 3, 1, 249.99, 249.99),

-- Order 4: iPad + Apple Watch
(4, 4, 1, 599.99, 599.99),
(4, 5, 1, 399.99, 399.99),

-- Order 5: Apple Watch
(5, 5, 1, 399.99, 399.99),

-- Order 6: Adidas shoes
(6, 7, 1, 179.99, 179.99),

-- Order 7: Dell laptop
(7, 13, 1, 1099.99, 1099.99),

-- Order 8: North Face + Jeans
(8, 9, 1, 199.99, 199.99),
(8, 8, 1, 89.99, 89.99),

-- Order 9: iPhone
(9, 1, 1, 999.99, 999.99),

-- Order 10: MacBook + iPad
(10, 2, 1, 1199.99, 1199.99),
(10, 4, 1, 599.99, 599.99),

-- Order 11: Bose headphones
(11, 18, 1, 329.99, 329.99),

-- Order 12: Samsung Galaxy
(12, 11, 1, 899.99, 899.99),

-- Order 13: Sony headphones + Fitbit
(13, 12, 1, 399.99, 399.99),
(13, 17, 1, 179.99, 179.99),

-- Order 14: Adidas shoes
(14, 7, 1, 179.99, 179.99),

-- Order 15: MacBook
(15, 2, 1, 1199.99, 1199.99),

-- Order 16: iPad
(16, 4, 1, 599.99, 599.99),

-- Order 17: AirPods
(17, 3, 1, 249.99, 249.99),

-- Order 18: Dell laptop
(18, 13, 1, 1099.99, 1099.99),

-- Order 19: Apple Watch
(19, 5, 1, 399.99, 399.99),

-- Order 20: Ray-Ban sunglasses
(20, 10, 1, 149.99, 149.99),

-- Order 21: Canon camera
(21, 14, 1, 3899.99, 3899.99),

-- Order 22: Nintendo Switch
(22, 15, 1, 299.99, 299.99),

-- Order 23: Kindle
(23, 16, 1, 139.99, 139.99);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_orders_order_date ON orders(order_date);
CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_order_items_product_id ON order_items(product_id);
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);

-- Create a view for order analytics
CREATE OR REPLACE VIEW order_analytics AS
SELECT 
    o.order_id,
    o.order_date,
    c.customer_name,
    c.email,
    p.product_name,
    p.category,
    oi.quantity,
    oi.unit_price,
    oi.total_price,
    o.total_amount as order_total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- Sample queries for testing
-- Most selling products in last month:
-- SELECT p.product_name, SUM(oi.quantity) as total_sold 
-- FROM order_items oi 
-- JOIN products p ON oi.product_id = p.product_id 
-- JOIN orders o ON oi.order_id = o.order_id 
-- WHERE o.order_date >= CURRENT_DATE - INTERVAL '30 days' 
-- GROUP BY p.product_id, p.product_name 
-- ORDER BY total_sold DESC LIMIT 5;

-- Revenue by category:
-- SELECT p.category, SUM(oi.total_price) as total_revenue 
-- FROM order_items oi 
-- JOIN products p ON oi.product_id = p.product_id 
-- GROUP BY p.category 
-- ORDER BY total_revenue DESC;

-- Top customers by spending:
-- SELECT c.customer_name, SUM(o.total_amount) as total_spent 
-- FROM customers c 
-- JOIN orders o ON c.customer_id = o.customer_id 
-- GROUP BY c.customer_id, c.customer_name 
-- ORDER BY total_spent DESC LIMIT 10;