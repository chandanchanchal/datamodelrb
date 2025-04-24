sudo apt update -y
sudo apt install mysql-server

  sudo mysql

SELECT user, host, plugin FROM mysql.user WHERE user = 'root';

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Password123';
FLUSH PRIVILEGES;

sudo snap install dbeaver-ce

create database test;
use database test;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    birth_date DATE,
    gender ENUM('M', 'F', 'O') CHECK (gender IN ('M', 'F', 'O')),
    marks DECIMAL(5,2) CHECK (marks >= 0 AND marks <= 100)
);

INSERT INTO students (student_id, full_name, email, birth_date, gender, marks) VALUES
(1, 'Amit Sharma', 'amit.sharma@example.com', '2002-01-15', 'M', 85.50),
(2, 'Neha Verma', 'neha.verma@example.com', '2001-07-23', 'F', 92.75),
(3, 'Ravi Kumar', 'ravi.kumar@example.com', '2003-05-05', 'M', 78.00),
(4, 'Anjali Mehra', 'anjali.mehra@example.com', '2000-09-10', 'F', 88.40),
(5, 'Suresh Yadav', 'suresh.yadav@example.com', '2002-12-01', 'M', 67.30),
(6, 'Priya Singh', 'priya.singh@example.com', '2001-03-14', 'F', 95.00),
(7, 'Kabir Das', 'kabir.das@example.com', '2000-11-19', 'M', 72.50),
(8, 'Meena Kumari', 'meena.kumari@example.com', '2003-06-07', 'F', 81.25),
(9, 'Vikram Joshi', 'vikram.joshi@example.com', '2002-10-22', 'M', 59.75),
(10, 'Divya Patil', 'divya.patil@example.com', '2001-08-31', 'F', 87.00);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO courses (course_id, course_name, student_id) VALUES
(101, 'Mathematics', 1),
(102, 'Physics', 2),
(103, 'Chemistry', 3),
(104, 'Biology', 4),
(105, 'Computer Science', 5),
(106, 'Economics', 6),
(107, 'History', 7),
(108, 'Political Science', 8),
(109, 'English Literature', 9),
(110, 'Philosophy', 10);

SELECT full_name, marks FROM students;

SELECT * FROM students
WHERE marks > 80;

SELECT * FROM students
WHERE birth_date > '2002-01-01';

SELECT AVG(marks) AS avg_marks FROM students;

SELECT MAX(marks) AS highest, MIN(marks) AS lowest FROM students;
SELECT full_name, marks FROM students ORDER BY marks DESC;
SELECT full_name, marks FROM students
ORDER BY marks DESC
LIMIT 3;


-----------------------------------Exercise-------------------------For 1NF-to-2NF-----Starts-------------
Exercise: Normalize the Student_Courses Table to 1NF and 2NF
Given Unnormalized Table (UNF)
#A university stores student enrollment details in the following table:

Student_Courses
+-----------+---------+----------------------+------------+
| StudentID | Name    | Courses              | Instructors|
+-----------+---------+----------------------+------------+
| 201       | Alice   | Math, Physics        | Dr. A, Dr. B|
| 202       | Bob     | Chemistry            | Dr. C      |
| 203       | Charlie | Math, Biology        | Dr. A, Dr. D|
+-----------+---------+----------------------+------------+
Issues:
The Courses column contains multiple values (not atomic).
The Instructors column also contains multiple values.
It violates the First Normal Form (1NF) rule.

Step 1: Convert to First Normal Form (1NF)
Definition of 1NF: A table is in 1NF if:
It has a primary key.
All columns contain atomic (indivisible) values.
There are no repeating groups or arrays.

############################--Solution---#########################################33
CREATE TABLE Students_1NF (
    StudentID INT,
    StudentName VARCHAR(50),
    Course VARCHAR(50),
    Instructor VARCHAR(50),
    PRIMARY KEY (StudentID, Course)
);
Data after applying 1NF:
+-----------+-------------+-----------+-------------+
| StudentID | StudentName | Course    | Instructor  |
+-----------+-------------+-----------+-------------+
| 201       | Alice       | Math      | Dr. A       |
| 201       | Alice       | Physics   | Dr. B       |
| 202       | Bob         | Chemistry | Dr. C       |
| 203       | Charlie     | Math      | Dr. A       |
| 203       | Charlie     | Biology   | Dr. D       |
+-----------+-------------+-----------+-------------+


