1. LEFT JOIN: Get all Customers with their Invoices (if any)

  To get a list of all customers, including those who may not have made any purchases yet.
  SQL Query:
  
SELECT 
    c.CustomerId, c.FirstName, c.LastName, i.InvoiceId, i.Total
FROM 
    Customer c
LEFT JOIN 
    Invoice i ON c.CustomerId = i.CustomerId;
---------------------------------------------------------
Expected Output:
All customers will be listed.
If a customer has an invoice, its InvoiceId and Total will appear.
If not, InvoiceId and Total will be NULL.
----------------------------------------------------------------------------
2. INNER JOIN: Get Invoices with Their Customer Names
To show only those invoices that are linked to existing customers.
SQL Query:
SELECT 
    i.InvoiceId, i.InvoiceDate, c.FirstName || ' ' || c.LastName AS CustomerName, i.Total
FROM 
    Invoice i
INNER JOIN 
    Customer c ON i.CustomerId = c.CustomerId;
---------------------------------------------------------
Expected Output:
Only invoices tied to a valid customer.
No invoices with orphaned customer IDs.

------------------------------------------------------------------------

List All Albums and Their Tracks (Including Albums Without Tracks)

To show all albums, including those that don’t have any tracks. 
A 
3.RIGHT JOIN from Track to Album would do that in a database that supports it. 
In SQLite, we reverse and use LEFT JOIN.

Simulated RIGHT JOIN Using LEFT JOIN:
SELECT 
    a.AlbumId, a.Title AS AlbumTitle, t.TrackId, t.Name AS TrackName
FROM 
    Album a
LEFT JOIN 
    Track t ON a.AlbumId = t.AlbumId;

---------------------------------------------------------------------

SELECT 
    t.Name AS TrackName, a.Title AS AlbumTitle
FROM 
    Track t
LEFT JOIN 
    Album a ON t.AlbumId = a.AlbumId;

-----------------------------------Data Modeling Exercise: Travel Domain-----Starts-------------
Step 1: Conceptual Model (High-Level Design)
Entities(Table)& Relationships
In the travel domain, key entities and their relationships can be defined as follows:
Traveler: A person booking trips.
Trip: Represents a journey taken by a traveler.
Destination: Places where trips are made.
Booking: A record of a trip booked by a traveler.
Payment: Details of payments made for bookings.
Transportation: Modes of transport (Flight, Train, Bus, etc.).
Accommodation: Hotels or places travelers stay.
Review: Ratings & feedback by travelers.
  
Step 2: Logical Model (Detailed Attributes & Relationships)
Now, we define attributes and relationships.
One traveler can have many bookings.
One trip can cover multiple destinations.
One booking can have one or more payments.
One booking involves one transportation mode and may have one accommodation.
One traveler can give multiple reviews for different bookings.
Step 3: Physical Model (Table Structure for MySQL)
Tables & Schema Design
1. Traveler (Stores traveler details)
CREATE TABLE Traveler (
    traveler_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

2. Trip (Records trips with start and end dates)
CREATE TABLE Trip (
    trip_id INT PRIMARY KEY AUTO_INCREMENT,
    traveler_id INT,
    trip_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (traveler_id) REFERENCES Traveler(traveler_id)
);
3. Destination (Stores travel locations)
CREATE TABLE Destination (
    destination_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    country VARCHAR(50),
    description TEXT
);

4. Trip_Destination (Many-to-Many Relationship Between Trip & Destination)
CREATE TABLE Trip_Destination (
    trip_id INT,
    destination_id INT,
    PRIMARY KEY (trip_id, destination_id),
    FOREIGN KEY (trip_id) REFERENCES Trip(trip_id),
    FOREIGN KEY (destination_id) REFERENCES Destination(destination_id)
);

5. Booking (Links Travelers, Trips, and Accommodations)
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    traveler_id INT,
    trip_id INT,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (traveler_id) REFERENCES Traveler(traveler_id),
    FOREIGN KEY (trip_id) REFERENCES Trip(trip_id)
);

6. Payment (Stores payment details for bookings)
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2),
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer'),
    status ENUM('Pending', 'Completed', 'Failed'),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

7. Transportation (Types of travel modes)
CREATE TABLE Transportation (
    transport_id INT PRIMARY KEY AUTO_INCREMENT,
    transport_type ENUM('Flight', 'Train', 'Bus', 'Car Rental'),
    provider VARCHAR(100),
    details TEXT
);

8. Accommodation (Hotels, stays linked to bookings)
CREATE TABLE Accommodation (
    accommodation_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    location VARCHAR(100),
    room_type VARCHAR(50),
    price_per_night DECIMAL(10,2)
);

9. Review (Traveler feedback on bookings)
CREATE TABLE Review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    traveler_id INT,
    booking_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (traveler_id) REFERENCES Traveler(traveler_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);



Open DBeaver.
Click Database → New Connection → MySQL.
Enter MySQL host, port, username, password.
Click Finish.
Create a New Database
CREATE DATABASE TravelDB;
USE TravelDB;

Insert Sample Data 
INSERT INTO Traveler (first_name, last_name, email, phone)
VALUES ('Alice', 'Brown', 'alice@example.com', '1234567890');

INSERT INTO Destination (name, country, description)
VALUES ('Paris', 'France', 'City of Light and Romance');

INSERT INTO Trip (traveler_id, trip_name, start_date, end_date)
VALUES (1, 'Europe Tour', '2025-06-01', '2025-06-15');

INSERT INTO Trip_Destination (trip_id, destination_id)
VALUES (1, 1);
Run Queries to Fetch Data
Example: Get all bookings with traveler details
SELECT b.booking_id, t.first_name, t.last_name, tr.trip_name, b.booking_date, b.total_amount
FROM Booking b
JOIN Traveler t ON b.traveler_id = t.traveler_id
JOIN Trip tr ON b.trip_id = tr.trip_id;


