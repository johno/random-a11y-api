class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :combo_id
      t.boolean :value

      t.timestamps
    end
  end
end
