class CreateTrivias < ActiveRecord::Migration[6.0]
  def change
    create_table :trivias do |t|
      t.string :category
      t.string :type
      t.string :difficulty
      t.string :question
      t.string :correct_answer
      t.string :incorrect_answers
    end
  end
end
