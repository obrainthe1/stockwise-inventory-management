# StockWise — Inventory Management System

A portfolio project built with PHP 8+, MySQL/MariaDB, PDO, HTML, CSS and JavaScript. It demonstrates relational database design, CRUD operations, inventory tracking, sales processing, low-stock alerts and reports.

## Features
- Dashboard: product count, units in stock, low-stock alerts and today's sales revenue
- Product CRUD with unique SKU and category relationship
- Category management
- Sales recording with stock validation and transactional stock deduction
- Sales history, stock valuation and sales summaries
- Searchable product list and responsive UI
- Prepared SQL statements, output escaping and CSRF protection
- Zambian Kwacha (ZMW) display

## Run locally with XAMPP
1. Install XAMPP and start Apache and MySQL.
2. Copy this repository folder into `C:\\xampp\\htdocs\\stockwise-inventory-management`.
3. Open phpMyAdmin at `http://localhost/phpmyadmin` and import `database/schema.sql`.
4. Check `config/database.php` (default XAMPP username `root`, blank password).
5. Open `http://localhost/stockwise-inventory-management/`.

## Database design
- `categories`: unique category names.
- `products`: SKU, category, price, quantity and reorder level.
- `sales`: product, quantity sold, unit price snapshot, total and timestamp.

One category can have many products; one product can have many sales. A product with recorded sales cannot be deleted, preserving transaction history.

## Example SQL
```sql
SELECT name, sku, quantity, reorder_level FROM products
WHERE quantity <= reorder_level ORDER BY quantity;

SELECT DATE(sold_at) AS sale_day, SUM(total) AS revenue FROM sales
GROUP BY DATE(sold_at) ORDER BY sale_day DESC;

SELECT p.name, p.quantity, p.price, p.quantity * p.price AS stock_value
FROM products p ORDER BY stock_value DESC;
```

## Security and scope
This is a learning/portfolio project, not production-ready business software. Production use would require authentication, role-based access, audit logging, deployment-specific secret management and testing. Sample inventory is fictional.

## Author
Obrain Ngomba — Computer Science student, University of Zambia.