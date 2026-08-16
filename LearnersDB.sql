Create database if not exists LearnersDB;
use LearnersDB;

Create table if not exists Learners ( 
learner_id int primary key, 
Full_name varchar(100), 
Country varchar(100));

Create table if not exists Courses ( 
Course_id int Primary key, 
Course_name varchar(100), 
Category varchar(100), 
Unit_price int);

Create table if not exists Purchase ( 
Purchase_id int, 
learner_id int, 
Course_id int,
 Quantity int, 
 Purchase_date date);

Alter table purchase 
Add constraint fk_Learners 
foreign key (learner_id)  references Learners (learner_id), 
Add constraint fk_Courses foreign key (Course_id)  references Courses(course_id);

Insert into Learners (learner_id,full_name,Country) 
values 
 (101,"Gopi","India"),
 (102,"Nagesh","China"),
 (103,"Divya","UAE"),
 (104,"Priya","South Korea"),
 (105,"Husna","Japan");

Insert into Courses (Course_id,course_name,Category,Unit_price)
 Values 
 (106,"Python programming","Programming",50000),
 (107,"Data analyst","Data science",60000),
 (108,"Graphic design","Design",70000),
 (109,"Digital marketing","Marketing",80000),
 (110,"Financial accounting","Finance",90000);

insert into Purchase (purchase_id,learner_id,course_id,quantity,purchase_date) 
values
 (11,101,106,1,"2025/01/01"),
 (12,102,107,2,"2025/01/02"),
 (13,103,108,2,"2025/01/03"),
 (14,104,109,1,"2025/01/04"),
 (15,105,110,1,"2025/01/05"),
 (16,103,108,2,"2025/01/06"),
 (17,104,106,2,"2025/01/07");

select full_name,purchase_date 
 from learners inner join purchase on learners.learner_id = purchase.learner_id;

select full_name,course_name,purchase_date
 from Learners inner join purchase on learners.learner_id = purchase.learner_id 
 inner join courses on purchase.course_id = courses.course_id;

select full_name as learner_name,course_name,category,quantity * unit_price as Total_amount,purchase_date  
from learners  inner join purchase on learners.learner_id = purchase.learner_id 
join courses on purchase.course_id = courses.course_id;

select full_name as learner_name,course_name,category, 
format (quantity * unit_price,2) as Total_amount,purchase_date  from learners  
inner join purchase on learners.learner_id = purchase.learner_id 
join courses on purchase.course_id = courses.course_id 
order by total_amount desc;

select full_name as learner_name,Country,sum(quantity*unit_price) as total_spending
from learners join purchase on learners.learner_id = purchase.learner_id
join courses on purchase.course_id = courses.course_id
group by learner_name,country;

select course_name,sum(quantity) as total_quantity from courses,purchase
where purchase.course_id = courses.course_id
group by course_name
order by total_quantity
desc limit 3;

SELECT category,SUM(quantity * unit_price) AS total_revenue,
    COUNT(DISTINCT learner_id) AS unique_learners
FROM courses, purchase
WHERE courses.course_id = purchase.course_id
GROUP BY category; 

SELECT full_name AS learner_name,COUNT(DISTINCT category) AS category_count
FROM learners, courses, purchase
WHERE learners.learner_id = purchase.learner_id
AND purchase.course_id = courses.course_id
GROUP BY learners.learner_id, full_name
HAVING COUNT(DISTINCT category) > 1;

select purchase_id,course_name,courses.course_id,quantity from courses 
left join purchase on purchase.course_id = courses.course_id 
where purchase.quantity is null;

SELECT l.full_name AS learner_name,SUM(p.quantity * c.unit_price) AS total_spending
FROM learners l
JOIN purchase p 
ON l.learner_id = p.learner_id
JOIN courses c 
ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name
HAVING SUM(p.quantity * c.unit_price) > (
SELECT AVG(learner_total)FROM (
SELECT learner_id,SUM(quantity * unit_price) AS learner_total
FROM purchase
JOIN courses 
ON purchase.course_id = courses.course_id
GROUP BY learner_id) AS spending);

SELECT course_name,category,unit_price 
FROM courses
WHERE unit_price > ANY (
SELECT unit_price 
FROM courses WHERE Category = "Beginner");

SELECT DISTINCT category
FROM courses;

SELECT l.full_name AS learner_name,l.country,SUM(p.quantity * c.unit_price) AS total_spending
FROM learners l
JOIN purchase p 
ON l.learner_id = p.learner_id
JOIN courses c 
ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name, l.country
HAVING SUM(p.quantity * c.unit_price) > (
SELECT AVG(learner_total)
FROM (
SELECT l2.learner_id,l2.country,
SUM(p2.quantity * c2.unit_price) AS learner_total
FROM learners l2
JOIN purchase p2 
ON l2.learner_id = p2.learner_id
JOIN courses c2 
ON p2.course_id = c2.course_id
WHERE l2.country = l.country
GROUP BY l2.learner_id, l2.country) AS country_spending);

WITH learner_spending AS (SELECT l.full_name AS learner_name,SUM(p.quantity * c.unit_price) AS total_spending
FROM learners l
JOIN purchase p 
ON l.learner_id = p.learner_id
JOIN courses c 
ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name)
SELECT learner_name,total_spending
FROM learner_spending
WHERE total_spending > 10000;

SELECT l.full_name AS learner_name,SUM(p.quantity * c.unit_price) AS total_spending,
CASE
WHEN SUM(p.quantity * c.unit_price) > 15000 THEN 'High Value'
WHEN SUM(p.quantity * c.unit_price) >= 8000 THEN 'Medium Value'
ELSE 'Low Value'
END AS spending_category
FROM learners l
JOIN purchase p 
ON l.learner_id = p.learner_id
JOIN courses c 
ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name;

SELECT c.course_name,
IFNULL(COUNT(p.purchase_id), 0) AS purchase_count
FROM courses c
LEFT JOIN purchase p
ON c.course_id = p.course_id
GROUP BY c.course_id, c.course_name;

CREATE VIEW category_performance_view AS
SELECT c.category,SUM(p.quantity * c.unit_price) AS total_revenue,
COUNT(p.purchase_id) AS number_of_purchases,
SUM(p.quantity * c.unit_price) / COUNT(p.purchase_id) AS average_revenue_per_purchase
FROM courses c
JOIN purchase p
ON c.course_id = p.course_id
GROUP BY c.category;

SELECT *
FROM category_performance_view;





