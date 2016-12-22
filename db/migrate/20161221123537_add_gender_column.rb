class AddGenderColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :cats, :gender, :integer
  end
end
