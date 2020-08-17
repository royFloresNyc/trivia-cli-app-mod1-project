class User < ActiveRecord::Base
  has_many :answered_questions
  has_many :trivias, through: :answered_questions
end