require 'pry'
class Question < ActiveRecord::Base
  has_many :answered_questions
  has_many :users, through: :answered_questions

    def self.get_question_by(category, difficulty)
        #Question.where
        Question.all.filter {|question| question.category == category && question.difficulty == difficulty}.sample
    end


  # def self.get_question_by(category, difficulty, user_id)
  #   answered_by_user = AnsweredQuestion.select do |aq|
  #     aq.user_id == user_id
  #     end

  #     not_answered = Question.all.select do |question|
  #       answered_by_user.each do |aq|
  #     question.id != aq.question_id
  #     end
  #     end
  #    not_answered.all.filter {|question| question.category == category && question.difficulty == difficulty && }.sample
  #  end

    def question_and_answer
        prompt = TTY::Prompt.new(active_color: :cyan)
        answers = "#{self.correct_answer}, #{self.incorrect_answers}"
        answers = answers.split(", ").shuffle

        choice = prompt.select("\n#{self.question}", answers)
    end

    def self.all_categories
        Question.all.map do |question|
            question.category
        end.uniq
    end

end

#general_knowedge = Question.get_question_by("General Knowledge", "easy")
#Pry.start

