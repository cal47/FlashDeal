class AddAddressFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :address, :text
  end
end
