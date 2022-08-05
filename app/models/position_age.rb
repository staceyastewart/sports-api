class PositionAge < ApplicationRecord
    def average_age
        ages_list = self.ages

        numerical_ages = ages_list.map { |age| age.to_i }
        numerical_ages.sum.fdiv(numerical_ages.size).round
    end
end
