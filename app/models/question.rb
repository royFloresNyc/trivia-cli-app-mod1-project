class Question < ActiveRecord::Base
  has_many :answered_questions
  has_many :users, through: :answered_questions

    def self.get_question_by(category, difficulty)
        Question.all.filter {|question| question.category == category && question.difficulty == difficulty}.sample
    end

    def self.all_categories
        Question.all.map { |question| question.category }.uniq
    end

    def question_and_answer
        prompt = TTY::Prompt.new(active_color: :cyan)
        answers = "#{self.correct_answer}, #{self.incorrect_answers}"
        answers = answers.split(", ").shuffle

        choice = prompt.select("\n#{self.question}", answers)
    end

    #used to reformat enoding errors when getting data from API

    # def self.question_fix_spelling
    #     Question.all.each do |question|
    #     question.question = question.question.gsub(/(\&\#039\;|\&quot\;|\&deg\;)/, '&#039;' => "'", '&quot;'=> '"', '&deg;' => '°')
    #     question.correct_answer = question.correct_answer.gsub(/(\&\#039\;|\&quot\;|\&deg\;)/, '&#039;' => "'", '&quot;'=> '"', '&deg;' => '°')
    #     question.incorrect_answers = question.incorrect_answers.gsub(/(\&\#039\;|\&quot\;|\&deg\;)/, '&#039;' => "'", '&quot;'=> '"', '&deg;' => '°')
    #     question.save
    #     end
    # end

end
