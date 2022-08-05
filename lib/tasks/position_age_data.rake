require 'rest-client'

namespace :import_position_age_data do
    baseball_response = RestClient.get "https://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=baseball&response_format=JSON", {accept: :json}

    task import_baseball_position_age_data: :environment do
        json = JSON.parse(baseball_response)
        players_list = json["body"]["players"]

        create_position_age_data("baseball", players_list)
    end

    basketball_response = RestClient.get "https://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=basketball&response_format=JSON", {accept: :json}

    task import_basketball_position_age_data: :environment do
        json = JSON.parse(basketball_response)
        players_list = json["body"]["players"]

        create_position_age_data("basketball", players_list)
    end

    football_response = RestClient.get "https://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=football&response_format=JSON", {accept: :json}

    task import_football_position_age_data: :environment do
        json = JSON.parse(football_response)
        players_list = json["body"]["players"]

        create_position_age_data("football", players_list)
    end

    def create_position_age_data(sport, players_list)
        count = 1
        total = players_list.count

        players_list.each do |player|
            position = player["position"]
            existing_position = PositionAge.find_by_position(position)
            
            if existing_position && existing_position.sport == sport
                existing_position["ages"] << player["age"].to_i unless player["age"].nil?
                existing_position.save!
            elsif player["age"]
                PositionAge.create(
                    sport: sport,
                    position: position,
                    ages: [player["age"].to_i]
                )
            end

            print "\r handled player number #{count} of #{total}"
            count += 1
        end
    end
end