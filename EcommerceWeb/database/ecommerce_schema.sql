-- E-Commerce Database Schema
-- Create database
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- Users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address TEXT,
    phone VARCHAR(20),
    role ENUM('customer', 'admin') DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    category VARCHAR(100),
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Cart items table
CREATE TABLE cart_items (
    cart_item_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_product (user_id, product_id)
);

-- Orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    shipping_address TEXT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Order items table
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,   
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Insert default admin user (password: admin123)
INSERT INTO users (username, email, password, full_name, role) VALUES 
('admin', 'admin@ecommerce.com', 'admin123', 'Administrator', 'admin');

-- Insert sample products
INSERT INTO products (name, description, price, stock, category, image_url) VALUES
('Laptop Computer', 'High-performance laptop for work and gaming', 999.99, 10, 'Electronics', 'https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg'),
('Smartphone', 'Latest smartphone with advanced features', 699.99, 25, 'Electronics', 'https://images.pexels.com/photos/607812/pexels-photo-607812.jpeg'),
('T-Shirt', 'Comfortable cotton t-shirt', 19.99, 50, 'Clothing', 'https://images.pexels.com/photos/1020585/pexels-photo-1020585.jpeg'),
('Jeans', 'Classic blue jeans', 49.99, 30, 'Clothing', 'https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg'),
('Programming Book', 'Learn Java programming', 39.99, 20, 'Books', 'https://images.pexels.com/photos/159711/books-bookstore-book-reading-159711.jpeg'),
('Coffee Maker', 'Automatic coffee maker for home', 89.99, 15, 'Home', 'https://images.pexels.com/photos/324028/pexels-photo-324028.jpeg'),
('Headphones', 'Wireless noise-canceling headphones', 199.99, 40, 'Electronics', 'https://images.pexels.com/photos/3394650/pexels-photo-3394650.jpeg'),
('Running Shoes', 'Comfortable running shoes', 79.99, 35, 'Clothing', 'https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg');

-- Create indexes for better performance
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_cart_items_user_id ON cart_items(user_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);