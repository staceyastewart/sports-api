class Player < ApplicationRecord
    include PgSearch::Model
    pg_search_scope :last_name_starts_with,
                    against: :last_name,
                    using: {
                        tsearch: { prefix: true }
                    }

    pg_search_scope :search_all,
                    against: [:age, :position, :sport],
                    using: [:tsearch]

    def self.search(params)
        search_all_query = "#{params[:age]} #{params[:position]}, #{params[:sport]})"
        last_name_query = params[:last_name]

        if last_name_query
            self.search_all(search_all_query).last_name_starts_with(last_name_query)
        else
            self.search_all(search_all_query)
        end
    end
end
