INSERT INTO meat (type) VALUES ('Bison');
INSERT INTO meat (type) VALUES ('Ground Brisket');
INSERT INTO meat (type) VALUES ('Angus');
INSERT INTO meat (type) VALUES ('Elk');
INSERT INTO meat (type) VALUES ('Bison');
INSERT INTO meat (type) VALUES ('Pork Belly');
INSERT INTO meat (type) VALUES ('Pulled Pork');
INSERT INTO bread (type) VALUES ('Brioche');
INSERT INTO bread (type) VALUES ('Whole Wheat');
INSERT INTO bread (type) VALUES ('White Sesame');
INSERT INTO bread (type) VALUES ('Brioche');
INSERT INTO bread (type) VALUES ('White');
INSERT INTO bread (type) VALUES ('Focacchia');
INSERT INTO bread (type) VALUES ('');
INSERT INTO cheese (type) VALUES ('Muenster');
INSERT INTO cheese (type) VALUES ('Swiss');
INSERT INTO cheese (type) VALUES ('Blue');
INSERT INTO cheese (type) VALUES ('American');
INSERT INTO cheese (type) VALUES ('Cheddar');
INSERT INTO cheese (type) VALUES ('Queso Blanco');
INSERT INTO cheese (type) VALUES ('Emmentaler');
INSERT INTO cheese (type) VALUES ('');
INSERT INTO topping (type) VALUES ('Tomatoes');
INSERT INTO topping (type) VALUES ('Caramelized Onions');
INSERT INTO topping (type) VALUES ('Dijon Mustard');
INSERT INTO topping (type) VALUES ('Lettuce');
INSERT INTO topping (type) VALUES ('Pickles');
INSERT INTO topping (type) VALUES ('Bacon');
INSERT INTO topping (type) VALUES ('Hash Browns');
INSERT INTO topping (type) VALUES ('Fried Egg');
INSERT INTO topping (type) VALUES ('Grilled Onions');
INSERT INTO topping (type) VALUES ('Ketchup');
INSERT INTO topping (type) VALUES ('Maple Syrup');
INSERT INTO topping (type) VALUES ('Sunny Side Up Egg');
INSERT INTO topping (type) VALUES ('Pickled Jalpenos');
INSERT INTO topping (type) VALUES ('Roasted Red Peppers');
INSERT INTO topping (type) VALUES ('Massaged Kale');
INSERT INTO topping (type) VALUES ('Red Onions');
INSERT INTO topping (type) VALUES ('');
INSERT INTO orders (meatid, breadid , doneness) VALUES (1, 1, 'Medium Rare');
INSERT INTO orders (meatid, breadid , doneness) VALUES (2, 2, 'Well Done');
INSERT INTO orders (meatid, breadid , doneness) VALUES (3, 3, 'Medium');
INSERT INTO orders (meatid, breadid , doneness) VALUES (4, 4, 'Rare');
INSERT INTO orders (meatid, breadid , doneness) VALUES (2, 5, 'Well Done');
INSERT INTO orders (meatid, breadid , doneness) VALUES (3, 3, 'Rare');
INSERT INTO orders (meatid, breadid , doneness) VALUES (6, 1, 'Medium Rare');
INSERT INTO orders (meatid, breadid , doneness) VALUES (7, 2, 'Rare');
INSERT INTO orders (meatid, breadid , doneness) VALUES (3, 3, 'Medium');
INSERT INTO orders (meatid, breadid , doneness) VALUES (1, 6, 'Medium Rare');
INSERT INTO order_topping (orderid, toppingid) VALUES (1, 1);
INSERT INTO order_topping (orderid, toppingid) VALUES (1, 2);
INSERT INTO order_topping (orderid, toppingid) VALUES (1, 3);
INSERT INTO order_topping (orderid, toppingid) VALUES (2, 4);
INSERT INTO order_topping (orderid, toppingid) VALUES (2, 1);
INSERT INTO order_topping (orderid, toppingid) VALUES (2, 5);
INSERT INTO order_topping (orderid, toppingid) VALUES (3, 6);
INSERT INTO order_topping (orderid, toppingid) VALUES (3, 11);
INSERT INTO order_topping (orderid, toppingid) VALUES (3, 8);
INSERT INTO order_topping (orderid, toppingid) VALUES (3, 9);
INSERT INTO order_topping (orderid, toppingid) VALUES (3, 10);
INSERT INTO order_topping (orderid, toppingid) VALUES (4, 1);
INSERT INTO order_topping (orderid, toppingid) VALUES (4, 16);
INSERT INTO order_topping (orderid, toppingid) VALUES (4, 3);
INSERT INTO order_topping (orderid, toppingid) VALUES (5, 4);
INSERT INTO order_topping (orderid, toppingid) VALUES (5, 5);
INSERT INTO order_topping (orderid, toppingid) VALUES (6, 6);
INSERT INTO order_topping (orderid, toppingid) VALUES (6, 7);
INSERT INTO order_topping (orderid, toppingid) VALUES (6, 8);
INSERT INTO order_topping (orderid, toppingid) VALUES (6, 9);
INSERT INTO order_topping (orderid, toppingid) VALUES (6, 10);
INSERT INTO order_topping (orderid, toppingid) VALUES (7, 1);
INSERT INTO order_topping (orderid, toppingid) VALUES (7, 4);
INSERT INTO order_topping (orderid, toppingid) VALUES (7, 3);
INSERT INTO order_topping (orderid, toppingid) VALUES (8, 4);
INSERT INTO order_topping (orderid, toppingid) VALUES (8, 1);
INSERT INTO order_topping (orderid, toppingid) VALUES (8, 8);
INSERT INTO order_topping (orderid, toppingid) VALUES (9, 6);
INSERT INTO order_topping (orderid, toppingid) VALUES (9, 11);
INSERT INTO order_topping (orderid, toppingid) VALUES (9, 8);
INSERT INTO order_topping (orderid, toppingid) VALUES (9, 9);
INSERT INTO order_topping (orderid, toppingid) VALUES (9, 10);
INSERT INTO order_topping (orderid, toppingid) VALUES (10, 11);
INSERT INTO order_topping (orderid, toppingid) VALUES (10, 12);
INSERT INTO order_topping (orderid, toppingid) VALUES (10, 13);
INSERT INTO order_topping (orderid, toppingid) VALUES (10, 14);
INSERT INTO order_topping (orderid, toppingid) VALUES (10, 15);
INSERT INTO order_topping (orderid, toppingid) VALUES (10, 3);
INSERT INTO order_cheese (orderid, cheeseID) VALUES (1, 1);
INSERT INTO order_cheese (orderid, cheeseID) VALUES (2, 2);
INSERT INTO order_cheese (orderid, cheeseID) VALUES (2, 3);
INSERT INTO order_cheese (orderid, cheeseID) VALUES (3, 4);
INSERT INTO order_cheese (orderid, cheeseID) VALUES (4, 2);
INSERT INTO order_cheese (orderid, cheeseID) VALUES (4, 5);
INSERT INTO order_cheese (orderid, cheeseID) VALUES (5, 5);
INSERT INTO order_cheese (orderid, cheeseID) VALUES (6, 4);
INSERT INTO order_cheese (orderid, cheeseID) VALUES (7, 1);
INSERT INTO order_cheese (orderid, cheeseID) VALUES (8, 6);
INSERT INTO order_cheese (orderid, cheeseID) VALUES (9, 4);
INSERT INTO order_cheese (orderid, cheeseID) VALUES (10, 7);












select
  orderid,
  doneness,
  meat_type,
  bun_type,
  cheeses,
  array_agg(t.type) as toppings
from (

  select
    o.orderid,
    o.doneness,
    meat.type as meat_type,
    bread.type as bun_type,
    array_agg(c.type) as cheeses
  from orders o

  -- get the meats using meatid on both sides
  left join meat using (meatid)

  -- get the buns using bunid on both sides
  left join bread using (breadid)

  -- use an inner join here because we only care about OUR orders/cheeses
  inner join order_cheese oc using(orderid)

  -- left join here because we want to capture orders w/o cheese
  left join cheese c using (cheeseid)

  group by (o.orderid, o.doneness,  meat.type, bread.type)
  order by o.orderid

) as justCheese

-- use an inner join here because we only care about OUR orders/cheeses
inner join order_topping ot using(orderid)

-- left join here because we want to capture orders w/o topping
left join topping t using (toppingid)

group by orderid, doneness, meat_type, bun_type, cheeses
order by justCheese.orderid


