class RemoveLatLonFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :lat, :decimal
    remove_column :users, :lon, :decimal
  end
end
