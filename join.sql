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

