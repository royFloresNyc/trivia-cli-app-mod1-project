require "tty-prompt"
require 'pry'

class CLI 
  
    def clear
        system "clear"
        font = TTY::Font.new(:standard)
        pastel = Pastel.new
        puts pastel.cyan(font.write("TRIVIA", letter_spacing: 1))
    end

    def welcome
        prompt = TTY::Prompt.new(active_color: :cyan)

        choice = prompt.select("\nWelcome to Trivia! Please select one of the following:") do |menu|
            menu.choice "log-in"
            menu.choice "sign-up"
        end
        choice == "sign-up" ? player = User.sign_up : player = User.log_in
    end

    def menu
        prompt = TTY::Prompt.new(active_color: :cyan)

        input = prompt.select("\nPlease choose from the following options:") do |menu|
            menu.choice "PLAY"
            menu.choice "view profile"
            menu.choice "view leader boards"
            menu.choice "exit"
        end
    end

    def leader_board(user)
        prompt = TTY::Prompt.new(active_color: :cyan)
        input = prompt.select("\nPlease choose from the following options:") do |menu|
            menu.choice "your current ranking"
            menu.choice "top 10 by points"
            menu.choice "top 10 by percentage correct"
            menu.choice "main menu"
        end
      
        if input == "your current ranking"
            puts "\n#{user.username}, you're currently at position #{user.current_ranking}!"
            input = self.leader_board(user)
        elsif input == "top 10 by points"
            puts User.top_ten_by_points
            input = self.leader_board(user)
        elsif input == "top 10 by percentage correct"
            puts User.top_ten_by_percentage_correct
            input = self.leader_board(user)
        elsif input == "main menu"
            "main menu"
        end 
    end

    def play(user)
        prompt = TTY::Prompt.new(active_color: :cyan)

        chances = user.chances 

        while  chances > 0
            chosen_category = prompt.select("\nPlease select from the following categories:", Question.all_categories.concat(["main menu"]))
            difficulty_level = user.get_difficulty_level

            if chosen_category != "main menu"
                new_question = user.get_a_valid_question(chosen_category, difficulty_level)
                answer = new_question.question_and_answer

                if answer == new_question.correct_answer
                    user.total_points += new_question.points_worth
                    user.save
                    AnsweredQuestion.create(answered_correctly: true, user_id: user.id, question_id: new_question.id)
                    #self.correct_image
                    puts "\nCorrect! You've just earned #{new_question.points_worth} points!"
                    user.level_up
                else
                    puts "\nYou got it wrong."
                    puts "\nThe correct answer is #{new_question.correct_answer}"
                    AnsweredQuestion.create(answered_correctly: false, user_id: user.id, question_id: new_question.id)
                    user.chances -= 1
                    user.save
                    chances -= 1
                    puts "\nYou have #{chances} chances left!"
                end 
                sleep(5)
                self.clear
            else
                return "main menu"
            end 
        end 
        puts "\nYou've run out of chances! Better luck next time."
        return "main menu"
    end


    def exit(player)
        self.clear
        puts "\nThanks for playing #{player.username}, see you next time!"
        
    end


#   def correct_image
#     puts "                                     
                                         
                                         
#                     # .                  
#                 ##(*#/#* ..              
#              #(#### /#*###/((#(/         
#           ######//# (########(*#//.(,    
#       .##################/####/ #(#/#.   
#     #########################/#,#,       
#  ###########################.*           
# #######################/#*                
# ######################/                     
# ###                   #####################                         
# ,#######                ,##################                             
# .##########################################                                 
# ##############           (##############                                    
# #############/        #############(                                      
# ##############     .############                                         
# ##* ###########   #############                                          
# ##*   ########## ###########*##                                          
# ##*     ##################  *##                                          
# ##*       ##############    *##                                          
# ##*         ##########      *##                                          
# ##*           ######        *##                                          
# ##*             ###         /##                                          
# /#############################/                                          
# .#######################.                                             
                                         
#     ".colorize(:light_green)                                     

# end

end

cli = CLI.new
#Pry.start