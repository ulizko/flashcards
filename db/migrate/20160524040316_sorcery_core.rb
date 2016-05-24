class SorceryCore < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :password, :crypted_password
      t.column :salt, :string
    end

    change_column :users, :email, null: false
    add_index :users, :email, unique: true
  end
end