require "rails_helper"

describe PlayersController do
    before do
        player = Player.create(first_name: "Giannis", last_name: "Antetokounmpo", name_brief: "Giannis A.", age: 27, position: "PF", sport: "basetball", average_position_age_diff: 2)
        player = Player.create(first_name: "Anthony", last_name: "Davis", name_brief: "Anthony D.", age: 29, position: "PF", sport: "basetball", average_position_age_diff: 4)
        player = Player.create(first_name: "Tom", last_name: "Brady", name_brief: "T. Brady", age: 45, position: "QB", sport: "football", average_position_age_diff: 18)
    end

    describe "#index" do
        it "returns the players in the response with only fields we expect" do
            get :index

            expect(response).to have_http_status(:ok)

            body = JSON.parse(response.body)

            expect(body.count).to eq(3)
            expect(body[0]["sport"]).to be_nil
        end
    end
end