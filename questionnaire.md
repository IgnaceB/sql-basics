# SQL questionnaire

## Setup
Import this [fake database content](mysqlsampledatabase.zip) into your database.

Below you will find a list of questions.

Find out the answer to each question using the dummy data in your database.

**Copy this file** (see: copy raw content) and fill in your queries + answer on the given location in each question.

## START !

### 1) How many customers do we have?
```
select count(*)from customers;
```

solution: `122`


### 2) What is the customer number of Mary Young?
```
select customerNumber,contactFirstName,contactLastName from customers where contactLastName='young' and contactFirstName='mary'
```

solution: `219`

### 3) What is the customer number of the person living at Magazinweg 7, Frankfurt 60528?
```
select customerNumber, addressLine1,addressLine2, postalCode from customers where postalCode="60528"
```

solution: `247`


### 4) If you sort the employees on their last name, what is the email of the first employee?
```
select email from employees order by employees.lastName limit 1
```

solution: `gbondur@classicmodelcars.com`

### 5) If you sort the employees on their last name, what is the email of the last employee?
```
select *from employees order by employees.lastName desc limit 1
```

solution: `gvanauf@classicmodelcars.com`


### 6) What is first the product code of all the products from the line 'Trucks and Buses', sorted first by productscale, then by productname.
```
select *from products where productLine='Trucks and Buses' order by productScale,productName limit 1
```

solution: `S12_4473`

### 7) What is the email of the first employee, sorted on their last name that starts with a 't'?
```
select *from employees where lastName like 't%' order by lastName limit 1
```

solution: `lthompson@classicmodelcars.com`


### 8) Which customer (give customer number) payed by check on 2004-01-19?
```
select *from payments where paymentDate='2004-01-19'
```

solution: `177`

### 9) How many customers do we have living in the state Nevada or New York?
```
select count(*)from customers where state in ('NY','NV')
```

solution: `7`


### 10) How many customers do we have living in the state Nevada or New York or outside the united states?
```
select count(*)from customers where state in ('NY','NV') or country!='USA'
```

solution: `93`

### 11) How many customers do we have with the following conditions (only 1 query needed):  - Living in the state Nevada or New York OR - Living outside the USA or the customers and with a credit limit above 1000 dollar?
```
select count(*)from customers where state in ('NY','NV') or country!='USA' or creditLimit>'1000'
```

solution: `121`


### 12) How many customers don't have an assigned sales representative?
```
select count(*)from customers where salesRepEmployeeNumber is null
```

solution: `22`

### 13) How many orders have a comment?
```
select count(*)from orders where comments is not null
```

solution: `80`


### 14) How many orders do we have where the comment mentions the word "caution"?
```
select count(*)from orders where comments like '%caution%'
```

solution: `4`

### 15) What is the average credit limit of our customers from the USA? (rounded)
```
select round(avg(creditLimit),0) from customers where country='USA'
```

solution: `78103`


### 16) What is the most common last name from our customers?
```
select count(contactLastName) as countery, contactLastName from customers group by contactLastName order by countery desc limit 1
or 
select max(mycount)from (select count(contactLastName) as mycount, contactLastName from customers group by contactLastName) as lineCount;
```

solution: `Young`

### 17) What are valid statuses of the orders?
- [ ] Resolved

- [ ] Cancelled

- [ ] Broken

- [ ] On Hold

- [ ] Disputed

- [ ] In Process

- [ ] Processing

- [ ] Shipped

```
select distinct status from orders
```

solution: `
- [X] Resolved

- [X] Cancelled

- [ ] Broken

- [X] On Hold

- [X] Disputed

- [X] In Process

- [ ] Processing

- [X] Shipped
`


### 18) In which countries don't we have any customers?
- [ ] Austria

- [ ] Canada

- [ ] China

- [ ] Germany

- [ ] Greece

- [ ] Japan

- [ ] Philippines

- [ ] South Korea

```
select distinct country from customers 
or 
select *from (values ('Austria'),('Canada'),('China'),('Germany'),('Greece'),('Japan'),('Philippines'),('South Korea')) as transition except select country from customers
```

solution: `
- [ ] Austria

- [ ] Canada

- [X] China

- [ ] Germany

- [X] Greece

- [ ] Japan

- [ ] Philippines

- [X] South Korea
`


### 19) How many orders where never shipped?
```
select count(*)from orders where shippedDate is null
```

solution: `14`

### 20) How many customers does Steve Patterson have with a credit limit above 100 000 EUR?
```
select count(*)from customers where creditLimit>'100000' and customers.salesRepEmployeeNumber=(select employees.employeeNumber from employees where firstName="Steve" and lastName='Patterson')
```

solution: `3`

### 21) How many orders have been shipped to our customers?
```
select count(*)from orders where status='shipped'
```

solution: `303`


### 22) How much products does the biggest product line have? And which product line is that?
```
select max(productCount),thisLine from (select productLine as thisLine, count(productLine) as productCount from products group by productLine) as productline
```

solution: `38, Classic cars`

### 23) How many products are low in stock? (below 100 pieces)
```
select count(*) from products where quantityInStock<100
```

solution: `2`

### 24) How many products have more the 100 pieces in stock, but are below 500 pieces.
```
select count(*)from products where quantityInStock between '100' and '500'
```

solution: `3`


### 25) How many orders did we ship between and including June 2004 & September 2004
```
select count(*) from orders where shippedDate between '2004-06-01' and '2004-09-30'
```

solution: `43`

### 26) How many customers share the same last name as an employee of ours?
```
select count(*)from customers where contactLastName in(select employees.lastName from employees)
```

solution: `9`

### 27) Give the product code for the most expensive product for the consumer?
```
select buyPrice, productCode from products where products.MSRP=(select max(MSRP) from products)
```

solution: `S10_1949`


### 28) What product (product code) offers us the largest profit margin (difference between buyPrice & MSRP).
```
select MSRP-buyPrice as profit, productCode from products where MSRP-buyPrice=(select max(MSRP-buyPrice) from products)
```

solution: `S10_1949`

### 29) How much profit (rounded) can the product with the largest profit margin (difference between buyPrice & MSRP) bring us.
```
select round(MSRP-buyPrice) as profit, productCode from products where MSRP-buyPrice=(select max(MSRP-buyPrice) from products)
```

solution: `116`

### 30) Given the product number of the products (separated with spaces) that have never been sold?
```
select *from products where products.productCode not in(select orderdetails.productCode from orderdetails)
or 
select *from products where products.productCode not in(select orderdetails.productCode from orderdetails join orders on orders.orderNumber=orderdetails.orderNumber where orders.status='shipped')
```

solution: `S18_3233`


### 31) How many products give us a profit margin below 30 dollar?
```
select count(*) from products where MSRP-buyPrice<30
```

solution: `23`

### 32) What is the product code of our most popular product (in number purchased)?
```
select* from (select sum(orderdetails.quantityOrdered) as maxOrder, productCode from orderdetails group by productCode order by maxOrder desc limit 1) as tableMax
or
select sum(quantityOrdered) as maxOrder, productCode from orderdetails group by productCode order by maxOrder desc limit 1
```

solution: `S18_3232`

### 33) How many of our popular product did we effectively ship?
```
select sum(quantityOrdered) as maxOrder, productCode, orders.status from orderdetails inner join orders on orderdetails.orderNumber = orders.orderNumber where orders.status='shipped' group by productCode  order by maxOrder desc limit 1

```

solution: `1728`


### 34) Which check number paid for order 10210. Tip: Pay close attention to the date fields on both tables to solve this.  
```
select *from payments where customerNumber=(select customerNumber from orders where orderNumber='10210' and paymentDate between orderDate and shippedDate )
```

solution: `CI381435`

### 35) Which order was paid by check CP804873?
```
select *from orders where customerNumber=(select customerNumber from payments where checkNumber='CP804873' and paymentDate between orderDate and shippedDate )

```

solution: `10330`

### 36) How many payments do we have above 5000 EUR and with a check number with a 'D' somewhere in the check number, ending the check number with the digit 9?
```
select count(*)from payments where amount>5000 and payments.checkNumber like ('%D%') and  payments.checkNumber like ('%9')

```

solution: `3`


### 38) In which country do we have the most customers that we do not have an office in?
```
select count(*) as theCount,country from customers where country not in (select offices.country from offices ) group by country order by theCount desc limit 1
```

solution: `Germany`

### 39) What city has our biggest office in terms of employees?
```
select offices.city,offices.officeCode, count(employees.officeCode) as theCount from offices inner join employees on offices.officeCode = employees.officeCode group by offices.officeCode order by theCount desc limit 1
```

solution: `San Francisco`

### 40) How many employees does our largest office have, including leadership?

```
select count(*), officeCode from employees group by officeCode
```

solution: `6`


### 41) How many employees do we have on average per country (rounded)?
```
select round(avg(cnt.howMuch),0) from (select count(*) as howMuch from employees inner join offices o on employees.officeCode = o.officeCode group by o.country order by howMuch desc) as cnt

```

solution: `5`

### 42) What is the total value of all shipped & resolved sales ever combined?
```
select sum(priceEach * orderdetails.quantityOrdered)
from orderdetails
         inner join orders on orderdetails.orderNumber = orders.orderNumber
where orders.status in('resolved','shipped');
```

solution: `8999330.52`

### 43) What is the total value of all shipped & resolved sales in the year 2005 combined? (based on shipping date)
```
select sum(priceEach * orderdetails.quantityOrdered)
from orderdetails
         inner join orders on orderdetails.orderNumber = orders.orderNumber
where orders.status in('resolved','shipped') and shippedDate between '2005-01-01' and '2055-12-31'
```

solution: `1427944.97`


### 44) What was our most profitable year ever (based on shipping date), considering all shipped & resolved orders?
```
select sum(priceEach * orderdetails.quantityOrdered) as SUMMMM, orders.shippedDate
from orderdetails
         inner join orders on orderdetails.orderNumber = orders.orderNumber
where orders.status in('resolved','shipped')
group by YEAR(shippedDate)
order by SUMMMM desc limit 1 
```

solution: `2004`

### 45) How much revenue did we make on in our most profitable year ever (based on shipping date), considering all shipped & resolved orders?
```
select sum(priceEach * orderdetails.quantityOrdered) as SUMMMM, orders.shippedDate
from orderdetails
         inner join orders on orderdetails.orderNumber = orders.orderNumber
where orders.status in('resolved','shipped')
group by YEAR(shippedDate)
order by SUMMMM desc limit 1 
```

solution: `4321167.85`

### 46) What is the name of our biggest customer in the USA of terms of revenue?
```
select sum(payments.amount) as depense, payments.customerNumber, customers.customerName from payments
    inner join customers on customers.customerNumber = payments.customerNumber
    where customers.country='USA'
group by payments.customerNumber
order by depense desc limit 1

or 

select sum(orderdetails.quantityOrdered*(orderdetails.priceEach-p.buyPrice)) as benefice, c.customerNumber, c.customerName from orderdetails
inner join products p on orderdetails.productCode = p.productCode
inner join orders o on orderdetails.orderNumber = o.orderNumber
inner join customers c on o.customerNumber = c.customerNumber
where c.country='USA'
group by o.customerNumber
order by benefice desc limit 1
```

solution: `Mini Gifts Distributors Ltd.`


### 47) How much has our largest customer inside the USA ordered with us (total value)?
```
select sum(payments.amount) as depense, payments.customerNumber, customers.customerName from payments
    inner join customers on customers.customerNumber = payments.customerNumber
    where customers.country='USA'
group by payments.customerNumber
order by depense desc limit 1
```

solution: `584188.24`

### 48) How many customers do we have that never ordered anything?
```
select count(customerNumber) as thisNumber from customers where customerNumber not in(
select  c.customerNumber from orderdetails
        inner join orders o on orderdetails.orderNumber = o.orderNumber
        inner join customers c on c.customerNumber=o.customerNumber
        GROUP BY o.customerNumber)
```

solution: `24`

### 49) What is the last name of our best employee in terms of revenue?
```
select sum(orderdetails.quantityOrdered*(orderdetails.priceEach-p.buyPrice)) as benefice, c.salesRepEmployeeNumber, e.lastName from orderdetails
inner join products p on orderdetails.productCode = p.productCode
inner join orders o on orderdetails.orderNumber = o.orderNumber
inner join customers c on o.customerNumber = c.customerNumber
inner join employees e on c.salesRepEmployeeNumber = e.employeeNumber
group by c.salesRepEmployeeNumber
order by benefice desc limit 1
```

solution: `Hernandez`


### 50) What is the office name of the least profitable office in the year 2004?
```
select sum(orderdetails.quantityOrdered*(orderdetails.priceEach-p.buyPrice)) as benefice,o2.officeCode from orderdetails
inner join products p on orderdetails.productCode = p.productCode
inner join orders o on orderdetails.orderNumber = o.orderNumber
inner join customers c on o.customerNumber = c.customerNumber
inner join employees e on c.salesRepEmployeeNumber = e.employeeNumber
inner join offices o2 on e.officeCode = o2.officeCode
where o.shippedDate like '2004%'
group by o2.officeCode
order by benefice asc limit 1
```

solution: `Tokyo`


## Are you done? Amazing!
![](../_assets/clap-clap-clap.gif)
