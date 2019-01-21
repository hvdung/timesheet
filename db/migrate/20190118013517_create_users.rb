class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :birthday
      t.integer :gender, default: 1, null: false
      t.string :phone
      t.string :email, null: false

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
