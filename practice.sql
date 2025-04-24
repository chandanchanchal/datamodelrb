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

