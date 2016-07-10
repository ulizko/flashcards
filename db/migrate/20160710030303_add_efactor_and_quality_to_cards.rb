class AddEfactorAndQualityToCards < ActiveRecord::Migration
  def up
    remove_column :cards, :mistake
    rename_column :cards, :try, :repeat
    add_column :cards, :efactor, :decimal, precision: 3, scale: 2, default: 2.5
    add_column :cards, :quality, :integer, default: 0
    add_column :cards, :interval, :integer, default: 0
  end
  def down
    rename_column :cards, :repeat, :try
    remove_column :cards, :efactor, :decimal, precision: 3, scale: 2, default: 2.5
    remove_column :cards, :quality, :integer
    remove_column :cards, :interval, :integer
    add_column :cards, :mistake, :integer, null: false, default: 0
  end
end
