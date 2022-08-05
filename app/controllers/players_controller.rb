class PlayersController < ApplicationController
    def index
        @players = Player.all

        render json: @players, only: [:id, :name_brief, :first_name, :last_name, :position, :age, :average_position_age_diff]
    end
end