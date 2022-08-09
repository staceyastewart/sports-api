require "rails_helper"

describe SearchController do
    before do
        player = Player.create(first_name: "Giannis", last_name: "Antetokounmpo", name_brief: "Giannis A.", age: 27, position: "PF", sport: "basetball", average_position_age_diff: 2)
        player = Player.create(first_name: "Anthony", last_name: "Davis", name_brief: "Anthony D.", age: 29, position: "PF", sport: "basetball", average_position_age_diff: 4)
        player = Player.create(first_name: "Tom", last_name: "Brady", name_brief: "T. Brady", age: 45, position: "QB", sport: "football", average_position_age_diff: 18)
        player = Player.create(first_name: "Saquon", last_name: "Barkley", name_brief: "S. Barkley", age: 25, position: "RB", sport: "football", average_position_age_diff: 0)
    end

    describe "#index" do
        it "returns the players that fit search criteria when searching on one field" do
            get :index, params: { age: 27 }

            expect(response).to have_http_status(:ok)

            body = JSON.parse(response.body)

            expect(body.count).to eq(1)
            expect(body[0]["first_name"]).to eq("Giannis")
        end

        it "returns the players that fit search criteria when searching on multiple fields" do
            get :index, params: { sport: "football", last_name: "B" }

            expect(response).to have_http_status(:ok)

            body = JSON.parse(response.body)

            expect(body.count).to eq(2)
            expect(body[0]["first_name"]).to eq("Tom")
            expect(body[1]["first_name"]).to eq("Saquon")
        end
    end
end