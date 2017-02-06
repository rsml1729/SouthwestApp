class CreatePnrs < ActiveRecord::Migration[5.0]
  def change
    create_table :pnrs, id: false do |t|
      t.string :rcrd_loc
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :a_list
      t.timestamps
    end

    add_index :pnrs, :rcrd_loc, unique: true
  end
end
