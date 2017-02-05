class CreatePnrs < ActiveRecord::Migration[5.0]
  def change
    create_table :pnrs do |t|
      t.string :rcrd_loc
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :a_list
      t.timestamps
    end
  end
end
