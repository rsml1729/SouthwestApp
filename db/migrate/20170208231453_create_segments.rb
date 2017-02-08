class CreateSegments < ActiveRecord::Migration[5.0]
  def change
    
    create_table :segments do |t|
      t.string :od
      t.string :flt_num
      t.datetime :flt_time
      t.datetime :checkin_time
      t.references :pnr, type: :string
      t.timestamps
    end
    
  end
end
