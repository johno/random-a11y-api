class AddContrastToCombos < ActiveRecord::Migration[5.0]
  def change
    add_column :combos, :contrast, :decimal, precision: 10, scale: 2
  end
end
