# README

This app is built to set up an API that returns players from the CBS Sports API who play basketball, football and baseball.

## Setting up the app

Clone this repo locally and cd into it. Then run the following commands.

These commands are for the general setup of the application.
```
bundle install
rails db:create
rails db:migrate
rails db:test:prepare
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


## Querying the API

To query the API, please have your server running and nevigate to http://localhost:3000/search. From there you can add query parameters to the url i.e. http://localhost:3000/search?last_name=S&age=36 would return:

```
[
    {
        "id": 40354,
        "name_brief": "C. S.",
        "first_name": "Carlos",
        "last_name": "Santana",
        "position": "1B",
        "age": 36,
        "average_position_age_diff": 7
    }
]
```

The available search terms are: age, position, sport, last_name (which only searches by the first letter of the player's last name)