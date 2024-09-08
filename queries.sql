-- #region INSERT
-- Insert into customers table
INSERT INTO "customers" ("identity_no", "first_name", "last_name", "address", "phone_number", "email")
VALUES 
(10000001, 'Benjamin', 'Frank', '16 Townsville Street, California', '02177884933', 'benjamin.frank@yahoo.com'),
(10000002, 'Joseph', 'Stallion', '29 Gypsy Way, Washington DC', '02188332221', 'j_stallion@gmail.com'),
(10000003, 'Kobbie', 'Mainoo', '37 United Road, Texas', '02199774312', 'kobbie_mainoo@manutd.com'),
(10000004, 'Ash', 'Ketchum', '1 Pallet Town, Missisipi', '02177554433', 'ashketchum@gmail.com'),
(10000005, 'Lucy', 'Jones', '10 Central Park Road, Florida', '02199334422', 'lucy.j@office365.com'),
(10000006, 'Johnnie', 'Cruz', '99 Straight Street, Virginia', '02189015432', 'johnnie.cruz@blizzard.com');

-- Insert into positions table
INSERT INTO "positions" ("name")
VALUES 
('Store Cashier'),
('Store Manager'),
('Customer Service'),
('Office Boy'),
('Delivery Driver');

-- Insert into brands table
INSERT INTO "brands" ("name", "status")
VALUES 
('Nike', 'active'),
('Adidas', 'active'),
('Umbro', 'active'),
('Specs', 'active'),
('Ortuseight', 'active'),
('Shoes for Crews', 'inactive');

-- Insert into shops table
INSERT INTO "shops" ("name", "address", "phone_number", "email", "status")
VALUES
('Downtown Shoe Store', '192 Downtown Street, Florida', '02177839912', 'downtownshoestore@gmail.com', 'active'),
('West Coast Shoes', '1508 West Coast Street, Oregon', '02185493322', 'west.coast.shoes@yahoo.com', 'active'),
('East Coast Shoes', '6969 East Coast Street, New Jersey', '02148839111', 'east_coast_shoes@gmail.com', 'on renovation'),
('Checkmate Shoes', '100 Chess Road, Michigan', '02137792909', 'checkmate.shoes@gmail.com', 'active'),
('Red Army Shoes', '1997 South Park Steet, Colorado', '02139994201', 'redarmyshoes@gmail.com', 'on renovation'),
('Spongebob Shoes', '1999 Bikini Bottom Road, Burbank, California', '02148883390', 'spongebob.shoes@office365.com', 'active'),
('Gray Shoes', '1900 Gray Street, Virginia', '02137892201', 'gray_shoes@gmail.com', 'active'),
('Mr Baker Shoes and Care', '90210 Baker Street, Beverly Hills, California', '02164892202', 'mrbakershoes@gmail.com', 'active'),
('McDonalds Shoe Store', '399 McDonalds Street, California', '02157339921', 'mcdonalds_shoe_store@mcdonalds.com', 'closed');

-- Insert into employees table based on active shops provided in shops table
INSERT INTO "employees" ("shop_id", "position_id", "identity_no", "first_name", "last_name", "address", "phone_number", "email", "join_date")
VALUES
(1, 2, 20000001, 'Ralph', 'Hasenhüttl', '900 Willie Road, Indiana', '02148832091', 'ralph_hasenhuttl@office365.com', '2019-01-05'),
(1, 1, 20000002, 'Steve', 'McCoy', '162 Motor Street, Maryland', '02138492210', 'steve.mccoy@gmail.com', '2018-02-18'),
(1, 3, 20000003, 'Victor', 'Magat', '2003 Manila Road, Tennessee', '02168493300', 'victor_magat@yahoo.com', '2020-01-20'),
(2, 4, 20000004, 'Sofyan', 'Amrabat', '208 Morocco Village, Maryland', '02139940217', 'sofyan.amrabat@manutd.com', '2019-04-03'),
(2, 1, 20000005, 'Derek', 'Banas', '105 Original Recipe Street, Kentucky', '02149932022', 'derekbanas@gmail.com', '2019-04-03'),
(2, 5, 20000006, 'Eric', 'Cartman', '1998 South Park Street, Colorado', '02149192002', 'eric.cartman@gmail.com', '2020-02-10'),
(2, 2, 20000007, 'Stanley', 'Jones', '177 Mute City, Nevada', '02168492013', 'stanley_jones@yahoo.com', '2021-01-04'),
(4, 1, 20000008, 'Sauce', 'McGavin', '9620 Pallet Town, Arkansas', '02164392220', 'sauce.mcgavin@gmail.com', '2019-03-10'),
(4, 3, 20000009, 'Scott', 'Mctominay', '907 Brentford Beater Road, Kentucky', '02156492046', 'scott.mctominay@manutd.com', '2019-08-23'),
(4, 5, 20000010, 'Jemmy', 'Stevens', '911 Police Street, Louisiana', '02191100007', 'jemmy_stevens@yahoo.com', '2019-12-12'),
(6, 1, 20000011, 'Arnold', 'Phillips', '33 Broadway Road, Manhattan', '02149393099', 'arnoldphillips@gmail.com', '2020-01-29'),
(6, 2, 20000012, 'Reddy', 'Marsh', '1970 South Park Street, Colorado', '02148792665', 'randy.marsh@gmail.com', '2020-04-01'),
(6, 3, 20000013, 'Jack', 'Morrison', '247 Katy Perry Road, California', '02199403239', 'jack.morrison@yahoo.com', '2020-05-01'),
(6, 4, 20000014, 'Abraham', 'Collins', '177 Lucky Road, Idaho', '02147775399', 'abraham_collins@gmail.com', '2021-01-10'),
(6, 5, 20000015, 'Jonathan', 'Watson', '9743 Cooling Fan Street, Tennessee', '02193204112', 'jonathan_watson@gmail.com', '2020-12-10'),
(7, 1, 20000016, 'Thomas', 'Taw', '592 Road, New Hampshire', '02174003999', 'thomas.taw@gmail.com', '2019-01-30'),
(7, 2, 20000017, 'Erik', 'ten Hag', '2019 Ajax Road, Maine', '02158302211', 'erik_ten_hag@yahoo.com', '2019-04-28'),
(7, 4, 20000018, 'Daniel', 'James', '21 Carrow Street, Alabama', '02188443321', 'daniel.james@gmail.com', '2019-02-10'),
(8, 1, 20000019, 'Landon', 'Donovan', '49 Goodison Park Road, Utah', '02138989321', 'landon_donovan@gmail.com', '2021-04-17'),
(8, 2, 20000020, 'Kyle', 'Irving', '754 Hampshire Street, Oregon', '02149930199', 'kyle_irving@yahoo.com', '2021-06-01'),
(8, 3, 20000021, 'Merry', 'Hopkins', '1993 Wagon Road, Oregon', '02158843003', 'merry_hopkins@yahoo.com', '2021-06-15'),
(8, 5, 20000022, 'Tom', 'Hopkins', '1993 Wagon Road, Oregon', '02148993300', 'tom_hopkins@yahoo.com', '2021-06-15');

-- Insert into products table based on available brands
INSERT INTO "products" ("brand_id", "name", "price", "year")
VALUES
(1, 'Nike Air Jordan', 199.99, 2023),
(1, 'Nike Air Max', 249.99, 2020),
(1, 'Nike Premier 3', 150.50, 2021),
(2, 'Adidas Copa Mundial', 115.00, 1979),
(2, 'Adidas Samba', 99.99, 2020),
(2, 'Adidas Predator 30', 349.99, 2024),
(2, 'Adidas Kaiser 5', 99.99, 1990),
(3, 'Umbro Speciali Eternal', 149.99, 2020),
(3, 'Umbro Impulsa', 129.99, 2024),
(4, 'Specs Lightspeed Reborn', 39.99, 2024),
(4, 'Specs Shaman Bepe20', 59.99, 2023),
(5, 'Ortuseight Catalyst Legion v4', 44.99, 2024),
(5, 'Ortuseight Jogosala Rabona v2', 39.99, 2023),
(5, 'Ortuseight Hypersonic 1.3', 74.99, 2024),
(5, 'Ortuseight Solar', 139.99, 2024),
(5, 'Ortuseight Jogosala Avalanche Pro', 44.99, 2024);

-- Insert into inventories table
INSERT INTO "inventories" ("shop_id", "product_id", "size", "stock")
VALUES
(1, 1, 38, 4),
(1, 1, 39, 8),
(1, 1, 40, 7),
(1, 1, 41, 3),
(1, 1, 42, 9),
(1, 1, 42.5, 10),
(1, 1, 43, 6),
(1, 1, 44, 3),
(1, 5, 37, 15),
(1, 5, 38, 2),
(1, 5, 39, 4),
(1, 5, 40, 9),
(1, 5, 41, 1),
(1, 5, 42, 8),
(2, 8, 37, 9),
(2, 8, 38, 10),
(2, 8, 39, 2),
(2, 8, 40, 1),
(2, 8, 41, 7),
(2, 8, 42, 6),
(2, 8, 43, 4),
(2, 8, 44, 3),
(2, 9, 38, 1),
(2, 9, 39, 8),
(2, 9, 40, 5),
(2, 9, 40.5, 4),
(2, 9, 41, 9),
(2, 9, 42, 15),
(2, 9, 42.5, 6),
(2, 9, 43, 7),
(2, 9, 44, 5),
(4, 10, 38, 9),
(4, 10, 39, 6),
(4, 10, 40, 4),
(4, 10, 41, 2),
(4, 10, 42, 1),
(4, 10, 43, 3),
(4, 10, 44, 7),
(4, 11, 38, 5),
(4, 11, 39, 3),
(4, 11, 40, 2),
(4, 11, 41, 9),
(4, 11, 42, 4),
(4, 11, 43, 6),
(4, 11, 44, 2),
(4, 12, 38, 6),
(4, 12, 39, 3),
(4, 12, 40, 1),
(4, 12, 41, 4),
(4, 12, 42, 5),
(4, 12, 43, 2),
(4, 12, 44, 6),
(4, 13, 38, 7),
(4, 13, 39, 4),
(4, 13, 40, 3),
(4, 13, 41, 8),
(4, 13, 42, 1),
(4, 13, 43, 3),
(4, 13, 44, 4),
(6, 4, 38, 9),
(6, 4, 39, 5),
(6, 4, 40, 4),
(6, 4, 40.5, 2),
(6, 4, 41, 7),
(6, 4, 42, 3),
(6, 4, 42.5, 6),
(6, 4, 43, 2),
(6, 4, 44, 9),
(6, 4, 44.5, 1),
(6, 6, 38, 5),
(6, 6, 39, 7),
(6, 6, 40, 2),
(6, 6, 41, 1),
(6, 6, 42, 8),
(6, 6, 42.5, 3),
(6, 6, 43, 4),
(6, 6, 44, 5),
(6, 6, 45, 2),
(6, 7, 37, 3),
(6, 7, 38, 4),
(6, 7, 39, 5),
(6, 7, 40, 2),
(6, 7, 41, 8),
(6, 7, 42, 6),
(6, 7, 43, 1),
(6, 7, 44, 4),
(6, 10, 37, 9),
(6, 10, 38, 7),
(6, 10, 39, 1),
(6, 10, 40, 4),
(6, 10, 41, 10),
(6, 10, 42, 14),
(6, 10, 43, 3),
(6, 10, 44, 1),
(6, 14, 37, 5),
(6, 14, 38, 6),
(6, 14, 39, 3),
(6, 14, 40, 2),
(6, 14, 41, 12),
(6, 14, 42, 1),
(6, 14, 43, 8),
(6, 14, 44, 4),
(6, 15, 37, 6),
(6, 15, 38, 3),
(6, 15, 39, 2),
(6, 15, 40, 5),
(6, 15, 41, 8),
(6, 15, 42, 2),
(6, 15, 43, 4),
(6, 15, 44, 7),
(7, 2, 37, 4),
(7, 2, 38, 9),
(7, 2, 39, 10),
(7, 2, 40, 1),
(7, 2, 41, 7),
(7, 2, 42, 8),
(7, 2, 43, 4),
(7, 2, 44, 2),
(7, 3, 37, 8),
(7, 3, 38, 5),
(7, 3, 39, 4),
(7, 3, 40, 9),
(7, 3, 41, 3),
(7, 3, 42, 5),
(7, 3, 43, 6),
(7, 3, 44, 2),
(7, 4, 37, 2),
(7, 4, 38, 5),
(7, 4, 39, 4),
(7, 4, 40, 1),
(7, 4, 41, 8),
(7, 4, 42, 9),
(7, 4, 43, 10),
(7, 4, 44, 3),
(8, 1, 37, 5),
(8, 1, 38, 7),
(8, 1, 39, 8),
(8, 1, 40, 10),
(8, 1, 41, 12),
(8, 1, 42, 6),
(8, 1, 43, 8),
(8, 1, 44, 9),
(8, 2, 37, 1),
(8, 2, 38, 6),
(8, 2, 39, 4),
(8, 2, 40, 3),
(8, 2, 41, 1),
(8, 2, 42, 2),
(8, 2, 43, 4),
(8, 2, 44, 9),
(8, 5, 37, 1),
(8, 5, 38, 4),
(8, 5, 39, 5),
(8, 5, 40, 8),
(8, 5, 41, 3),
(8, 5, 42, 11),
(8, 5, 43, 12),
(8, 5, 44, 4),
(8, 13, 37, 1),
(8, 13, 38, 3),
(8, 13, 39, 2),
(8, 13, 40, 8),
(8, 13, 41, 9),
(8, 13, 42, 10),
(8, 13, 43, 2),
(8, 13, 44, 6);

-- Generate Invoice
INSERT INTO "orders" ("shop_id", "employee_id", "customer_id", "date", "number", "type", "status")
VALUES 
(1, 3, 3, '2024-01-03', 10000001, 'online', 'confirmed');
INSERT INTO "items" ("order_id", "inventory_id", "quantity")
VALUES 
((SELECT "id" FROM "maximum_order_id"), 4, 4),
((SELECT "id" FROM "maximum_order_id"), 13, 1);

INSERT INTO "orders" ("shop_id", "employee_id", "customer_id", "date", "number", "type", "status")
VALUES 
(4, 8, 4, '2024-02-17', 10000002, 'offline', 'purchased');
INSERT INTO "items" ("order_id", "inventory_id", "quantity")
VALUES
((SELECT "id" FROM "maximum_order_id"), 37, 2),
((SELECT "id" FROM "maximum_order_id"), 44, 3),
((SELECT "id" FROM "maximum_order_id"), 51, 1);

INSERT INTO "orders" ("shop_id", "employee_id", "customer_id", "date", "number", "type", "status")
VALUES 
(8, 19, 2, '2024-03-05', 10000003, 'online', 'confirmed');
INSERT INTO "items" ("order_id", "inventory_id", "quantity")
VALUES
((SELECT "id" FROM "maximum_order_id"), 139, 2),
((SELECT "id" FROM "maximum_order_id"), 147, 1),
((SELECT "id" FROM "maximum_order_id"), 155, 2),
((SELECT "id" FROM "maximum_order_id"), 163, 2);

INSERT INTO "orders" ("shop_id", "employee_id", "customer_id", "date", "number", "type", "status")
VALUES
(6, 13, 5, '2024-05-02', 10000004, 'online', 'confirmed');
INSERT INTO "items" ("order_id", "inventory_id", "quantity")
VALUES 
((SELECT "id" FROM "maximum_order_id"), 66, 3),
((SELECT "id" FROM "maximum_order_id"), 75, 1),
((SELECT "id" FROM "maximum_order_id"), 100, 1);

INSERT INTO "orders" ("shop_id", "employee_id", "customer_id", "date", "number", "type", "status")
VALUES
(6, 11, 1, '2024-07-01', 10000005, 'offline', 'purchased');
INSERT INTO "items" ("order_id", "inventory_id", "quantity")
VALUES
((SELECT "id" FROM "maximum_order_id"), 91, 1),
((SELECT "id" FROM "maximum_order_id"), 107, 2);

INSERT INTO "orders" ("shop_id", "employee_id", "customer_id", "date", "number", "type", "status")
VALUES
(8, 19, 6, '2024-06-18', 10000006, 'online', 'confirmed');
INSERT INTO "items" ("order_id", "inventory_id", "quantity")
VALUES
((SELECT "id" FROM "maximum_order_id"), 142, 2);

INSERT INTO "orders" ("shop_id", "employee_id", "customer_id", "date", "number", "type", "status")
VALUES
(2, 7, 4, '2024-08-08', 10000007, 'offline', 'purchased');
INSERT INTO "items" ("order_id", "inventory_id", "quantity")
VALUES 
((SELECT "id" FROM "maximum_order_id"), 22, 1),
((SELECT "id" FROM "maximum_order_id"), 142, 2);
-- #endregion

-- #region SELECT
-- Select customer by first name and last name
SELECT * FROM "customers"
WHERE "first_name" = 'Kobbie' AND "last_name" = 'Mainoo';

-- Select active shops by address
SELECT * FROM "active_shops"
WHERE "address" LIKE '%California%';

-- Select active shops by name
SELECT * FROM "active_shops"
WHERE "name" = 'Spongebob Shoes';

-- Select employees by first name and last name
SELECT "id", "first_name", "last_name", "phone_number", "join_date" 
FROM "employees"
WHERE "first_name" = 'Erik' AND "last_name" = 'ten Hag';

-- Select employees by shop name
SELECT "id", "first_name", "last_name", "phone_number", "join_date"
FROM "employees"
WHERE "shop_id" = (
    SELECT "id" FROM "shops"
    WHERE "name" = 'Gray Shoes'
);

-- Select active employees by join date
SELECT "id", "first_name", "last_name", "phone_number", "join_date"
FROM "employees"
WHERE "join_date" > DATE('2020-01-01');

-- Select products by price
SELECT "id", "name", "price", "year"
FROM "products"
WHERE "price" <= 100;

-- Select products by brand
SELECT "id", "name", "price", "year"
FROM "products"
WHERE "brand_id" = (
    SELECT "id" FROM "brands"
    WHERE "name" = 'Ortuseight'
);

-- Select active inventory details by brand name, product name and size
SELECT * 
FROM "active_inventory_details"
WHERE "brand_name" = 'Adidas' AND "product_name" = 'Adidas Copa Mundial' AND "size" = 42;

-- Select active inventory details by shop name
SELECT *
FROM "active_inventory_details"
WHERE "shop_name" IN ('Downtown Shoe Store', 'West Coast Shoes');

-- Select invoice by order number
SELECT *
FROM "invoices"
WHERE "order_number" = 10000003;

-- Select invoice by shop name
SELECT *
FROM "invoices"
WHERE "shop_name" = 'Checkmate Shoes';

-- Select invoice by employee first name and employee last name
SELECT *
FROM "invoices"
WHERE "employee_first_name" = 'Sauce' AND "employee_last_name" = 'McGavin';

-- Select invoice by customer first name and customer last name
SELECT *
FROM "invoices"
WHERE "customer_first_name" = 'Lucy' OR "customer_last_name" = 'Ketchum';
-- #endregion

-- #region UPDATE
-- Update customers data
UPDATE "customers"
SET "address" = '60 Fighting Road, Alabama'
WHERE "first_name" = 'Benjamin' AND "last_name" = 'Frank';

UPDATE "customers"
SET "email" = 'johnnie.cruz@yahoo.com', "phone_number" = '02149930019'
WHERE "first_name" = 'Johnnie' AND "last_name" = 'Cruz';

-- Update shops data
UPDATE "shops"
SET "address" = '420 Gray Rd., Arkansas', "phone_number" = '02177439812'
WHERE "name" = 'Gray Shoes';

UPDATE "shops"
SET "status" = 'active' 
WHERE "name" IN ('East Coast Shoes', 'Red Army Shoes');

-- Update employees data
UPDATE "employees"
SET "position_id" = 2
WHERE "first_name" = 'Scott' AND "last_name" = 'Mctominay';

UPDATE "employees" 
SET "address" = '45 Rodeo Rd., Nevada', "phone_number" = '02136559924'
WHERE "first_name" = 'Stanley' AND "last_name" = 'Jones';

-- Update orders data
UPDATE "orders"
SET "status" = 'packing'
WHERE "number" = 10000001;

UPDATE "orders"
SET "status" = 'shipped'
WHERE "number" = 10000001;

UPDATE "orders"
SET "status" = 'delivered'
WHERE "number" = 10000001;
-- #endregion