class AddPurposesToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :maintainer, :boolean
    add_column :users, :enthusiast, :boolean
  end
end
