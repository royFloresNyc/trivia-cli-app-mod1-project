require 'rest-client'
require 'json'
require 'pry'

Question.destroy_all

#Category: General Knowledge ============================================================================
easy_general_knowledge = RestClient.get("https://opentdb.com/api.php?amount=20&category=9&difficulty=easy")
parsed_easy_general_knowledge = JSON.parse(easy_general_knowledge)

parsed_easy_general_knowledge["results"].each do |question|
  question.delete("type")
  question["incorrect_answers"] = question["incorrect_answers"].join(", ") 
  Question.create(question)
end

medium_general_knowledge = RestClient.get("https://opentdb.com/api.php?amount=20&category=9&difficulty=medium")
parsed_medium_general_knowledge = JSON.parse(medium_general_knowledge)

parsed_medium_general_knowledge["results"].each do |question|
  question.delete("type")
  question["incorrect_answers"] = question["incorrect_answers"].join(", ") 
  Question.create(question)
end

hard_general_knowledge = RestClient.get("https://opentdb.com/api.php?amount=20&category=9&difficulty=hard")
parsed_hard_general_knowledge = JSON.parse(hard_general_knowledge)

parsed_hard_general_knowledge["results"].each do |question|
  question.delete("type")
  question["incorrect_answers"] = question["incorrect_answers"].join(", ") 
  Question.create(question)
end

#Category: Science & Nature ==============================================================================
easy_science_and_nature = RestClient.get("https://opentdb.com/api.php?amount=20&category=17&difficulty=easy")
parsed_easy_science_and_nature = JSON.parse(easy_science_and_nature)

parsed_easy_science_and_nature["results"].each do |question|
  question.delete("type")
  question["incorrect_answers"] = question["incorrect_answers"].join(", ") 
  Question.create(question)
end

medium_science_and_nature = RestClient.get("https://opentdb.com/api.php?amount=20&category=17&difficulty=medium")
parsed_medium_science_and_nature = JSON.parse(medium_science_and_nature)

parsed_medium_science_and_nature["results"].each do |question|
  question.delete("type")
  question["incorrect_answers"] = question["incorrect_answers"].join(", ") 
  Question.create(question)
end

hard_science_and_nature = RestClient.get("https://opentdb.com/api.php?amount=20&category=17&difficulty=hard")
parsed_hard_science_and_nature = JSON.parse(hard_science_and_nature)

parsed_hard_science_and_nature["results"].each do |question|
  question.delete("type")
  question["incorrect_answers"] = question["incorrect_answers"].join(", ") 
  Question.create(question)
end

#Category: Entertainment-Television ===========================================================================
easy_entertainment_television = RestClient.get("https://opentdb.com/api.php?amount=20&category=14&difficulty=easy")
parsed_easy_entertainment_television = JSON.parse(easy_entertainment_television)

parsed_easy_entertainment_television["results"].each do |question|
  question.delete("type")
  question["incorrect_answers"] = question["incorrect_answers"].join(", ") 
  Question.create(question)
end

medium_entertainment_television = RestClient.get("https://opentdb.com/api.php?amount=20&category=14&difficulty=medium")
parsed_medium_entertainment_television = JSON.parse(medium_entertainment_television)

parsed_medium_entertainment_television["results"].each do |question|
  question.delete("type")
  question["incorrect_answers"] = question["incorrect_answers"].join(", ") 
  Question.create(question)
end

hard_entertainment_television = RestClient.get("https://opentdb.com/api.php?amount=20&category=14&difficulty=hard")
parsed_hard_entertainment_television = JSON.parse(hard_entertainment_television)

parsed_hard_entertainment_television["results"].each do |question|
  question.delete("type")
  question["incorrect_answers"] = question["incorrect_answers"].join(", ") 
  Question.create(question)
end

#Pry.start


