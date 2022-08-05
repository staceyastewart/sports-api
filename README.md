# README

This app is built to set up an API that returns players from the CBS Sports API who play basketball, football and baseball.

## Setting up the app

Clone this repo locally and cd into it. Then run the following commands.

These commands are for the general setup of the application.
```
bundle install
rails db:create
rails db:migrate
bundle exec rails webpacker:install
```

These commands will populate your database with data from the CBS API.
```
rake import_position_age_data:import_baseball_position_age_data
rake import_position_age_data:import_basketball_position_age_data
rake import_position_age_data:import_football_position_age_data
rake import_player_data:import_baseball_data
rake import_player_data:import_basketball_data
rake import_player_data:import_football_data
```

## Accessing the API

To access the API, please start your server using `rails s` and navigate to http://localhost:3000/players.
