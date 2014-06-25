class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :title
      t.integer :author_id
      t.text :notes

      t.timestamps
    end
  end
end
