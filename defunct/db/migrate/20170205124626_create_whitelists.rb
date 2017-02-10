class CreateWhitelists < ActiveRecord::Migration[5.0]
  def change
    create_table :whitelists do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :member

      t.timestamps
    end
  end
end
