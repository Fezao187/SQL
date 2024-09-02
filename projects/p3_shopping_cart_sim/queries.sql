-- Create shopping cart database
CREATE DATABASE shopping_cart_db
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Create tables
-- Products table
CREATE TABLE IF NOT EXISTS public.products
(
    id serial,
    name character varying(100),
    price integer,
    PRIMARY KEY (id)
);

-- Cart table
CREATE TABLE IF NOT EXISTS public.cart
(
    product_id integer,
    qty integer
);

-- Users table
CREATE TABLE IF NOT EXISTS public.users
(
    user_id serial,
    username character varying(50),
    PRIMARY KEY (user_id)
);

-- Order Header table
CREATE TABLE IF NOT EXISTS public.order_header
(
    order_id serial,
    user_id integer,
    order_date timestamp without time zone DEFAULT current_timestamp,
    PRIMARY KEY (order_id)
);

-- Order details table
CREATE TABLE IF NOT EXISTS public.order_details
(
    order_header integer,
    prod_id integer,
    qty integer
);

-- Add foreign keys
ALTER TABLE IF EXISTS public.cart
    ADD FOREIGN KEY (product_id)
    REFERENCES public.products (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_header
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_details
    ADD FOREIGN KEY (order_header)
    REFERENCES public.order_header (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_details
    ADD FOREIGN KEY (prod_id)
    REFERENCES public.products (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

-- Insert values into tables
-- Products table
INSERT INTO products(name, price)
VALUES  ('Coke', 10),
        ('Chips', 5);

-- Users table
INSERT INTO users(username)
VALUES  ('Kristine'),
        ('Katlego');

-- Cart table
-- Add a Coke (if product exist, update qty by 1)
DO $$
    BEGIN
        IF EXISTS (SELECT * FROM cart WHERE product_id=1)
            THEN 
                UPDATE cart SET qty =qty +1 WHERE product_id =1;
            ELSE
                INSERT INTO cart(product_id,qty) VALUES (1,1);
            END IF;
    END;
$$

SELECT * FROM cart;
-- Add Chips (if product does not exist, insert with qty 1)
DO $$
    BEGIN
        IF EXISTS (SELECT * FROM cart WHERE product_id=2)
            THEN
                UPDATE cart SET qty=qty+1 WHERE product_id=2;
            ELSE
                INSERT INTO cart(product_id,qty) VALUES (2,1);
            END IF;
    END;
$$

-- Remove items from cart
-- Coke
DO $$
    BEGIN
        IF EXISTS (SELECT * FROM cart WHERE qty>1)
            THEN
                UPDATE cart SET qty=qty-1 WHERE product_id=1;
            ELSE 
                DELETE FROM cart WHERE product_id=1;
            END IF;
    END;
$$

-- Chips
DO $$
    BEGIN
        IF EXISTS (SELECT * FROM cart WHERE qty>1)
            THEN
                UPDATE cart SET qty=qty-1 WHERE product_id=2;
            ELSE 
                DELETE FROM cart WHERE product_id=2;
            END IF;
    END;
$$

-- Inser data into Order header table
INSERT INTO order_header(user_id)
VALUES  (1),
        (2);

-- Insert data into Order details
INSERT INTO order_details(order_header, prod_id, qty)
VALUES  (1,1,5),
        (2,2,4);

SELECT * FROM products;
SELECT * FROM cart;
SELECT * FROM users;
SELECT * FROM order_header;
SELECT * FROM order_details;

-- Delete cart table after order details
DELETE FROM cart;

-- Print a single order using inner join
SELECT OH.order_id, U.username, OH.order_date, P.name AS Product_Name, OD.qty
FROM order_header AS OH
INNER JOIN users AS U ON OH.user_id = U.user_id
INNER JOIN order_details AS OD ON OH.order_id = OD.order_header
INNER JOIN products AS P ON OD.prod_id = P.id
WHERE OH.order_id=2;

-- Printing all orders for a specific day shopping 
SELECT OH.order_id, U.username, OH.order_date, P.name AS Product_Name, OD.qty
FROM order_header AS OH
INNER JOIN users AS U ON OH.user_id = U.user_id
INNER JOIN order_details AS OD ON OH.order_id = OD.order_header
INNER JOIN products AS P ON OD.prod_id = P.id
WHERE DATE(OH.order_date)='2024-09-02';

-- Bonus: Creating functions for adding and removing item
-- Add function
CREATE OR REPLACE FUNCTION add_item(prod_id integer, iqty integer)
RETURNS void AS $$
BEGIN
     IF EXISTS (SELECT * FROM cart WHERE product_id=prod_id)
            THEN 
                UPDATE cart SET qty =qty +1 WHERE product_id =prod_id;
            ELSE
                INSERT INTO cart(product_id,qty) VALUES (prod_id,iqty);
            END IF;
END; $$
LANGUAGE plpgsql;

-- Test add item function
-- Add coke
SELECT add_item(1,1);
-- Add chips
SELECT add_item(2,1);

-- Remove item function
CREATE OR REPLACE FUNCTION remove_item(prod_id integer)
RETURNS void AS $$
BEGIN
    IF EXISTS (SELECT * FROM cart WHERE qty>1)
            THEN
                UPDATE cart SET qty=qty-1 WHERE product_id=prod_id;
            ELSE 
                DELETE FROM cart WHERE product_id=prod_id;
            END IF;
END; $$
LANGUAGE plpgsql;

-- Test remove item function
-- Remove coke
SELECT remove_item(1);
-- Remove chips
SELECT remove_item(2);