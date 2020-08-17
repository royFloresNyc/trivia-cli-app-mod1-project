require 'rest-client'
require 'json'
require 'pry'


#User.create(username: roy, )

easy_general_knowledge = RestClient.get("https://opentdb.com/api.php?amount=50&category=9&difficulty=easy&type=multiple")
parsed = JSON.parse(easy_general_knowledge)


parsed["results"].each do |question|
  question["incorrect answer"] = question["incorrect answers"].join(", ") 
  Question.create(question)

end




#Pry.start


