/*Выведите поле name из таблицы Passenger.*/

SELECT name FROM Passenger;

/* Выведите поля member_id, member_name и status из таблицы FamilyMembers. */

SELECT member_id, member_name, status FROM FamilyMembers;

/* Выведите все столбцы из таблицы Payments. */

SELECT * FROM Payments;

/* Вывести только уникальные имена пассажиров, дополнив предложенный запрос. */

SELECT DISTINCT name FROM Passenger;

/* Выведите идентификаторы товаров (поле good) из таблицы Payments, стоимость которых больше 2000 единиц. Стоимость товара хранится в поле unit_price. */

SELECT good FROM Payments WHERE unit_price > 2000;

/* Выведите имена (поле member_name) членов семьи из таблицы FamilyMembers, чей статус (поле status) равен "father". */

SELECT member_name FROM FamilyMembers WHERE status = 'father';

/* Выведите имя (поле member_name) и дату рождения (поле birthday) членов семьи из таблицы FamilyMembers, чей статус (поле status) равен "father" или "mother". */

SELECT member_name, birthday FROM FamilyMembers WHERE status IN ('father', 'mother');

/* Необходимо получить все комнаты, в которых есть как кухня (поле has_kitchen), так и интернет (поле has_internet). Напишите запрос, удовлетворяющий вышеописанному условию, который выводит все поля из таблицы Rooms.
Наличие обозначается 1 или true, а отсутствие 0 или false. */

SELECT * FROM Rooms WHERE has_kitchen = true AND has_internet = true;

/* Выведите резервации комнат (поля room_id, start_date, end_date) из таблицы Reservations, у которых итоговая стоимость аренды (поле total) находится в промежутке от 500 до 1200 включительно. */

SELECT room_id, start_date, end_date FROM Reservations WHERE total BETWEEN 500 AND 1200;

/* Выведите всех членов семьи с фамилией "Quincey". */

SELECT member_name FROM FamilyMembers WHERE member_name LIKE '%Quincey';

/* Для каждого отдельного платежа выведите идентификатор товара и сумму, потраченную на него, в отсортированном по убыванию этой суммы виде. Список платежей находится в таблице Payments.
Для вывода суммы используйте псевдоним sum. */

SELECT good, amount * unit_price AS sum FROM Payments ORDER BY sum DESC;

/* Выведите список членов семьи с фамилией Quincey, в отсортированном по возрастанию столбцам status и member_name виде. */

SELECT * FROM FamilyMembers WHERE member_name LIKE '%Quincey' ORDER BY status, member_name;

/* Подсчитайте количество учеников в каждом классе, а также отсортируйте их по убыванию количества учеников. Принадлежность ученика к конкретному классу вы можете получить из таблицы Student_in_class. В качестве результата необходимо вывести идентификатор класса (поле class) и количество учеников в этом классе. Для вывода количества учеников используйте псевдоним count. */

SELECT class, count(1) AS count FROM Student_in_class GROUP BY class ORDER BY count DESC

/* Найдите самых старших членов семьи (используйте поле birthday) среди всех существующих семей на основании их статуса (поле status). Выведите статус и дату рождения. Для вывода даты рождения используйте псевдоним birthday. */

SELECT status, min(birthday) as birthday FROM FamilyMembers GROUP BY status;

/* Получите среднее время полётов, совершённых на каждой из моделей самолёта. Выведите поле plane и среднее время полёта в секундах. Для вывода времени используйте псевдоним time. Используйте функцию TIMESTAMPDIFF(second, time_out, time_in), чтобы получить разницу во времени в секундах между двумя датами. */

SELECT plane, AVG(TIMESTAMPDIFF(second, time_out, time_in)) AS time FROM Trip GROUP BY plane;

/* Выведите идентификатор комнаты (поле room_id), среднюю стоимость за один день аренды (поле price, для вывода используйте псевдоним avg_price), а также количество резерваций этой комнаты (используйте псевдоним count). Полученный результат отсортируйте в порядке убывания сначала по количеству резерваций, а потом по средней стоимости. */

SELECT room_id, avg(price) AS avg_price, COUNT(*) AS count FROM Reservations GROUP BY room_id ORDER BY count DESC, avg_price DESC;

/* Дополните запрос из предыдущего задания, оставив в выборке только те комнаты, чья средняя стоимость аренды превышает 150 ед. */

SELECT room_id, avg(price) AS avg_price, COUNT(*) AS count FROM Reservations GROUP BY room_id HAVING avg_price > 150 ORDER BY count DESC, avg_price DESC;

/* Объедините таблицы Class и Student_in_class с помощью внутреннего соединения по полям Class.id и Student_in_class.class. Выведите название класса (поле Class.name) и идентификатор ученика (поле Student_in_class.student). */

SELECT Class.name, Student_in_class.student FROM Class JOIN Student_in_class ON Class.id = Student_in_class.class

/* Дополните запрос из предыдущего задания, добавив ещё одно внутреннее соединение с таблицей Student. Объедините по полям Student_in_class.student и Student.id и вместо идентификатора ученика выведите его имя (поле first_name). */

SELECT Class.name, Student.first_name FROM Class JOIN Student_in_class ON Class.id = Student_in_class.class JOIN Student ON Student_in_class.student = Student.id;

/* Выведите названия продуктов, которые покупал член семьи со статусом "son". Для получения выборки вам нужно объединить таблицу Payments с таблицей FamilyMembers по полям family_member и member_id, а также с таблицей Goods по полям good и good_id. */

SELECT good_name FROM Payments JOIN FamilyMembers ON family_member = member_id JOIN Goods ON good = good_id WHERE status = 'son';

/* Выведите идентификатор (поле room_id) и среднюю оценку комнаты (поле rating, для вывода используйте псевдоним avg_score), составленную на основании отзывов из таблицы Reviews. Данная таблица связана с Reservations (таблица, где вы можете взять идентификатор комнаты) по полям reservation_id и Reservations.id. */

SELECT room_id, AVG(rating) as avg_score FROM Reviews JOIN Reservations ON reservation_id = Reservations.id GROUP BY room_id

/* Отсортируйте список компаний (таблица Company) по их названию в алфавитном порядке и выведите первые две записи. */

SELECT * FROM Company ORDER BY name LIMIT 2

/* Выведите начало (поле start_pair) и окончание (поле end_pair) второго и третьего занятия из таблицы Timepair. */

SELECT start_pair, end_pair FROM Timepair LIMIT 1,2;

/*  */