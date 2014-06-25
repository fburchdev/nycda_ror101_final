class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :prefix
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :suffix
      t.text :notes

      t.timestamps
    end
  end
end
