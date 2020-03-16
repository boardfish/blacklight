class CreateEscapeGames < ActiveRecord::Migration[6.0]
  def change
    create_table :escape_games do |t|
      t.string :name
      t.integer :genre
      t.string :summary
      t.string :description
      t.integer :difficulty_level
      t.integer :available_time
      t.string :website_link
      t.string :place_id
      t.float :latitude
      t.float :longitude
      t.boolean :visible
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
