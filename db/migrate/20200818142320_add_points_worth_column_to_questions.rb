class AddPointsWorthColumnToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :points_worth, :integer
  end
end
