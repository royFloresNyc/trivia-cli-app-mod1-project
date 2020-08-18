require "tty-prompt"
require 'pry'

class CLI 
  def welcome
    prompt = TTY::Prompt.new(active_color: :cyan)

    choice = prompt.select("Welcome to Trivia! Please select one of the following:") do |menu|
      menu.choice "log-in"
      menu.choice "sign-up"
    end
    if choice == "sign-up"
      player = User.sign_up
    else 
      player = User.log_in
    end
  end

  def menu
    prompt = TTY::Prompt.new(active_color: :cyan)

    choice = prompt.select("Please choose from the following options:") do |menu|
      menu.choice "PLAY"
      menu.choice "view profile"
      menu.choice "view leader boards"
      menu.choice "exit"
    end
  end

  if choice == "PLAY"
    Question.
  end

end

cli = CLI.new
#Pry.start