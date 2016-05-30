class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.boolean :current, default: false
      t.references :user, index: true
      t.index [:current, :user_id]

      t.timestamps null: false
    end

    add_reference :cards, :deck, index: true, foreign_key: true
  end
end
