require 'pry'
class Question < ActiveRecord::Base
  has_many :answered_questions
  has_many :users, through: :answered_questions

  def self.get_question_by(category, difficulty)
    Question.all.filter {|question| question.category == category && question.difficulty == difficulty}.sample
  end

  def question_and_answer
    prompt = TTY::Prompt.new(active_color: :cyan)
    answers = "#{self.correct_answer}, #{self.incorrect_answers}"
    answers = answers.split(", ").shuffle

    choice = prompt.select(self.question, answers)
  end



end

#general_knowedge = Question.get_question_by("General Knowledge", "easy")
#Pry.start