class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name_brief
      t.string :first_name
      t.string :last_name
      t.string :position
      t.integer :age
      t.string :sport
      t.integer :average_position_age_diff

      t.timestamps
    end
  end
end
