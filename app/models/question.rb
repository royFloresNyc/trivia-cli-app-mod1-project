class Question < ActiveRecord::Base
  has_many :answered_questions
  has_many :users, through: :answered_questions

  def self.get_question_by(category, difficulty)
    Question.filter {|question| question.category == category && question.difficulty == difficulty}
  end
end