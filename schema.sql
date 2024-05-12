-- Turn on Foreign Key
PRAGMA foreign_keys = ON;

-- CREATE TABLE
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

-- CREATE VIEW
-- To create view of active customers
CREATE VIEW IF NOT EXISTS "active_customers" AS
SELECT "id", "identity_no", "first_name", "last_name"
FROM "customers"
WHERE "deleted" = 0;

-- To create view of active employees
CREATE VIEW IF NOT EXISTS "active_employees" AS
SELECT "id", "shop_id", "position_id", "first_name", "last_name", "join_date"
FROM "employees"
WHERE "resigned" = 0;

-- To create view of active shops
CREATE VIEW IF NOT EXISTS "active_shops" AS
SELECT "id", "name", "address", "phone_number", "email"
FROM "shops"
WHERE "status" = 'active';

-- To create view of active inventory details
CREATE VIEW IF NOT EXISTS "active_inventory_details" AS
SELECT 
"inventories"."id", "brands"."name" AS "brand_name", 
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
"orders"."id", "orders"."date" AS "order_date", "orders"."number" AS "order_number",
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

-- CREATE INDEX

-- CREATE TRIGGER