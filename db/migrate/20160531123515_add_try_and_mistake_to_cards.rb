class AddTryAndMistakeToCards < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :cards do |t|
        dir.up do
          t.change :review_date, :datetime
          t.integer :try, default: 0
          t.integer :mistake, default: 0
        end
        dir.down do
          t.change :review_date, :date, default: nil
          t.remove :try
          t.remove :mistake
        end
      end
    end
  end
end
