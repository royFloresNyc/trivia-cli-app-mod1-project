class AnsweredQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :trivia
end