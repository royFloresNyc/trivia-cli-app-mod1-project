require 'pry'
require_relative 'cli.rb'
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

  def view_profile
    puts "username: #{self.username}"
    puts "total points: #{self.total_points}"
    puts "level: #{self.level}"
    puts "chances: #{self.chances}"
  end

  def self.top_ten_by_points
    users = User.order(total_points: :desc).limit(10)
    users.map do |user|
      puts "#{user.username}: #{user.total_points}"
    end
  end
  

  def current_ranking
    users = User.order(total_points: :desc)
    index = users.index(self)
    puts "#{self.username}, you're currently at position #{index + 1}"
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

  def self.top_ten_by_percentage_correct 
    user_percentages = User.all.sort {|a, b| a.percentage_correct <=> b.percentage_correct }.map do |user|
      "#{user.username}: #{user.percentage_correct}"
    end.reverse
    puts user_percentages
  end 

  # def leader_board
  #   prompt = TTY::Prompt.new(active_color: :cyan)

  #   input = prompt.select("Please choose from the following options:") do |menu|
  #     menu.choice "your current ranking"
  #     menu.choice "top 10 by points"
  #     menu.choice "top 10 by percentage correct"
  #     menu.choice "main menu"
  #   end
  #   until input == "main menu"
  #     if input == "your current ranking"
  #       self.current_ranking
  #       input = self.leader_board
  #     elsif input == "top 10 by points"
  #       User.top_ten_by_points
  #       input = self.leader_board
  #     elsif input == "top 10 by percentage correct"
  #       User.top_ten_by_percentage_correct
  #       input = self.leader_board
  #     end 
  #   end
  #   cli.menu 
  # end 

  def leader_board
      prompt = TTY::Prompt.new(active_color: :cyan)
  
      input = prompt.select("Please choose from the following options:") do |menu|
        menu.choice "your current ranking"
        menu.choice "top 10 by points"
        menu.choice "top 10 by percentage correct"
        menu.choice "main menu"
      end
     
        if input == "your current ranking"
          self.current_ranking
          input = self.leader_board
        elsif input == "top 10 by points"
          User.top_ten_by_points
          input = self.leader_board
        elsif input == "top 10 by percentage correct"
          User.top_ten_by_percentage_correct
          input = self.leader_board
        elsif input == "main menu"
          "main menu"
        end 
      end
       
     

end

