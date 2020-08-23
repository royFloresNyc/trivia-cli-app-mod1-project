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
        cli.play(player)
        choice = cli.menu
    elsif choice == "Profile Settings"
        cli.profile(player)
        choice = cli.menu
    elsif choice == "View Leader Boards"
        cli.leader_board(player)
        choice = cli.menu
    end
end 

cli.exit_trivia(player)

