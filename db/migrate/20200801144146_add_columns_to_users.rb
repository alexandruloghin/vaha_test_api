class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :type, :string
    add_column :users, :expertise, :string
  end
end
