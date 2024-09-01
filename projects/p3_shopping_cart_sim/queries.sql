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
    qty integer,
    PRIMARY KEY (product_id)
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
    REFERENCES public.cart (product_id) MATCH SIMPLE
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
VALUES  --(2,1,1)
        (3,2,1);

DELETE FROM cart WHERE product_id=1;