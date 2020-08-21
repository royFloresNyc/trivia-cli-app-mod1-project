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
            menu.choice "Log-in"
            menu.choice "Sign-up"
        end
        choice == "sign-up" ? player = User.sign_up : player = User.log_in
    end

    def menu
        prompt = TTY::Prompt.new(active_color: :cyan)

        input = prompt.select("\nPlease choose from the following options:") do |menu|
            menu.choice "PLAY"
            menu.choice "Profile Settings"
            menu.choice "View Leader Boards"
            menu.choice "Exit"
        end
    end

    def play(user)
        prompt = TTY::Prompt.new(active_color: :cyan)

        chances = user.chances 

        while  chances > 0
            chosen_category = prompt.select("\nPlease select from the following categories:", Question.all_categories.concat(["Main Menu"]))
            difficulty_level = user.get_difficulty_level

            if chosen_category != "Main Menu"
                new_question = user.get_a_valid_question(chosen_category, difficulty_level)
                answer = new_question.question_and_answer

                if answer == new_question.correct_answer
                    user.total_points += new_question.points_worth
                    user.save
                    AnsweredQuestion.create(answered_correctly: true, user_id: user.id, question_id: new_question.id)
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
                self.clear
                return "Main Menu"
            end 
        end 
        puts "\nYou've run out of chances! Better luck next time."
        sleep(3)
        self.clear
        return "Main Menu"
    end

    def view_profile(user)
        table = TTY::Table.new [['username', "#{user.username}"],["total points","#{user.total_points}"],["level","#{user.level}"],["chances", "#{user.chances}"], ["current ranking", "#{user.current_ranking}"]]
        puts table.render(:ascii, padding: [0,1,0,1])
    end

    def profile(user)
        prompt = TTY::Prompt.new(active_color: :cyan)
        input = prompt.select("\nPlease choose from the following options:") do |menu|
            menu.choice "View Profile"
            menu.choice "Change Username"
            menu.choice "Change Password"
            menu.choice 'Delete Profile'
            menu.choice "Main Menu"
        end
        until input == "Main Menu"
            if input == "View Profile"
                self.view_profile(user)
                input = self.profile(user)
            elsif input == "Change Username"
                puts "Please enter a new username:"
                new_username = gets.chomp
                already_exist = User.find_by(username: new_username)
                if already_exist 
                    puts "\nChosen username is already in use."
                    self.clear
                else
                    user.update_username(new_username)
                    input = self.profile(user)
                end 
            elsif input == "Change Password"
                new_password = prompt.mask("Please enter a new password:")
                user.update_password(new_password)
                input = self.profile(user)
            elsif input == "Delete Profile"
                user.destroy
                puts "We're sad to see you go! We hope you had fun playing Trivia."
                exit
            end 
        end
        self.clear
        input 
    end

    def leader_board(user)
        prompt = TTY::Prompt.new(active_color: :cyan)
        input = prompt.select("\nPlease choose from the following options:") do |menu|
            menu.choice "Your Current Ranking"
            menu.choice "Top 10 by Points"
            menu.choice "Top 10 by Percentage Correct"
            menu.choice "Main Menu"
        end
      
        if input == "Your Current Ranking"
            box =  TTY::Box.frame "#{user.username}, you're currently at position #{user.current_ranking}!", padding: 1
            puts "\n#{box}"
            input = self.leader_board(user)
        elsif input == "Top 10 by Points"
            puts User.top_ten_by_points
            input = self.leader_board(user)
        elsif input == "Top 10 by Percentage Correct"
            puts User.top_ten_by_percentage_correct
            input = self.leader_board(user)
        else 
            self.clear
            input
        end 
    end   

    def exit_trivia(player)
        self.clear
        puts "\nThanks for playing #{player.username}, see you next time!"
    end
   
end