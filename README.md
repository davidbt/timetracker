# timetracker
A minimal example of a Timetracker app using Rails.

## Instructions to run it on develop environment.


Installig Rails
```
sudo gem install rails
```

Clone the repo
```
git clone https://github.com/davidbt/timetracker.git
```

Install postgresql
```
sudo apt-get install postgresql
```

Note: If you don't use a debian based distribution replace apt-get with the equivalent in your OS.

Create DB user
```
sudo -u postgres -i createuser timetracker -s
```

Create database
```
sudo -u postgres -i createdatabase timetracker_development
```

Install gems
```
cd timetracker
bundle install
```

You can create a new user runing the app:
```
bin/rails server
```
here: http://localhost:3000/users/sign_up

Or

Inside rails console create some users for example (not very friendly for now):
```
User.new({:email => "someone1@email.com", :password => "secret", :password_confirmation => "secret" }).save()

User.new({:email => "someone2@email.com", :password => "secret", :password_confirmation => "secret" }).save()

User.new({:email => "someone3@email.com", :password => "secret", :password_confirmation => "secret" }).save()
```

Sadly (for now) there is no admin page now so the employee data needs to be entered by hand in postgresql, for example:
 ```
 insert into employees (name, last_name, user_id, created_at, updated_at) values ('Juan', 'Perez', 1, now(), now());
 insert into employees (name, last_name, user_id, created_at, updated_at) values ('Alan', 'Turing', 2, now(), now());
 insert into employees (name, last_name, user_id, created_at, updated_at) values ('Sara', 'Connor', 3, now(), now());

 insert into badges (employee_id, barcode, created_at, updated_at) values (1, 'BARCODE1', now(), now());
 insert into badges (employee_id, barcode, created_at, updated_at) values (2, 'BARCODE2', now(), now());
 insert into badges (employee_id, barcode, created_at, updated_at) values (3, 'BARCODE3', now(), now());

 insert into timetracks (badge_id, date, time, inout_type, created_at, updated_at) values (1, '2016-11-05', '09:00:00', 'in', now(), now()); -- ok
 insert into timetracks (badge_id, date, time, inout_type, created_at, updated_at) values (1, '2016-11-05', '18:00:00', 'out', now(), now()); -- ok
 insert into timetracks (badge_id, date, time, inout_type, created_at, updated_at) values (2, '2016-11-05', '09:01:00', 'in', now(), now()); -- late
 insert into timetracks (badge_id, date, time, inout_type, created_at, updated_at) values (2, '2016-11-05', '18:00:00', 'out', now(), now()); -- ok
 insert into timetracks (badge_id, date, time, inout_type, created_at, updated_at) values (1, '2016-11-06', '10:05:00', 'in', now(), now(); -- ok
 insert into timetracks (badge_id, date, time, inout_type, created_at, updated_at) values (1, '2016-11-06', '15:59:00', 'out', now(), now()); -- ok
 insert into timetracks (badge_id, date, time, inout_type, created_at, updated_at) values (2, '2016-11-06', '09:02:00', 'in', now(), now()); -- late
 insert into timetracks (badge_id, date, time, inout_type, created_at, updated_at) values (2, '2016-11-06', '18:00:00', 'out', now(), now()); -- ok

 insert into paycheck_days (date, created_at, updated_at)
 select d, now(), now() from generate_series('2016-01-01'::date, '2017-01-01'::date, '15 day'::interval) d;
 ```

Now you can run the rails server and try the app in: http://localhost:3000

## TODO list:

* Make date inputs to use a calendar
* Make tables look better, maybe use datatables
* Add an admin page
