class Trivia < ActiveRecord::Base
  has_many :answered_questions
  has_many :users, through: :answered_questions

end