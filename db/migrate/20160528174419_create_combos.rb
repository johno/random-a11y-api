class CreateCombos < ActiveRecord::Migration[5.0]
  def change
    create_table :combos do |t|
      t.string :color_one
      t.string :color_two

      t.timestamps
    end
  end
end
