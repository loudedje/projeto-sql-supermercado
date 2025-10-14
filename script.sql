CREATE SCHEMA IF NOT EXISTS analytics;



CREATE TABLE analytics.Stores (
    store_id SERIAL PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    neighborhood VARCHAR(100)
);

CREATE TABLE analytics.Suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255)
);

CREATE TABLE analytics.Customers (
    customer_id SERIAL PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    city VARCHAR(100),
    birth_date DATE
);

CREATE TABLE analytics.Dim_Date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
    day_of_week VARCHAR(20) NOT NULL,
    is_weekend BOOLEAN NOT NULL,
    is_holiday BOOLEAN NOT NULL
);

CREATE TABLE analytics.Employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    region VARCHAR(100),
    store_id INT NOT NULL,
    CONSTRAINT fk_employee_store
        FOREIGN KEY(store_id) 
        REFERENCES analytics.Stores(store_id)
);

CREATE TABLE analytics.Products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    brand VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT,
    supplier_id INT,
    CONSTRAINT fk_product_supplier
        FOREIGN KEY(supplier_id) 
        REFERENCES analytics.Suppliers(supplier_id)
);



CREATE TABLE analytics.Sales_Header (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    store_id INT NOT NULL,
    date_key INT NOT NULL,
    sale_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_receipt_value DECIMAL(10, 2),

    CONSTRAINT fk_sale_customer FOREIGN KEY(customer_id) REFERENCES analytics.Customers(customer_id),
    CONSTRAINT fk_sale_employee FOREIGN KEY(employee_id) REFERENCES analytics.Employees(employee_id),
    CONSTRAINT fk_sale_store FOREIGN KEY(store_id) REFERENCES analytics.Stores(store_id),
    CONSTRAINT fk_sale_date FOREIGN KEY(date_key) REFERENCES analytics.Dim_Date(date_key)
);

CREATE TABLE analytics.Sales_Items (
    sale_item_id SERIAL PRIMARY KEY,
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_sale DECIMAL(10, 2) NOT NULL,
    total_item_value DECIMAL(10, 2) NOT NULL,

    CONSTRAINT fk_item_sale_header FOREIGN KEY(sale_id) REFERENCES analytics.Sales_Header(sale_id),
    CONSTRAINT fk_item_product FOREIGN KEY(product_id) REFERENCES analytics.Products(product_id)
);
