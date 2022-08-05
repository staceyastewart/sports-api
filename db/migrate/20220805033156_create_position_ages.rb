class CreatePositionAges < ActiveRecord::Migration[6.1]
  def change
    create_table :position_ages do |t|
      t.string :sport
      t.string :position
      t.text :ages, array: true, default: []

      t.timestamps
    end
  end
end
