# 📊 E-Learning Platform Analytics using MySQL

## 📌 Project Overview

This project is an end-to-end **SQL Data Analytics project** developed using **MySQL** to analyse learner behaviour, course performance, purchase transactions, revenue generation, and category-level performance in an e-learning platform.

The project starts with relational database design and sample data creation, followed by data analysis using SQL queries. Various SQL techniques such as **JOINs, aggregate functions, subqueries, correlated subqueries, CTEs, CASE expressions, NULL handling, and Views** were implemented to answer real-world business questions.

The objective is to transform transactional data into meaningful insights that can support **learner segmentation, course optimisation, marketing strategies, cross-selling, and revenue growth**.

---

## 🎯 Project Objectives

The major objectives of this project are:

- Design and create a structured relational database using MySQL.
- Store learner, course, and purchase transaction information.
- Analyse learner purchasing behaviour and spending patterns.
- Identify the most frequently purchased courses.
- Analyse category-wise revenue and learner participation.
- Identify high-value learners based on spending.
- Find learners purchasing courses from multiple categories.
- Identify courses with no purchase activity.
- Compare learner spending with overall and country-level averages.
- Apply advanced SQL concepts to solve analytical business problems.
- Create a reusable SQL View for category performance reporting.
- Generate actionable business recommendations from the analysis.

---

# 🗂️ Database Architecture

The database is named:

`LearnersDB`

The database contains three primary relational tables.

## 👩‍🎓 1. Learners

The `learners` table stores information about learners registered on the platform.

| Column | Data Type | Description |
|---|---|---|
| learner_id | INT | Unique identifier for each learner |
| full_name | VARCHAR | Full name of the learner |
| country | VARCHAR | Country associated with the learner |

---

## 📚 2. Courses

The `courses` table contains information about the courses available on the platform.

| Column | Data Type | Description |
|---|---|---|
| course_id | INT | Unique identifier for each course |
| course_name | VARCHAR | Name of the course |
| category | VARCHAR | Category of the course |
| unit_price | DECIMAL | Price of the course |

---

## 🛒 3. Purchase

The `purchase` table records learner transactions.

| Column | Data Type | Description |
|---|---|---|
| purchase_id | INT | Unique transaction identifier |
| learner_id | INT | Reference to the learner |
| course_id | INT | Reference to the course |
| quantity | INT | Number of courses purchased |
| purchase_date | DATE | Date of purchase |

---

# 🔗 Database Relationships

The database follows a relational structure where the `purchase` table acts as a transaction table connecting learners and courses.

```text
             ┌─────────────────┐
             │     Learners    │
             ├─────────────────┤
             │ learner_id (PK) │
             │ full_name       │
             │ country         │
             └────────┬────────┘
                      │
                      │ learner_id
                      │
                      ▼
             ┌─────────────────┐
             │    Purchase     │
             ├─────────────────┤
             │ purchase_id PK  │
             │ learner_id FK   │
             │ course_id FK    │
             │ quantity        │
             │ purchase_date   │
             └────────┬────────┘
                      │
                      │ course_id
                      │
                      ▼
             ┌─────────────────┐
             │     Courses     │
             ├─────────────────┤
             │ course_id (PK)  │
             │ course_name     │
             │ category        │
             │ unit_price      │
             └─────────────────┘
