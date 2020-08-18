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
end