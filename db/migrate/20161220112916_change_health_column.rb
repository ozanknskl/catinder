class ChangehealthColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :cats , :healt
    add_column :cats , :health, :integer, default: 5
  end
end
