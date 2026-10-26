CREATE DATABASE IF NOT EXISTS stockwise_inventory CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE stockwise_inventory;

CREATE TABLE IF NOT EXISTS categories (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS products (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  category_id INT UNSIGNED NULL,
  name VARCHAR(150) NOT NULL,
  sku VARCHAR(60) NOT NULL UNIQUE,
  price DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  quantity INT UNSIGNED NOT NULL DEFAULT 0,
  reorder_level INT UNSIGNED NOT NULL DEFAULT 5,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(id) ON UPDATE CASCADE ON DELETE SET NULL,
  INDEX idx_products_name (name),
  INDEX idx_products_stock (quantity, reorder_level)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS sales (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  product_id INT UNSIGNED NOT NULL,
  quantity INT UNSIGNED NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  total DECIMAL(14,2) NOT NULL,
  sold_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_sales_product FOREIGN KEY (product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  INDEX idx_sales_sold_at (sold_at),
  INDEX idx_sales_product (product_id)
) ENGINE=InnoDB;

INSERT IGNORE INTO categories (name) VALUES ('Electronics'), ('Accessories'), ('Office Supplies'), ('General');
INSERT IGNORE INTO products (name, sku, category_id, price, quantity, reorder_level)
SELECT 'Wireless Mouse', 'ACC-001', id, 185.00, 24, 5 FROM categories WHERE name='Accessories';
INSERT IGNORE INTO products (name, sku, category_id, price, quantity, reorder_level)
SELECT 'USB-C Cable', 'ACC-002', id, 95.00, 8, 10 FROM categories WHERE name='Accessories';
INSERT IGNORE INTO products (name, sku, category_id, price, quantity, reorder_level)
SELECT 'Notebook A5', 'OFF-001', id, 35.00, 60, 12 FROM categories WHERE name='Office Supplies';
INSERT IGNORE INTO products (name, sku, category_id, price, quantity, reorder_level)
SELECT 'Bluetooth Speaker', 'ELE-001', id, 450.00, 3, 5 FROM categories WHERE name='Electronics';
