class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.boolean :status
      t.references :user, foreign_key: true
      t.references :cat, foreign_key: true

      t.timestamps
    end
  end
end
