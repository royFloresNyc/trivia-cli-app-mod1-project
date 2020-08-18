require 'pry'
class User < ActiveRecord::Base
  has_many :answered_questions
  has_many :questions, through: :answered_questions


  def self.sign_up
    prompt = TTY::Prompt.new(active_color: :cyan)
    puts "Please select a username"
    username = gets.chomp
    user = User.find_by(username: username)
    if user
      User.log_in
    else
      password = prompt.mask("Please enter a password")
      User.create(username: username, password: password, total_points: 0, level: 1, chances: 3) 
    end
  end

  def self.log_in
    prompt = TTY::Prompt.new(active_color: :cyan)

    puts "Please enter your username"
    username = gets.chomp
    password = prompt.mask("Please enter a password")
    user = User.find_by(username: username, password: password)
    #binding.pry
    if !user
      puts "Username and password don't match"
      User.log_in
    end
    user
  end


  def play

  end

  def view_profile
    puts "username: #{self.username}"
    puts "total points: #{self.total_points}"
    puts "level: #{self.level}"
    puts "chances: #{self.chances}"
  end

  def self.top_ten_by_points
    User.order(total_points: :desc).limit(10)
  end
  

  def answered_questions
    AnsweredQuestion.all.filter{ |aq| aq.user_id == self.id}
  end

  def total_questions_correct
    if self.answered_questions.count > 0
       self.answered_questions.filter{|aq| aq.answered_correctly = true}.count
    else
      return 0
    end 
  end 

  def percentage_correct
    if self.answered_questions.count > 0
    (self.total_questions_correct / self.answered_questions.count) * 100
    else
      return 0
    end 
  end

  def self.top_10_by_percentage_correct 
    user_percentages = User.all.map do |user|
      "#{user.username}: #{user.percentage_correct}"
    end.s
  end 

  def leader_board

  end

end