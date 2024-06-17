-- Turn on Foreign Key
PRAGMA foreign_keys = ON;

-- #region CREATE TABLE
-- Create customers table
CREATE TABLE IF NOT EXISTS "customers" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "identity_no" INTEGER UNIQUE NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "address" TEXT NOT NULL,
    "phone_number" TEXT,
    "email" TEXT CHECK ("email" LIKE '%_@_%._%'),
    "deleted" INTEGER CHECK ("deleted" IN (0, 1)) DEFAULT 0
);

-- Create shops table
CREATE TABLE IF NOT EXISTS "shops" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "phone_number" TEXT,
    "email" TEXT CHECK ("email" LIKE '%_@_%._%'),
    "status" TEXT CHECK ("status" IN ('active', 'on renovation', 'closed'))
);

-- Create positions table
CREATE TABLE IF NOT EXISTS "positions" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- Create employees table
CREATE TABLE IF NOT EXISTS "employees" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "shop_id" INTEGER NOT NULL,
    "position_id" INTEGER NOT NULL,
    "identity_no" INTEGER UNIQUE NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "address" TEXT NOT NULL,
    "phone_number" TEXT,
    "email" TEXT CHECK ("email" LIKE '%_@_%._%'),
    "join_date" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resigned" INTEGER CHECK ("resigned" IN (0, 1)) DEFAULT 0,
    FOREIGN KEY ("shop_id") REFERENCES "shops"("id"),
    FOREIGN KEY ("position_id") REFERENCES "positions"("id")
);

-- Create brands table
CREATE TABLE IF NOT EXISTS "brands" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT UNIQUE NOT NULL,
    "status" TEXT NOT NULL CHECK ("status" IN ('active', 'inactive'))
);

-- Create products table
CREATE TABLE IF NOT EXISTS "products" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "brand_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "price" NUMERIC NOT NULL CHECK ("price" > 0),
    "year" INTEGER NOT NULL CHECK ("year" > 0),
    FOREIGN KEY ("brand_id") REFERENCES "brands"("id")
);

-- Create inventories table
CREATE TABLE IF NOT EXISTS "inventories" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "shop_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "size" NUMERIC NOT NULL CHECK ("size" BETWEEN 30 AND 55),
    "stock" INTEGER NOT NULL CHECK ("stock" >= 0) DEFAULT 0,
    FOREIGN KEY ("shop_id") REFERENCES "shops"("id"),
    FOREIGN KEY ("product_id") REFERENCES "products"("id")
);

-- Create orders table
CREATE TABLE IF NOT EXISTS "orders" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "shop_id" INTEGER NOT NULL,
    "employee_id" INTEGER NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "date" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    "number" INTEGER UNIQUE NOT NULL,
    "type" TEXT NOT NULL CHECK ("type" IN ('online', 'offline')),
    "status" TEXT NOT NULL CHECK ("type" = 'online' AND STATUS IN ('pending confirmation', 'confirmed', 'packing', 'shipped', 'delivered', 'cancelled') OR "type" = 'offline' AND "status" = 'purchased'),
    FOREIGN KEY ("shop_id") REFERENCES "shops"("id"),
    FOREIGN KEY ("employee_id") REFERENCES "employees"("id"),
    FOREIGN KEY ("customer_id") REFERENCES "customers"("id")
);

-- Create items table
CREATE TABLE IF NOT EXISTS "items" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "order_id" INTEGER NOT NULL,
    "inventory_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "total_price" NUMERIC DEFAULT 0 CHECK ("total_price" >= 0),
    FOREIGN KEY ("order_id") REFERENCES "orders"("id"),
    FOREIGN KEY ("inventory_id") REFERENCES "inventories"("id")
);
-- #endregion

-- #region CREATE VIEW
-- To create view of active customers
CREATE VIEW IF NOT EXISTS "active_customers" AS
SELECT "id", "identity_no", "first_name", "last_name"
FROM "customers"
WHERE "deleted" = 0;

-- To create view of active employees
CREATE VIEW IF NOT EXISTS "active_employees" AS
SELECT "employees"."id", "first_name", "last_name", 
"shops"."name" AS "shop_name", "positions"."name" AS "position_name", "join_date"
FROM "employees"
JOIN "shops" ON "shops"."id" = "employees"."shop_id"
JOIN "positions" ON "positions"."id" = "employees"."position_id"
WHERE "resigned" = 0;

-- To create view of active shops
CREATE VIEW IF NOT EXISTS "active_shops" AS
SELECT "id", "name", "address", "phone_number", "email"
FROM "shops"
WHERE "status" = 'active';

-- To create view of active inventory details
CREATE VIEW IF NOT EXISTS "active_inventory_details" AS
SELECT 
"inventories"."id", "shops"."name" AS "shop_name", "brands"."name" AS "brand_name", 
"products"."name" AS "product_name",
ROUND("products"."price", 2) AS "product_price", 
"inventories"."size", "inventories"."stock" 
FROM "inventories"
JOIN "shops" ON "shops"."id" = "inventories"."shop_id"
JOIN "products" ON "products"."id" = "inventories"."product_id"
JOIN "brands" ON "brands"."id" = "products"."brand_id"
WHERE "inventories"."stock" > 0;

-- To create view of invoices
CREATE VIEW IF NOT EXISTS "invoices" AS
SELECT 
"orders"."id" AS "order_id", "orders"."date" AS "order_date", "orders"."number" AS "order_number",
"shops"."name" AS "shop_name", "employees"."first_name" AS "employee_first_name",
"employees"."last_name" AS "employee_last_name", "customers"."first_name" AS "customer_first_name",
"customers"."last_name" AS "customer_last_name", "brands"."name" AS "brand_name",
"products"."name" AS "product_name", "items"."quantity", 
ROUND("items"."total_price", 2) AS "total_price"
FROM "orders"
JOIN "shops" ON "shops"."id" = "orders"."shop_id"
JOIN "employees" ON "employees"."id" = "orders"."employee_id"
JOIN "customers" ON "customers"."id" = "orders"."customer_id"
JOIN "items" ON "orders"."id" = "items"."order_id"
JOIN "inventories" ON "inventories"."id" = "items"."inventory_id"
JOIN "products" ON "products"."id" = "inventories"."product_id"
JOIN "brands" ON "brands"."id" = "products"."brand_id";

-- To create view of maximum id for order
CREATE VIEW IF NOT EXISTS "maximum_order_id" AS
SELECT MAX("id") AS "id" FROM "orders";
-- #endregion

-- #region CREATE TRIGGER
-- Create trigger when trying to delete active customers
CREATE TRIGGER IF NOT EXISTS "delete_active_customers"
INSTEAD OF DELETE ON "active_customers"
FOR EACH ROW
BEGIN
    UPDATE "customers" SET "deleted" = 1 WHERE "id" = OLD."id";
END;

-- Create trigger when trying to insert into active customer where identity no exists
CREATE TRIGGER IF NOT EXISTS "insert_active_customers_when_exists"
INSTEAD OF INSERT ON "active_customers"
FOR EACH ROW
    WHEN NEW."identity_no" IN (
        SELECT "identity_no" FROM "customers"
    )
BEGIN
    UPDATE "customers" SET "deleted" = 0 WHERE "identity_no" = NEW."identity_no";
END;

-- Create trigger when trying to insert into active customer where identity no does not exist
CREATE TRIGGER IF NOT EXISTS "insert_active_customers_when_not_exists"
INSTEAD OF INSERT ON "active_customers"
FOR EACH ROW
    WHEN NEW."identity_no" NOT IN (
        SELECT "identity_no" FROM "customers"
    )
BEGIN
    INSERT INTO "customers" ("identity_no", "first_name", "last_name", "address", "phone_number", "email")
    VALUES (NEW."identity_no", NEW."first_name", NEW."last_name", NEW."address", NEW."phone_number", NEW."email");
END;

-- Create trigger when trying to delete active employees
CREATE TRIGGER IF NOT EXISTS "delete_active_employees"
INSTEAD OF DELETE ON "active_employees"
FOR EACH ROW
BEGIN
    UPDATE "employees" SET "resigned" = 1 WHERE "id" = OLD."id";
END;

-- Create trigger when trying to insert active employees where identity no exists
CREATE TRIGGER IF NOT EXISTS "insert_active_employees_when_exists"
INSTEAD OF INSERT ON "active_employees"
FOR EACH ROW
    WHEN NEW."identity_no" IN (
        SELECT "identity_no" FROM "employees"
    )
BEGIN
    UPDATE "employees" SET "resigned" = 0 WHERE "identity_no" = NEW."identity_no";
END;

-- Create trigger when trying to insert active employees where identity no does not exist
CREATE TRIGGER IF NOT EXISTS "insert_active_employees_when_not_exists"
INSTEAD OF INSERT ON "active_employees"
FOR EACH ROW
    WHEN NEW."identity_no" NOT IN (
        SELECT "identity_no" FROM "employees"
    )
BEGIN
    INSERT INTO "employees" ("shop_id", "position_id", "identity_no", "first_name", "last_name", "address", "phone_number", "email", "join_date")
    VALUES (NEW."shop_id", NEW."position_id", NEW."identity_no", NEW."first_name", NEW."last_name", NEW."address", NEW."phone_number", NEW."email", NEW."join_date");
END;

-- Create trigger when trying to insert employee into inactive shop
CREATE TRIGGER IF NOT EXISTS "insert_employee_into_inactive_shop"
BEFORE INSERT ON "employees"
FOR EACH ROW
    WHEN NEW."shop_id" IN (
        SELECT "id" FROM "shops" WHERE "status" <> 'active'
    )
BEGIN
    SELECT RAISE(ABORT, 'Cannot add new employee to inactive shop');
END;

-- Create trigger when trying to insert order into inactive shop
CREATE TRIGGER IF NOT EXISTS "insert_order_into_inactive_shop"
BEFORE INSERT ON "orders"
FOR EACH ROW
    WHEN NEW."shop_id" IN (
        SELECT "id" FROM "shops" WHERE "status" <> 'active'
    )
BEGIN
    SELECT RAISE(ABORT, 'Cannot add new order to inactive shop');
END;

-- Create trigger when the inventory that we are trying to insert the item with has no stock
CREATE TRIGGER IF NOT EXISTS "insert_empty_stock_item"
BEFORE INSERT ON ITEMS
FOR EACH ROW
    WHEN NEW."inventory_id" IN (
        SELECT "id" FROM "inventories" WHERE "stock" = 0
    )
BEGIN
    SELECT RAISE(ABORT, 'Cannot add items when the stock is empty');
END;

-- Create trigger after trying to insert an item into the items table
CREATE TRIGGER IF NOT EXISTS "insert_item"
AFTER INSERT ON "items"
FOR EACH ROW
BEGIN
    -- Update the quantity if it exceeds the stock
    UPDATE "items"
    SET "quantity" = (
        CASE
            WHEN NEW."quantity" > (SELECT "stock" FROM "inventories" WHERE "id" = NEW."inventory_id")
            THEN (SELECT "stock" FROM "inventories" WHERE "id" = NEW."inventory_id")
            ELSE NEW."quantity"
        END
    )
    WHERE "id" = NEW."id";
    -- Update the stock in the inventories table
    UPDATE "inventories"
    SET "stock" = "stock" - (SELECT "quantity" FROM "items" WHERE "id" = NEW."id")
    WHERE "id" = NEW."inventory_id";
    -- Update the total price in the items table
    UPDATE "items"
    SET "total_price" = 
    (SELECT "price" FROM "products" WHERE "id" = (SELECT "product_id" FROM "inventories" WHERE "id" = NEW."inventory_id")) * 
    (SELECT "quantity" FROM "items" WHERE "id" = NEW."id")
    WHERE "id" = NEW."id";
END;

-- Create trigger when trying to insert item into inventory when shop is inactive
CREATE TRIGGER IF NOT EXISTS "insert_inventory_when_shop_not_active"
BEFORE INSERT ON "inventories"
FOR EACH ROW
    WHEN NEW."shop_id" IN (
        SELECT "id" FROM "shops" WHERE "status" <> 'active'
    )
BEGIN
    SELECT RAISE(ABORT, 'Cannot add new inventory to inactive shop');
END;

-- Create trigger when trying to insert inventory that existed in the table
CREATE TRIGGER IF NOT EXISTS "insert_inventory_when_exists"
BEFORE INSERT ON "inventories"
FOR EACH ROW
    WHEN EXISTS (
        SELECT "id" FROM "inventories"
        WHERE
        "product_id" = NEW."product_id" AND
        "shop_id" = NEW."shop_id" AND
        "size" = NEW."size"
    )
BEGIN
    UPDATE "inventories"
    SET "stock" = "stock" + NEW."stock"
    WHERE 
    "product_id" = NEW."product_id" AND
    "shop_id" = NEW."shop_id" AND
    "size" = NEW."size";
    SELECT RAISE(IGNORE);
END;

-- Create trigger to check if employee id is in the selected shop id before trying to insert into order
CREATE TRIGGER IF NOT EXISTS "insert_order_when_employee_not_in_shop"
BEFORE INSERT ON "orders"
FOR EACH ROW
    WHEN NEW."employee_id" NOT IN (
        SELECT "id" FROM "employees" WHERE "shop_id" = NEW."shop_id"
    )
BEGIN
    SELECT RAISE(ABORT, 'Cannot add order when selected employee is not inside in selected shop');
END;

-- Create trigger to check if shop id inserted from orders are different to the shop id in the inventories
CREATE TRIGGER IF NOT EXISTS "insert_item_when_inventory_not_in_shop"
BEFORE INSERT ON "items"
FOR EACH ROW
    WHEN 
        (SELECT "orders"."shop_id" FROM "orders" WHERE "orders"."id" = NEW."order_id") 
        <>
        (SELECT "inventories"."shop_id" FROM "inventories" WHERE "inventories"."id" = NEW."inventory_id")
BEGIN
    SELECT RAISE(ABORT, 'Cannot add item when selected order is not inside the selected shop');
END;
-- #endregion

-- #region CREATE INDEX
-- #endregion