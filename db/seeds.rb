require 'rest-client'
require 'json'
require 'pry'

easy_general_knowledge = RestClient.get("https://opentdb.com/api.php?amount=50&category=9&difficulty=easy&type=multiple")
parsed = JSON.parse(easy_general_knowledge)
parsed

Pry.start


