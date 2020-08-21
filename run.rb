require_relative './config/environment'

system "clear"

cli = CLI.new

cli.clear

player = cli.welcome

until player.class == User
    player = cli.welcome
end 

sleep(1)
choice = cli.menu

until choice == "Exit" do
    cli.clear 
    if choice == "PLAY"
        menu_input = cli.play(player)
        if menu_input == "Main Menu"
            choice = cli.menu
        end
    elsif choice == "Profile Settings"
        menu_input = cli.profile(player)
        if menu_input == "Main Menu"
            choice = cli.menu
        end
    elsif choice == "View Leader Boards"
        menu_input = cli.leader_board(player)
        if menu_input == "Main Menu"
            choice = cli.menu
        end
    end

  end 
cli.exit_trivia(player)

