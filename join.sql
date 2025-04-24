1. LEFT JOIN: Get all Customers with their Invoices (if any)

  To get a list of all customers, including those who may not have made any purchases yet.
  SQL Query:
  
SELECT 
    c.CustomerId, c.FirstName, c.LastName, i.InvoiceId, i.Total
FROM 
    Customer c
LEFT JOIN 
    Invoice i ON c.CustomerId = i.CustomerId;
