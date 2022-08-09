class SearchController < ApplicationController
    def index
        render json: Player.search(params), only: [:id, :name_brief, :first_name, :last_name, :position, :age, :average_position_age_diff]
    end
end
