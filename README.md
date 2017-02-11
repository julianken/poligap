# README

Hi! This is the API that the front-end Ember.js application for Poligap uses to 
retrieve information. Clone the repository, `bundle install`

The front-end application can be found [here](https://github.com/julianken/poligap-ember)

Please feel free to contact me with any quesions on GitHub or my personal e-mail: julian.kennon.d@gmail.com

Ruby version 2.2.3

Rails version 5.0.0.1

## Database

I've provided a sql file in the repository that is a dump from the last time 
it was updated. Until I can find a way to get more than 200 API calls from OpenSecrets.org 
we will have to do it this way. Basically create a schema, then `mysql -uroot <database defined in app/config/database.yaml> < poligap.sql` 
