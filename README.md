##### Task

Our application has customers, orders, and order items.
For simplicity, let's say that customers have only an email, and date of birth.
Orders have a number, date, order total, customer who placed the order, and order items.
Order items have a product name, price, and quantity.
Order total is a sum of the following values calculated for all its items: order item quantity * order item price.

Please implement web interface using Ruby on Rails for the following application features:
  1. CRUD functions for Orders and Order Items
  2. A report page to display the top 10 customers who made orders for the most total amount. The report fields: customer email, and a total of all customer orders. The report should have an optional parameter to include in the report only customers older than the given value. E.g. we want to see in the report top 10 customers older than 30 years old.

Notes:
  1. Implement the features following REST principles.
  2. Use any gem or library that you need.
  3. Do not implement authorization.
  4. Place the project on GitHub and provide the link or send us a zip archive of the repo including all commits.


##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby 2.6.3
- Rails 6.0.2
- PostgreSQL

##### 1. Check out the repository

```bash
git clone https://github.com/qvocin/paneco_test_task.git
```

##### 2. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create
```

##### 3. Create seeds

You can start the rails server using the command given below.

```ruby
rails db:seed
```

And now you can visit the site with the URL http://localhost:3000/admin

##### 4. Login and password for admin user

```ruby
User: admin@example.com
Password: password
```

##### 5. Pages
App has Customer, Order and Report pages

CRUD implemented for Order and OrderItem models

##### 6. Report page

For create report you should click to button
```ruby
Make report
```

by default report will be create without any parameters

The report has an optional parameter to include in the report only customers older than the given value.

##### 7. Project has rubocop

To run 

```ruby
rubocop
```

##### 7. Spec

For spec are using Rspec and Capybara

To run 
```ruby
rspec
```