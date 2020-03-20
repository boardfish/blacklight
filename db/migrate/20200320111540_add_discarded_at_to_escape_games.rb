class AddDiscardedAtToEscapeGames < ActiveRecord::Migration[6.0]
  def change
    add_column :escape_games, :discarded_at, :datetime
    add_index :escape_games, :discarded_at
  end
end
