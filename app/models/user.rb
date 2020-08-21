class User < ActiveRecord::Base
    has_many :answered_questions
    has_many :questions, through: :answered_questions

    def self.sign_up
        prompt = TTY::Prompt.new(active_color: :cyan)
        puts "\nPlease select a username"
        username = gets.chomp
        user = User.find_by(username: username)
        
        if user
            User.log_in
        else
            password = prompt.mask("Please enter a password")
            User.create(username: username, password: password, total_points: 0, level: 1, chances: 3) 
        end
    end

    def self.log_in
        prompt = TTY::Prompt.new(active_color: :cyan)
        sleep(1)
        puts "\nPlease enter your username"
        username = gets.chomp
        sleep(1)
        password = prompt.mask("Please enter a password")
        user = User.find_by(username: username, password: password)

        if !user
            puts "\nUsername and password don't match"
            return nil
        else
            user.chances = 3
            user.save
            puts "\nWelcome back #{user.username}!"
            user
        end 
    end

    def self.top_ten_by_points
        users = User.order(total_points: :desc).limit(10)
        table = TTY::Table.new ['position','username','total points'], [["","",""]]
        index = 1
        users.map do |user|
            table << ["#{index}", "#{user.username}", "#{user.total_points}"]
            index += 1
        end
        table.render(:ascii, padding: [0,1,0,1])
    end
    
    def self.top_ten_by_percentage_correct 
        table = TTY::Table.new ['position','username','percent correct'], [["","","" ]]
        index = 1
        user_percentages = User.all.sort {|a, b| a.percentage_correct <=> b.percentage_correct }.reverse.take(10).map do |user|
             table << ["#{index}","#{user.username}","#{user.percentage_correct}"]
             index += 1
        end
        table.render(:ascii, padding: [0,1,0,1])
    end 

    def current_ranking
        User.order(total_points: :desc).index(self) + 1
    end

    def answered_questions
        AnsweredQuestion.all.filter{ |aq| aq.user_id == self.id}  
    end

    def total_questions_correct
        if self.answered_questions.count > 0
            self.answered_questions.filter{|aq| aq.answered_correctly == true}.count
        else
            return 0
        end 
    end 

    def percentage_correct
        if self.answered_questions.count > 0
            ((self.total_questions_correct.to_f / self.answered_questions.count.to_f) * 100.0).round
        else
            return 0
        end 
    end

    def get_difficulty_level
        if self.level == 1
            "easy"
        elsif self.level == 2
            "medium"
        else
            "hard"
        end
    end 

    def already_answered?(question)
        found = self.answered_questions.select do |aq|
            aq.question_id == question.id
        end
        
        if found == []
            false
        else
            true
        end 
    end 

    def get_a_valid_question(category, difficulty)
        current_question = Question.get_question_by(category, difficulty)
        already_answered = self.already_answered?(current_question)
        
        while already_answered
            current_question = Question.get_question_by(category, difficulty)
            already_answered = self.already_answered?(current_question)
        end 

        current_question
    end 

    def level_up
        level = self.get_difficulty_level

        answered_correctly = self.answered_questions.select do |qa|
            qa.answered_correctly == true
        end.map do |qa|
            Question.find(qa.question_id)
        end.select do |question|
            question.difficulty ==level
        end
        
        if answered_correctly.count >= 10
            self.level += 1
            self.save
            puts "\nYou've leveled up! You're now on level #{self.level}!"
        else
            puts "\nYou're still on level #{self.level}. Answer #{10 - answered_correctly.count} more questions correctly to level up!"
        end
    end

    def update_username(new_username)
        self.username = new_username
        self.save
        self
    
    end

    def update_password(new_password)
        self.password = new_password
        self.save
        self
    end

end

