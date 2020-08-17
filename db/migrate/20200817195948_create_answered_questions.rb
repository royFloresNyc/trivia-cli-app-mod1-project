class CreateAnsweredQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :answered_questions do |t|
      t.boolean :answered_correctly
      t.integer :user_id
      t.integer :question_id
    end
  end
end
