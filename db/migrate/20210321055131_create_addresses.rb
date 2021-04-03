class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :postcode,       null: false
      t.integer :perfecture_id, null: false
      t.string :city,           null: false
      t.string :address,        null: false
      t.string :bulding
      t.string :phone_number,   null: false
      t.references :consumer,   null:false, foreign_key: true
      t.timestamps
    end
  end
end
