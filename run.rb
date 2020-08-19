require_relative './config/environment'
require "pry"

cli = CLI.new
player = cli.welcome

until player.class == User
    player = cli.welcome
end 

sleep(1)
choice = cli.menu

until choice == "exit" do 
    if choice == "PLAY"
        menu_input = cli.play(player)
        until menu_input == "main menu"
            cli.play(player)
            menu_input = cli.play
        end
        choice = cli.menu
    elsif choice == "view profile"
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

