-- Turn on Foreign Key
PRAGMA foreign_keys = ON;

-- CREATE TABLE
CREATE TABLE IF NOT EXISTS "customers" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "identity_no" INTEGER UNIQUE NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "address" TEXT NOT NULL,
    "phone_number" TEXT,
    "email" TEXT CHECK ("email" LIKE '%_@_%._%'),
    "deleted" INTEGER CHECK ("deleted" IN (0, 1))
);

CREATE TABLE IF NOT EXISTS "shops" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "phone_number" TEXT,
    "email" TEXT CHECK ("email" LIKE '%_@_%._%'),
    "status" TEXT CHECK ("status" IN ('active', 'on renovation', 'closed'))
);

CREATE TABLE IF NOT EXISTS "positions" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "employees" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "shop_id" INTEGER NOT NULL,
    "position_id" INTEGER NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "address" TEXT NOT NULL,
    "phone_number" TEXT,
    "email" TEXT CHECK ("email" LIKE '%_@_%._%'),
    "join_date" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resigned" INTEGER CHECK ("resigned" IN (0, 1)),
    FOREIGN KEY ("shop_id") REFERENCES "shops"("id"),
    FOREIGN KEY ("position_id") REFERENCES "positions"("id")
);

CREATE TABLE IF NOT EXISTS "brands" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT UNIQUE NOT NULL,
    "status" TEXT NOT NULL CHECK ("status" IN ('active', 'inactive'))
);

CREATE TABLE IF NOT EXISTS "products" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "brand_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "price" NUMERIC NOT NULL CHECK ("price" > 0),
    "year" INTEGER NOT NULL CHECK ("year" > 0),
    FOREIGN KEY ("brand_id") REFERENCES "brands"("id")
);

CREATE TABLE IF NOT EXISTS "inventories" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "shop_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "size" NUMERIC NOT NULL CHECK ("size" BETWEEN 30 AND 55),
    "stock" INTEGER NOT NULL CHECK ("stock" >= 0),
    FOREIGN KEY ("shop_id") REFERENCES "shops"("id"),
    FOREIGN KEY ("product_id") REFERENCES "products"("id")
);

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

-- CREATE INDEX

-- CREATE TRIGGER