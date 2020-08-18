require_relative './config/environment'
require "pry"


cli = CLI.new
player = cli.welcome
choice = cli.menu
until choice == "exit" do 
    if choice == "view profile"
        player.view_profile
        choice = cli.menu
    end
end 
cli.exit(player)
#Pry.start

