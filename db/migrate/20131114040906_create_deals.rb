class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :deal
      t.text :description
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
