CREATE DATABASE IF NOT EXISTS appliance_db;
USE appliance_db;

-- 1. Categories Table
CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    slug VARCHAR(50) UNIQUE NOT NULL
);

-- 2. Products Table
CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    brand VARCHAR(50) NOT NULL,
    model_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    specs JSON,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 3. Analytics / User Interactions Table
CREATE TABLE IF NOT EXISTS user_interactions (
    interaction_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    action_type VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Seed Data
INSERT INTO categories (name, slug) VALUES 
('Refrigerators', 'refrigerators'),
('TVs', 'tvs'),
('Fans', 'fans'),
('Mixers', 'mixers');

INSERT INTO products (category_id, brand, model_name, price, specs) VALUES 
(1, 'Samsung', '253L 3-Star Inverter Frost-Free', 24990.00, '{"capacity": "253L", "energy_rating": "3 Star"}'),
(1, 'LG', '242L 3-Star Smart Inverter Frost-Free', 23490.00, '{"capacity": "242L", "energy_rating": "3 Star"}'),
(1, 'Whirlpool', '265L 3-Star Frost-Free Double Door', 26990.00, '{"capacity": "265L", "energy_rating": "3 Star"}'),
(1, 'Haier', '258L 3-Star Convertible Double Door', 22490.00, '{"capacity": "258L", "energy_rating": "3 Star"}'),
(2, 'Sony', 'Bravia 55-inch 4K Ultra HD Smart LED', 57990.00, '{"screen_size": "55 inch", "resolution": "4K"}'),
(2, 'LG', '43-inch Full HD Smart LED TV', 29990.00, '{"screen_size": "43 inch", "resolution": "1080p"}');
