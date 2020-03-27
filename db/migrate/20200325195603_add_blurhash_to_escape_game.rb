class AddBlurhashToEscapeGame < ActiveRecord::Migration[6.0]
  def change
    add_column :escape_games, :blurhash, :string
  end
end
