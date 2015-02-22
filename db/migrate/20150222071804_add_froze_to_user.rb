class AddFrozeToUser < ActiveRecord::Migration
  def change
    add_column :users, :froze, :boolean
  end
end
