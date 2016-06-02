class AddVotesCountToCombos < ActiveRecord::Migration[5.0]
  def change
    add_column :combos, :votes_count, :integer, default: 0
  end
end
