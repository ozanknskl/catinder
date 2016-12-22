class CreateCats < ActiveRecord::Migration[5.0]
  def change
    create_table :cats do |t|
      t.references :user, foreign_key: true
      t.references :cat_type, foreign_key: true
      t.references :location, foreign_key: true
      t.string :name
      t.integer :age
      t.string :color
      t.integer :hyperactivity
      t.integer :healt
      t.text :about

      t.timestamps
    end
  end
end
