# Design Document

By Hansel Tertius

Video overview: <URL HERE>

## Scope

In this section you should answer the following questions:

* What is the purpose of your database?
The purpose of the database is to store data of shoe warehouse's customers, employees, shops, inventories provided by each shop including products and brands, as well as the order history and the items inside it. 

* Which people, places, things, etc. are you including in the scope of your database?
The things that are included in a database scope are:
- Customers : represents customers that are included in the shoe warehouse order history.
- Shops : represents list of branches provided in a shoe warehouse.
- Positions : represents list of job title available for an employee that is working in a shop.
- Employees : represents list of employees working in a shop.
- Brands : represents manufacturer of a shoe.
- Products : represents a shoe model that is associated with a brand.
- Inventories : represents list of stocks in a product.
- Orders : represents status of a purchase made by customer.
- Items : represents a list of items purchased in a order.

* Which people, places, things, etc. are *outside* the scope of your database?
The things that are not included in a database scope are:
- membership system for a customers to receive special promotions and benefits.
- list of suppliers
- list of active promotions for products, shops or even customers.

## Functional Requirements

In this section you should answer the following questions:

* What should a user be able to do with your database?
In the database, a user should be able to :
- Add, update and delete customers, shops, employees, positions, brands, products, inventories, orders and items
- Search for specific customers by first name and last name
- Search for specific active employees by first name, last name, shop where the employees are working as well as the join date
- Manage active employees data that are working in a shoe warehouse by changing shop where the employees are working, promote / demote specific employee, update resign status
- Search products by brands and price
- Manage available products in a shop
- Search active inventories by brands, products, size as well as shop name
- Manage active inventories, such as adding a new product to the shop or restock an existing product
- Generate invoices based on orders and items generated inside the order

* What's beyond the scope of what a user should be able to do with your database?
In the database, a user should not be able to :
- Inserting duplicate customer data, where database can check the identity no of newly created customer
- Inserting duplicate employee data, where database can check the identity no of newly created employee
- Trying to insert item into inventory in an inactive shop
- Trying to insert order where the employee is not in selected shop
- Trying to insert item into the order when the item retrieved from inventory is out of stock
- Trying to insert item into the order when the item retrieved from inventory is not in selected shop


## Representation

### Entities

In this section you should answer the following questions:

* Which entities will you choose to represent in your database?
* What attributes will those entities have?
* Why did you choose the types you did?
* Why did you choose the constraints you did?

Customers:
- "id" : specifies the id of a customer, where the type is INTEGER and the constraint is PRIMARY KEY since the value must be unique and AUTOINCREMENT to make the id to continue on increasing even when the customer has been deleted from the table.
- "identity_no" : specifies the identity number of a customer, where the type is INTEGER as we only accept number and we have UNIQUE and NOT NULL constraint where we cannot accept duplicate identity no
- "first_name" : specifies the first name of a customer, where the type is TEXT and we need to fill the name as we have NOT NULL constraint 
- "last_name" : specifies the last name of a customer, where the type is TEXT and we don't have NOT NULL constraint as some names only have the first name
- "address" : specifies the address of a customer where we accept strings in a form of TEXT and we need to input the value as the field has NOT NULL constraint 
- "phone_number" : specifies the phone number of a customer, where we can accept value like + sign that makes the field to have TEXT type
- "email" : specifies the email of a customer, where we have TEXT type and check for valid email through CHECK constraint using '%_@_%._%'
- "deleted" : specifies the deleted customer status, where boolean in SQLite can only accept integer of 0 - 1, which makes the type of INTEGER. Also, we have CHECK constraint if the value is either 0 or 1 and DEFAULT value of 0.

Shops:
- "id" : specifies the id of a shop, where the type is INTEGER and the constraint is PRIMARY KEY since the value must be unique and AUTOINCREMENT to make the id to continue on increasing even when the shop has been deleted from the table
- "name" : specifies the name of a shop, where the type is TEXT and we need to fill out the value by NOT NULL constraint
- "address" : specifies the address of a shop, where we accept TEXT data type and has NOT NULL constraint as it is required field
- "phone_number" : specifies the phone number of a shop, where we accept the TEXT data type since we can accept values like + sign
- "email" : specifies the email of a shops, where we have TEXT type and check for valid email through CHECK constraint using '%_@_%._%'
- "status" : specifies the status of a shop where the value accepts TEXT data type and we only accept 'active', 'on renovation', 'closed' value through CHECK constraint

Positions:
- "id" : specifies the id of a position, where the type is INTEGER and the constraint is PRIMARY KEY since the value must be unique and AUTOINCREMENT to make the id to continue on increasing even when the shop has been deleted from the table
- "name" : specifies the name of a position, where we accept string as a value through TEXT and it is a required field through NOT NULL constraint

Employees:
- "id" : specifies the id of an employee, where the type is INTEGER and the constraint is PRIMARY KEY since the value must be unique and AUTOINCREMENT to make the id to continue on increasing even when the employee has been deleted from the table
- "shop_id" : specifies the id of a shop that an employee works with, where the type is INTEGER. The constraint is FOREIGN KEY where we referenced from id attribute in shops table, and we have NOT NULL constraint as we need a reference value
- "position_id" : specifies the id of a current position that an employee holds, where the type is INTEGER. The constraint of the column is FOREIGN KEY where we referenced from id attribute in positions table, and we have NOT NULL constraint as we need a reference value
- "identity_no" : specifies the identity no of an employee, where the type is INTEGER as we only accept number and we have UNIQUE and NOT NULL constraint where we cannot accept duplicate identity no
- "first_name" : specifies the first name of an employee, where the type is TEXT as we accept string values in a name and we have NOT NULL constraint as the field is required
- "last_name" : specifies the last name of an employee, where the type is TEXT as we accept string values, we don't have NOT NULL constraint as some names only have the first name
- "address" : specifies the address of an employee, where we accept TEXT data type and has NOT NULL constraint as it is required field
- "phone_number" : specifies the phone number of an employee, where we accept the TEXT data type since we can accept values like + sign
- "email" : specifies the email address of an employee, where we have TEXT type and check for valid email through CHECK constraint using '%_@_%._%'
- "join_date" : specifies the join date of an employee, where we have NUMERIC data type as SQLite cannot accept DATETIME data type, the field is mandatory so that we have NOT NULL constraint and default value of CURRENT_TIMESTAMP with specifies the time where the data is created.
- "resigned" : specifies whether the employee has resigned. The accepted data type is INTEGER as SQLite does not support boolean data type, where we only input 0 and 1 through CHECK constraint. By using DEFAULT constraint, it specifies that the default value is 0.

Brands:
- "id" : specifies the id of a brand, where the type is INTEGER and the constraint is PRIMARY KEY since the value must be unique and AUTOINCREMENT to make the id to continue on increasing even when the brand has been deleted from the table
- "name" : specifies the name of a brand, where the type is TEXT and the field is required and there is no duplicate values as brand is related to the trademark, which makes UNIQUE and NOT NULL constraint to be installed
- "status" : specifies the status of a brand, where the typs is TEXT as well as the value is required (NOT NULL constraint). However, we limit the value into 'active' and 'inactive' through CHECK constraint

Products:
- "id" : specifies the id of a product, where the type is INTEGER and the constraint is PRIMARY KEY since the value must be unique and AUTOINCREMENT to make the id to continue on increasing even when the brand has been deleted from the table
- "brand_id" : specifies the id of a brand that a product holds, where the type is INTEGER. The constraint of the column is FOREIGN KEY where we referenced from id attribute in brands table, and we have NOT NULL constraint as we need a reference value
- "name" : specifies the name of a product, where we accept the string value in a form of TEXT. The field is mandatory as we have NOT NULL constraint in the column
- "price" : specifies the price of a product, where we have the NUMERIC data type as the value can hold decimal place. In terms of price, we cannot accept 0 / negative value as we have CHECK if the price is more than 0
- "year" : specifies the year where the product is produced, where we accept the INTEGER data type and we cannot have 0 / negative value by having a CHECK constraint where the price is more than 0

Inventories:
- "id" : specifies the id of a inventory, where the type is INTEGER and the constraint is PRIMARY KEY since the value must be unique and AUTOINCREMENT to make the id to continue on increasing even when the brand has been deleted from the table
- "shop_id" : specifies the id of a shop that an inventory has, where the type is INTEGER. The constraint of the column is FOREIGN KEY where we referenced from id attribute in shops table, and we have NOT NULL constraint as we need a reference value
- "product_id" : specifies the id of a product that an inventory has, where the type is INTEGER. The constraint of the column is FOREIGN KEY where we referenced from id attribute in products table, and we have NOT NULL constraint as we need a reference value
- "size" : specifies the size of a shoe, where the data type is NUMERIC since shoe size has decimal values and the range is BETWEEN 30 to 55
- "stock" : specifies the stock of a shoe, where the data type is INTEGER, we cannot have negative value in stock as we have CHECK constraint to see if the stock is more than or equal to 0. The default value of a stock is 0.

Orders:
- "id" : specifies the id of an order, where the type is INTEGER and the constraint is PRIMARY KEY since the value must be unique and AUTOINCREMENT to make the id to continue on increasing even when the order has been deleted from the table
- "shop_id" : specifies the id of a shop that an order has, where the type is INTEGER. The constraint of the column is FOREIGN KEY where we referenced from id attribute in shops table, and we have NOT NULL constraint as we need a reference value
- "employee_id" : specifies the id of a employee that an order has, where the type is INTEGER. The constraint of the column is FOREIGN KEY where we referenced from id attribute in employees table, and we have NOT NULL constraint as we need a reference value
- "customer_id" : specifies the id of a customer that an order has, where the type is INTEGER. The constraint of the column is FOREIGN KEY where we referenced from id attribute in customers table, and we have NOT NULL constraint as we need a reference value
- "date" : represents date where the order is created. We have NUMERIC data type as SQLite cannot accept DATETIME data type, the field is mandatory so that we have NOT NULL constraint and default value of CURRENT_TIMESTAMP with specifies the time where the data is created.
- "number" : represents order number where the type is INTEGER. The value of order number must be unique to identify the order and it must be filled, which makes UNIQUE and NOT NULL constraint applied.
- "type" : specifies the type of the order where the data type is TEXT, we need to have the value of either 'online' or 'offline' using CHECK constraint and the value must be filled, which makes NOT NULL constraint reasonable.
- "status" : specifies the status of the order where the data type is TEXT and we need to have the value of :
a. if the type is 'online', then we have CHECK constraints where the accepted values are : 'pending confirmation', 'confirmed', 'packing', 'shipped', 'delivered', 'cancelled'
b. if the type is 'offline', then we have CHECK constraints where the accepted value is only 'purchased'

Items:
- "id" : specifies the id of an item, where the type is INTEGER and the constraint is PRIMARY KEY since the value must be unique and AUTOINCREMENT to make the id to continue on increasing even when the item has been deleted from the table
- "order_id" : specifies the id of a order that an item has, where the type is INTEGER. The constraint of the column is FOREIGN KEY where we referenced from id attribute in orders table, and we have NOT NULL constraint as we need a reference value
- "inventory_id" : specifies the id of a inventory that an item has, where the type is INTEGER. The constraint of the column is FOREIGN KEY where we referenced from id attribute in inventories table, and we have NOT NULL constraint as we need a reference value
- "quantity" : specifies the quantity of an item, where the type is INTEGER as we don't accept decimal values and we have NOT NULL constraint
- "total_price" : specifies the total price of an item where the type is NUMERIC as we accept decimal values and we have the default value of 0 using DEFAULT constraint and we don't accept negative values by using CHECK constraint if the value is more than or equal to 0.

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

## Optimizations

In this section you should answer the following questions:

* Which optimizations (e.g., indexes, views) did you create? Why?

Indexes


Views

active_customers:
a. to look at which customers that are currently active in database of a shoe outlet.

active_employees:
a. to look at which employees that are currently working in a selected shop
b. to look at job title for each employee

active_shops:
We create view active_shops to :
a. look at which shops in an outlet that is currently open
b. to determine whether or not we need to add employee into the shop

active_inventory_details:
The reason for creating active_inventory_details is to look at which products that are currently in stock, as well as which
shops that sell that product.

invoices:
We need to create invoices as a view to look at the order details of a purchase in the shoe outlet
for few reasons:
a. to look at the trends of best selling brands or product
b. to look at which customer shops the most in each store
c. to look at which shop has the most / least customers
d. as a proof of customer that purchases the item in the shop

maximum_order_id:
The reason for installing view maximum_order_id is when we try to create order for receipt 
and at the same time we need to purchase shoe(s) into the items table that is in the same order.

Triggers

delete_active_customers:
This trigger is to set value of deleted from an item in customers table into 1 instead as we cannot directly delete data from views.

insert_active_customers_when_exists:
This trigger is to update the deleted value to 0 from an item in customers table if identity_no that we entered exists in customers table.

insert_active_customers_when_not_exists:
This trigger is to insert active customer into customers table when identity_no that we entered does not exist in customers table.

delete_active_employees:
This trigger is to set value of deleted from an item in employees table into 1 instead as we cannot directly delete data from views.

insert_active_employees_when_exists:
This trigger is to update the deleted value to 0 from an item in employees table if identity_no that we entered exists in employees table.

insert_active_employees_when_not_exists:
This trigger is to update the deleted value to 0 from an item in employees table if identity_no that we entered exists in employees table.

insert_employee_into_inactive_shop:
This trigger is to prevent on inserting an employee into inactive shop by checking if the status from the shop table based on selected shop_id is not 'active'.

insert_order_into_inactive_shop:
This trigger is to prevent on inserting an order into inactive shop by by checking if the status from the shop table based on selected shop_id is not 'active'.

insert_order_when_employee_not_in_shop:
This trigger is to prevent on inserting an order when the selected employee_id is not found in the shop.

insert_empty_stock_item:
This trigger is to prevent on inserting an item from the inventories if the stock from the item is 0 based on the selected inventory_id.

insert_item:
After inserting an item into the items table, we need to:
a. Set the quantity based on 2 conditions:
i. If quantity on items exceed stock from the selected inventories table:
set the selected quantity based on stock from the inventories table
ii. If quantity on items does not exceed stock from the selected inventories table: set the selected quantity from items
b. Subtracts the stock in the inventories table by the quantity of selected instance from items table and using inventory_id to find the selected inventory.
c. Update the total price in the items table by :
i. multiply price from the selected product_id times 
ii. the quantity of item based on id.

insert_item_when_inventory_not_in_shop:
This trigger is to prevent on inserting an item when selected shop_id from orders is not the same as selected shop_id from inventories. In other words, we cannot purchase an item that is not found in the shop that we currently ordered.

insert_inventory_when_shop_not_active:
This trigger is to prevent on inserting an inventory into inactive shop by by checking if the status from the shop table based on selected shop_id is not 'active'.

insert_inventory_when_exists:
This trigger is to update the stock of inventory if the product_id, shop_id as well as the size of the instance in inventories that we want to insert actually exists in the database.

## Limitations

In this section you should answer the following questions:

* What are the limitations of your design?
* What might your database not be able to represent very well?

The limitation in this database are:
- order tracking number to track the current location of an item if a customer does order online.
- the condition to handle when an employee rejoins in the same shop_id.
- the condition to handle multiple customers in an order. In other words, handling a group order.