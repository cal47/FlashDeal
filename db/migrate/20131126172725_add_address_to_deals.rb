class AddAddressToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :companyName, :string
    add_column :deals, :street1, :string
    add_column :deals, :city, :string
    add_column :deals, :state, :string
    add_column :deals, :zip, :string
    add_column :deals, :latitude, :float
    add_column :deals, :longitude, :float
    add_column :deals, :address, :text
  end
end
