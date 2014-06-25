class CreateSeriesRequests < ActiveRecord::Migration
  def change
    create_table :series_requests do |t|
      t.string :email
      t.string :series
      t.string :author

      t.timestamps
    end
  end
end
