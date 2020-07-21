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