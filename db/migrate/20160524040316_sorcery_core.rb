class SorceryCore < ActiveRecord::Migration
  def change
    remove_reference :cards, :user, index: true, foreign_key: true
    drop_table :users
    create_table :users do |t|
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt

      t.timestamps
    end
    add_reference :cards, :user, index: true, foreign_key: true
    add_index :users, :email, unique: true
  end
end