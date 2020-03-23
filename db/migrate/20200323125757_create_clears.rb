class CreateClears < ActiveRecord::Migration[6.0]
  def change
    create_table :clears do |t|
      t.references :user, null: false, foreign_key: true
      t.references :escape_game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
