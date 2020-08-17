class CreateAnsweredQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :answered_questions do |t|
      t.boolean :answered_correctly
      t.belongs_to :user
      t.belongs_to :trivia
    end
  end
end
