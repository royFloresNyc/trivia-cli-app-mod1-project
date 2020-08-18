require_relative './config/environment'
require "pry"


cli = CLI.new
player = cli.welcome
choice = cli.menu
until choice == "exit" do 
    if choice == "view profile"
      player.view_profile
      choice = cli.menu
    elsif choice == "view leader boards"
      menu_input = player.leader_board
      until menu_input == "main menu"
        player.leader_board
        menu_input = player.leader_board
      end
      choice = cli.menu
    end
  end 
cli.exit(player)
#Pry.start

