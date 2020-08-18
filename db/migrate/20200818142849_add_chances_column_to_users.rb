class AddChancesColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :chances, :integer
  end
end
