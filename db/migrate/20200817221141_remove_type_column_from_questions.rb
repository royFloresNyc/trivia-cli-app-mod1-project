class RemoveTypeColumnFromQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :type
  end
end
