require_relative './config/environment'
require "pry"
system "clear"

cli = CLI.new

cli.clear
# font = TTY::Font.new(:standard)
# pastel = Pastel.new
# puts pastel.cyan(font.write("TRIVIA", letter_spacing: 1))

player = cli.welcome

until player.class == User
    player = cli.welcome
end 

sleep(1)
choice = cli.menu

until choice == "exit" do
    cli.clear 
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
        menu_input = cli.leader_board(player)
        until menu_input == "main menu"
            cli.leader_board(player)
            menu_input = cli.leader_board(player)
        end
        choice = cli.menu
    end
  end 
cli.exit(player)
#Pry.start

