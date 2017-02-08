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
    
    create_table :segments do |t|
      t.string :od
      t.string :flt_num
      t.datetime :flt_time
      t.datetime :checkin_time
      t.references :pnr, type: :rcrd_loc
      t.timestamps
    end

  end
end
