require 'rest-client'

namespace :import_player_data do
    baseball_response = RestClient.get "https://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=baseball&response_format=JSON", {accept: :json}

    task import_baseball_data: :environment do
        json = JSON.parse(baseball_response)
        players_list = json["body"]["players"]
        count = 1
        total = players_list.count

        players_list.each do |player|
            print "\r handling player number #{count} of #{total}"
            count += 1
            next unless !player["firstname"].empty? && !player["lastname"].empty? # these are the team records

            # name_brief: For baseball players it should just be the first initial and the last initial like “G. S.”
            name_brief = "#{player["firstname"].slice(0)}. #{player["lastname"].slice(0)}."
            average_age = PositionAge.where(sport: "baseball").where(position: player["position"])&.first&.average_age


            Player.create(
                first_name: player["firstname"],
                last_name: player["lastname"],
                name_brief: name_brief,
                position: player["position"],
                age: player["age"],
                average_position_age_diff: average_age_diff(average_age, player["age"]),
                sport: "baseball"
            )
        end
    end

    basketball_response = RestClient.get "https://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=basketball&response_format=JSON", {accept: :json}

    task import_basketball_data: :environment do
        json = JSON.parse(basketball_response)
        players_list = json["body"]["players"]
        count = 1
        total = players_list.count

        players_list.each do |player|
            print "\r handling player number #{count} of #{total}"
            count += 1

            # name_brief: For basketball players it should be first name plus last initial like “Kobe B.” 
            name_brief = "#{player["firstname"]} #{player["lastname"].slice(0)}."
            average_age = PositionAge.where(sport: "basketball").where(position: player["position"])&.first&.average_age
 
            Player.create(
                first_name: player["firstname"],
                last_name: player["lastname"],
                name_brief: name_brief,
                position: player["position"],
                age: player["age"],
                average_position_age_diff: average_age_diff(average_age, player["age"]),
                sport: "basketball"
            )
        end
    end

    football_response = RestClient.get "https://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=football&response_format=JSON", {accept: :json}

    task import_football_data: :environment do
        json = JSON.parse(football_response)
        players_list = json["body"]["players"]
        count = 1
        total = players_list.count

        players_list.each do |player|
            print "\r handling player number #{count} of #{total}"
            count += 1

            next if ["DST", "D", "TQB", "ST"].include?(player["position"])  # these are the 32 teams, not players

            # name_brief: For football players it should be the first initial and their last name like “P. Manning”.
            name_brief = "#{player["firstname"].slice(0)}. #{player["lastname"]}"
            average_age = PositionAge.where(sport: "football").where(position: player["position"])&.first&.average_age
            
            Player.create(
                first_name: player["firstname"],
                last_name: player["lastname"],
                name_brief: name_brief,
                position: player["position"],
                age: player["age"],
                average_position_age_diff: average_age_diff(average_age, player["age"]),
                sport: "football"
            )
        end
    end

    def average_age_diff(average_age, player_age)
        return unless average_age && player_age

        return player_age - average_age
    end
end