class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.boolean :current, default: false

      t.timestamps null: false
    end

    add_reference :cards, :deck, index: true, foreign_key: true
    add_reference :decks, :user, index: true, foreign_key: true
    add_index :decks, [:current, :user_id]
  end
end
