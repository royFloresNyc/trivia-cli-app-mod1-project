trivia-mod1-project
====================

# Welcome to trivia!
---

A game to test your knowledge about random facts.

**Installation Instructions:**

- clone down
- run bundle install
- run `ruby run.rb`

**Functionalities**

- User can either log in or sign up for an account. 
- User accounts track position, total points, and user level
    - User has ability to view their pofile with these stats
- User has the option to view the following leaderboards
    - Top 10 by points
    - Top 10 by percentage (correctly answered questions)
- When user plays the game:
    - User can select a category. Current categories include:
        - General Knowledge
        - Science & Nature
        - Entertainment - Television
    - User receives randomly selected questions based on user's level
    - Questions are a mix of "True of False" and "Multiple choice" 
    - Game is programmed so that users will not receive the same question more than once
    - User's points get updated for every correctly answered question
    - User has 3 chances upon log-in, and chances are deducted when User answers incorrectly
    - User can level up once they have answered 10 questions in current level correctly, giving them access to questions in the next difficulty level
- User can update their profile
    - change username
    - change password
    - delete profile
