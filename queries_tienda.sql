USE tienda;
-- Query #1: name of products on the product table.
SELECT nombre FROM producto;

-- Query #2: name and prices of products on the product table. 
SELECT nombre, precio FROM producto;

-- Query #3: all collumns from product table. 
SELECT * FROM producto;

-- Query #4: name of products, prices € and $.
SELECT nombre, precio, precio * 1.08 AS precio_usd FROM producto;

-- Query #5: product names, prices in euros, and prices in US dollars (USD). Using the following column aliases: product name, euros, dollars.
SELECT nombre AS 'nombre de producto', precio AS euros, precio * 1.08 AS dolares FROM producto;

-- Query #6: names and prices of all products in the product table, converting the names to uppercase.
SELECT UPPER(nombre), precio FROM producto;

-- Query #7: names and prices of all products in the product table, converting the names to lowercase.
SELECT LOWER(nombre), precio FROM producto;

-- Query #8: Listing all manufacturers' names in one column, and in another column capitalize the first two characters of the manufacturer's name.
SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) AS iniciales FROM fabricante;

-- Query #9: names and prices of all products in the product table, rounding the price value.
SELECT nombre, ROUND(precio) FROM producto;

-- Query #10: names and prices of all products in the product table, truncating the price value to display it without any decimal places.
SELECT nombre, TRUNCATE(precio, 0) FROM producto;

-- Query #11: codes of the manufacturers that have products in the product table.
SELECT codigo_fabricante FROM producto;

-- Query #12: codes of the manufacturers that have products in the product table, eliminating any codes that appear repeatedly.
SELECT DISTINCT codigo_fabricante FROM producto;

-- Query #13: names of manufacturers in ascending order.
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- Query #14: names of manufacturers in descending order.
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- Query #15: product names sorted, first by name in ascending order, and second by price in descending order.
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- Query #16: list with the first 5 rows of the manufacturer table.
SELECT * FROM fabricante LIMIT 5;

-- Query #17: list with two rows starting from the fourth row of the manufacturer table. The fourth row also are included.
SELECT * FROM fabricante LIMIT 3, 2;

-- Query #18: name and price of the cheapest product. (Using only the ORDER BY and LIMIT clauses).
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- Query #19: name and price of the most expensive product. (Using only the ORDER BY and LIMIT clauses).
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- Query #20: names of all products from the manufacturer whose manufacturer code is equal to 2.
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- Query #21: list with the product name, price, and manufacturer name of all products in the database.
SELECT p.nombre AS 'Nombre Producto', p.precio, f.nombre AS 'Nombre Fabricante'
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- Query #22: Returns a list containing the product name, price, and manufacturer name of all products in the database. Sorting the result by manufacturer name, alphabetically.
SELECT p.nombre AS 'Nombre Producto', p.precio, f.nombre AS 'Nombre Fabricante'
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY f.nombre ASC;

-- Query #23:list of the product code, product name, manufacturer code, and manufacturer name for all products in the database. 
SELECT p.codigo AS 'Código Producto', p.nombre AS 'Nombre Producto', f.codigo AS 'Código Fabricante', f.nombre AS 'Nombre Fabricante'
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- Query #24: product name, its price, and the name of its manufacturer, of the cheapest product.
SELECT p.nombre AS 'Nombre Producto', p.precio, f.nombre AS 'Nombre Fabricante'
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio ASC
LIMIT 1;

-- Query #25: product name, its price, and the name of its manufacturer, for the most expensive product.
SELECT p.nombre AS 'Nombre Producto', p.precio, f.nombre AS 'Nombre Fabricante'
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio DESC
LIMIT 1;

-- Query #26: list of all products from the manufacturer Lenovo.
SELECT p.nombre AS 'Nombre Producto', p.precio
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo';

-- Query #27: list of all products from the manufacturer Crucial that have a price greater than €200.
SELECT p.nombre AS 'Nombre Producto', p.precio, f.nombre AS 'Nombre Fabricante'
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Crucial' AND p.precio > 200;

-- Query #28: list of all products from the manufacturers Asus, Hewlett-Packard, and Seagate. Without using the IN operator.
SELECT p.nombre AS 'Nombre Producto', f.nombre AS 'Nombre Fabricante'
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';

-- Query #29: list of all products from the manufacturers Asus, Hewlett-Packard, and Seagate. Using the IN operator.
SELECT p.nombre AS 'Nombre Producto', f.nombre AS 'Nombre Fabricante'
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- Query #30: list with the name and price of all products from manufacturers whose name ends with the vowel e.
SELECT p.nombre AS 'Nombre Producto', p.precio, f.nombre AS 'Nombre Fabricante'
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%e';

-- Query #31: list with the name and price of all products whose manufacturer name contains the character w in its name.
SELECT p.nombre AS 'Nombre Producto', p.precio, f.nombre AS 'Nombre Fabricante'
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%w%';

-- Query #32: list with the product name, price, and manufacturer name of all products with a price greater than or equal to €180. 
-- Sorting the result first by price (in descending order) and second by name (in ascending order).
SELECT p.nombre AS 'Nombre Producto', p.precio, f.nombre AS 'Nombre Fabricante'
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;


