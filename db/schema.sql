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
  meatid INT REFERENCES meat(meatid) ON DELETE CASCADE,
  breadid INT REFERENCES bread(breadid) ON DELETE CASCADE,
  doneness text NOT NULL
);





-- JOIN TABLES

CREATE TABLE order_cheese (
  orderid INT REFERENCES orders(orderid) ON DELETE CASCADE,
  cheeseid INT REFERENCES cheese(cheeseid) ON DELETE CASCADE
);

CREATE TABLE order_topping (
  orderid INT REFERENCES orders(orderid) ON DELETE CASCADE,
  toppingid INT REFERENCES topping(toppingid) ON DELETE CASCADE
);
