class ChangeUsernameToNameInBeerClub2 < ActiveRecord::Migration
  def change
    rename_column :beer_clubs, :ChangeUsernameToNameInBeerClub, :name
  end
end
