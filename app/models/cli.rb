require "tty-prompt"
require 'pry'

class CLI 
    def welcome
        prompt = TTY::Prompt.new(active_color: :cyan)

        choice = prompt.select("Welcome to Trivia! Please select one of the following:") do |menu|
            menu.choice "log-in"
            menu.choice "sign-up"
        end
        choice == "signup" ? player = User.sign_up : player = User.log_in
    # if choice == "sign-up"
    #   player = User.sign_up
    # else 
    #   player = User.log_in
    # end
    end

    def menu
        prompt = TTY::Prompt.new(active_color: :cyan)

        input = prompt.select("Please choose from the following options:") do |menu|
            menu.choice "PLAY"
            menu.choice "view profile"
            menu.choice "view leader boards"
            menu.choice "exit"
        end
    end

    def play(user)
        prompt = TTY::Prompt.new(active_color: :cyan)

        chances = user.chances 

        while  chances > 0
            chosen_category = prompt.select("Please select from the following categories:", Question.all_categories.concat(["main menu"]))
            difficulty_level = user.get_player_level

            if chosen_category != "main menu"
                new_question = user.get_a_valid_question(chosen_category, difficulty_level)
                answer = new_question.question_and_answer

                if answer == new_question.correct_answer
                    user.total_points += new_question.points_worth
                    user.save
                    AnsweredQuestion.create(answered_correctly: true, user_id: user.id, question_id: new_question.id)
                    #self.correct_image
                    puts "Correct! You've just earned #{new_question.points_worth} points!"
                    user.level_up
                else
                    puts "You got it wrong."
                    puts "The correct answer is #{new_question.correct_answer}"
                    AnsweredQuestion.create(answered_correctly: false, user_id: user.id, question_id: new_question.id)
                    user.chances -= 1
                    user.save
                    chances -= 1
                    puts "You have #{chances} chances left!"
                end 
                
            else
                return "main menu"
            end 
        end 
        puts "You've run out of chances! Better luck next time."
        return "main menu"
    end


    def exit(player)
        p "Thanks for playing #{player.username}, see you next time!"
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