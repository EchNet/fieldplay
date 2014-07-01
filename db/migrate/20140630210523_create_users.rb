class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.string :email
      t.string :encrypted_password, :null => false
      t.string :salt, :null => false
      t.timestamps
    end
    add_index :users, :username, :unique => true
    add_index :users, :email
  end
end
