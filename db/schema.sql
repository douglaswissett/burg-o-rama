<<<<<<< HEAD
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS meat;
DROP TABLE IF EXISTS bread;
DROP TABLE IF EXISTS topping;
DROP TABLE IF EXISTS cheese;
DROP TABLE IF EXISTS order_topping;
DROP TABLE IF EXISTS order_cheese;






CREATE TABLE cheese (
  cheeseid SERIAL UNIQUE PRIMARY KEY,
  type text NOT NULL
);

CREATE TABLE topping (
  toppingid SERIAL UNIQUE PRIMARY KEY,
  type text NOT NULL
);

CREATE TABLE meat (
  meatid SERIAL UNIQUE PRIMARY KEY,
  type text NOT NULL
);

CREATE TABLE bread (
  breadid SERIAL UNIQUE PRIMARY KEY,
  type text NOT NULL
);







-- ORDERS MAIN TABLE

CREATE TABLE orders (
  orderid SERIAL UNIQUE PRIMARY KEY,
  meatid INT REFERENCES meat(meatid),
  breadid INT REFERENCES bread(breadid),
  doneness text NOT NULL
);





-- JOIN TABLES

CREATE TABLE order_cheese (
  orderid INT REFERENCES orders(orderid),
  cheeseid INT REFERENCES cheese(cheeseid)
);

CREATE TABLE order_topping (
  orderid INT REFERENCES orders(orderid),
  toppingid INT REFERENCES topping(toppingid)
=======
DROP TABLE if exists cheeses CASCADE;
DROP TABLE if exists toppings CASCADE;
DROP TABLE if exists buns CASCADE;
DROP TABLE if exists meats CASCADE;
DROP TABLE if exists orders CASCADE;
DROP TABLE if exists cheeses_orders_join CASCADE;
DROP TABLE if exists toppings_orders_join CASCADE;

CREATE TABLE cheeses (
       cheese_id serial PRIMARY KEY UNIQUE,
       name VARCHAR(255),
       country VARCHAR(255)
);

CREATE TABLE toppings (
  topping_id serial PRIMARY KEY UNIQUE,
  name VARCHAR(255),
  type VARCHAR(255)
);

CREATE TABLE buns (
  bun_id serial PRIMARY KEY UNIQUE,
  name VARCHAR(255),
  gluten_free BOOLEAN
);

CREATE TABLE meats(
  meat_id serial PRIMARY KEY UNIQUE,
  name VARCHAR(255),
  type VARCHAR(255)
);

CREATE TABLE orders(
  order_id serial PRIMARY KEY UNIQUE,
  meat_id  integer REFERENCES meats,
  bun_id integer REFERENCES buns,
  doneness VARCHAR(255)
);

CREATE TABLE cheeses_orders_join (
       order_id integer REFERENCES orders,
       cheese_id integer REFERENCES cheeses,
       PRIMARY KEY (order_id, cheese_id)
);

CREATE TABLE toppings_orders_join (
       order_id integer REFERENCES orders,
       topping_id integer REFERENCES toppings,
       PRIMARY KEY (order_id, topping_id)
>>>>>>> 01bc190ac044b746dcf24c30e5bf4120a351ac26
);
