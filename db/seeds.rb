require 'rest-client'
require 'json'
require 'pry'
require 'pry-byebug'
require_relative '../config/environment'


#User.create(username: roy, )

Question.create(category: "General Knowledge", difficulty: "easy", question: "Which company did Valve cooperate with in the creation of the Vive?", correct_answer: "HTC", incorrect_answers: "Oculus, Google, Razer")

easy_general_knowledge = RestClient.get("https://opentdb.com/api.php?amount=50&category=9&difficulty=easy&type=multiple")
parsed = JSON.parse(easy_general_knowledge)


parsed["results"].each do |question|
  question.delete("type")
  question["incorrect_answers"] = question["incorrect_answers"].join(", ") 
  Question.create(question)

end



# binding.pry
Pry.start


