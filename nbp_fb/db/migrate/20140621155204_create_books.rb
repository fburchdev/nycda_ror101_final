class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :series_id
      t.integer :sequence_number
      t.string :title
      t.text :notes

      t.timestamps
    end
  end
end
