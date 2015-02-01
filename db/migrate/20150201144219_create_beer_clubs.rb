class CreateBeerClubs < ActiveRecord::Migration
  def change
    create_table :beer_clubs do |t|
      t.string :username
      t.integer :founded
      t.string :city

      t.timestamps null: false
    end
  end
end
