/* 1. БД «Комп. фірма». Отримати інформацію про всі принтери, які не є
матричними та коштують менше 300 дол. Вихідні дані впорядкувати
за спаданням за стовпцем type.*/

SELECT type, price 
FROM labor_sql.printer
WHERE type != 'Matrix' AND price < 300
ORDER BY type DESC;

/* 2. БД «Кораблі». З таблиці Ships вивести назви кораблів та роки їх
спущення на воду, назва яких не закінчується на літеру 'a'. */

SELECT name, launched
FROM labor_sql.ships
WHERE name NOT LIKE '%a';

/* 3. БД «Комп. фірма». Вкажіть виробника для тих ПК, що мають
жорсткий диск об’ємом не більше 8 Гбайт. Вивести: maker, type,
speed, hd. */

SELECT distinct hd, speed, maker, type
FROM product JOIN pc ON product.model = pc.model
WHERE hd <= 8;

/* 4. БД «Комп. фірма». Знайдіть виробників, що випускають одночасно
ПК та ноутбуки (використати операцію IN). Вивести maker. */

SELECT DISTINCT maker FROM product 
WHERE type NOT IN (
	SELECT type FROM product WHERE type = 'Laptop') 
    AND type IN (SELECT type FROM product WHERE type = 'PC');

/* 5. БД «Кораблі». Вкажіть назву, країну та число гармат кораблів, що були пошкоджені в битвах. 
Вивести: ship, country, numGuns. */

SELECT outcomes.ship, ships.country, ships.numGuns 
FROM outcomes
LEFT JOIN (
	SELECT ships.name, classes.country, classes.numGuns FROM ships
    INNER JOIN classes ON ships.class = classes.class
)
AS ships ON outcomes.ship = ships.name
WHERE result = 'damaged';

/* 6. БД «Кораблі». З таблиці Battles виведіть дати в такому форматі:
рік.число_місяця.день, наприклад, 2001.02.21 (без формату часу). */ 

SELECT date_format(date, '%Y.%d.%m') as date FROM battles;

/* 7. БД «Комп. фірма». Знайдіть виробників найдешевших кольорових
принтерів. Вивести: maker, price.*/

SELECT DISTINCT maker, price
FROM printer INNER JOIN product ON printer.model = product.model
WHERE price = (
	SELECT MIN(price) FROM printer 
	WHERE color = 'y') AND color = 'y';

/* 8. БД «Комп. фірма». Знайдіть середній розмір жорсткого диску ПК
кожного з тих виробників, які випускають також і принтери. Вивести:
maker, середній розмір жорсткого диску. (Підказка: використовувати
підзапити в якості обчислювальних стовпців) */

SELECT maker, AVG(hd)
FROM product INNER JOIN pc ON product.model = pc.model
WHERE maker IN (
	SELECT maker FROM product 
    WHERE type = 'Printer')
GROUP BY maker;

/* 9. БД «Кораблі». Визначити назви всіх кораблів із таблиці Ships, які
задовольняють, у крайньому випадку, комбінації будь-яких чотирьох
критеріїв із наступного списку: numGuns=12, bore=16,
displacement=46000, type='bc', country='Gt.Britain', launched=1941,
class='North Carolina'. Вивести: name, numGuns, bore, displacement,
type, country, launched, class. */

SELECT name FROM (
	SELECT name, numGuns, bore, displacement, type, country, launched, classes.class,
    (numGuns=12) + (bore=16) + (displacement=46000) + (type='bc') + (country='Gt.Britain') + 
	(launched=1941) + (classes.class='North Carolina') AS n
    FROM ships JOIN classes ON ships.class = classes.class) AS x
WHERE n >= 4;

/* 10. БД «Кораблі». Знайдіть назви всіх кораблів із БД, про які можна
однозначно сказати, що вони були спущені на воду до 1942 р. Виве-
сти: назву кораблів. (Підказка: використовувати оператор UNION ) */

SELECT name FROM ships
WHERE launched < 1942
GROUP BY name
UNION
SELECT DISTINCT ship FROM outcomes
WHERE ship IN (SELECT name FROM ships);
