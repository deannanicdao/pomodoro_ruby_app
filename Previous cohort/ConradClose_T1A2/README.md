# Game of Death

## Table of Contents
* [Referenced material](#R3-Referenced-material)
* [Repository](#R4-Repository)
* [Purpose and Scope](#R5-Purpose-&-Scope)
* [Features](#R6-Features)
* [Outline](#R7-Outline)
* [Gameplay Loop](#R8-Gameplay-Loop-Diagram)
* [Implementation Plan](#R9-Implementation-Plan)
* [Help](#R10-Help)

## R3. Referenced Material
For character names and story background:
https://en.wikipedia.org/wiki/Game_of_Death



## R4. Repository:
https://github.com/Radicals27/game_of_death

## R5. Purpose & Scope
'Game of Death' is a text-based adventure/combat game made in Ruby, based on the Bruce Lee movie by the same name.  It is designed to be an interactive story which allows the player to engage in text-based combat with various enemies.  Each enemy has a unique personality who will engage with the player.

The aim of the game will be to reach the 5th and final level and defeat the last opponent there.
There will be no guarantee that the player will make it that far as the enemies are challenging in their own ways.

This game aims to solve the problem of making a text-based game with limited graphical capabilities that is still engaging, captivating and fun for a wide range of players.  It will do this through humour, colour and randomised enemy behaviours to provide a stimulating and unpredictable experience.

It is targeted towards people aged 15 and up who enjoy computer games, as it does contain some violence and adult themes.

To use the program, a player simply runs the game_of_death.rb file and follows the user-friendly prompts. The inputs are limited to one or two characters at a time and any input errors are handled and displayed to the user immediately. A typical game lasts about 5 minutes, but can be completed as quickly as 2 minutes if so desired.

This project was completed as Assignment 1 for the Fast-track program at Coder Academy in March 2020.  During development, the developer aimed to use D.R.Y (Don't repeat yourself) principles while coding, and to create sufficient documentation both inside the code (comments), within the program (prompts), and alongside it (Readme.md).

## R6. Features
* Text-based interactive combat system.
* A comprehensive damage system allowing players and enemies to target specific body parts with unique consequences (having 2 damaged arms means you can no longer punch, for example.)
* Unique battles with unique characters; Each enemy has their own personality and quotes/taunts as well as weaknesses and strengths for the player to discover and exploit.

## R7. Outline

From the start of the game, the user will be prompted with their options via keys they can press (expressed by parenthesis surrounding a given key; (p) for the "p" button, for instance).  At any given moment if there is not a prompt there will be text printing to the screen which the user needs to read.

When the user is prompted, they simply need to press one of the prompted keys then press enter.  This choice then goes into the game and the consequences are displayed.

Any errors that are encountered, such as invalid user input, will prompt the user to enter a valid input, until they do.

## R8. Gameplay loop Diagram
Please refer to the UML diagram (linked below) for a visual representation of the gameplay loop.

[Game of Death UML Diagram](https://github.com/Radicals27/game_of_death/blob/master/docs/Game%20of%20Death.png)

## R9. Implementation Plan

### Combat System
For the text-based combat system, it was decided after careful consideration that classes would be an ideal method to implement such an idea.  Classes allow tracking of instance variables or attributes, such as "health" and "accuracy", as well as functions, such as those involved in calculating damage and whether or not an attack has hit an opponent.  Both the player and the enemies could be represented this way to minimise code and maintain D.R.Y standards.  An enemy-specific class would be ideal, that inherits from the "Human" class, so that enemy specific actions such as speaking, could take place.

Once the UML flow chart was completed, it became clear that a seperate method for fighting (between player and a given enemy) and an initial "main" method would be necessary to hold all of the contents.

As dialogue would play a large part in the games functionality, arrays were needed to store the various dialogues that enemies could speak.  It was decided to store these in methods which would return either a random sample, or elements from a sub-array in the case of enemy-specific dialogue. (dialogue[3][element] for the 3rd enemies dialogue element, for example.)

Methods, classes and data (dialogue and verbose location descriptions) would be split into their own ruby (.rb) files.  The main program, containing the main method (and its initial call), as well as the "require" codes and class initialisations, would be placed in the game_of_death.rb file.  A 'tests.rb' file was created to hold the testing methods used to validate functionality of class methods.

External gems were included to add to the game to add flair and improved visuals. These include colorize and tty-font.  Tty-font allows printing of large text using ASCII characters for the title screen.  Colorize allows printing some text in red, yellow and green for negative events (damage taken), low health and positive events (enemy defeated) respectively.

#### Checklist:
- Set up Human class, with Enemy class which inherits from Human
- Create a hash to store Limbs and their health values
- Create class methods for taking damage, checking if an attack has hit and checking if an enemy can still fight
- Create dialogue and location method to return pre-written spoken dialogue and location descriptions
- Install bundler and create Gem file with necessary Gem references


### Damage System

The handling of damage will occur between class/instance variables and methods.  For example, when the player selects to attack an enemy with a punch and chooses to target their right arm, the "take_damage" method writes to the recipients "@limbs" hash, finds the matching targeted limb, and subtracts the final "damage" amount from its stored value.

The damage caused by punches is affected by the health of the puncher's arms.  Same for kicks.  If an enemy specialises in kicks, it pays to target their legs.

If enough damage is done to the recipients limb, it becomes crippled and cannot be used.  2 crippled arms means the person cannot punch, 2 crippled legs means they cannot kick, a crippled head severely affects accuracy, and other limbs have no effect.  Each unit of damage that is done to a limb also reduces the person's health.  When their health is 0, they are defeated.  Or if their randomised "weakness" (a randomly selected limb) is crippled, they are also defeated.

#### Checklist:
- Create 'fight' method, which takes a player and enemy object and has them battle, with prompts
- Incorporate checks for player and enemy's ability to fight (0 health?) and handle both outcomes
- Check if both arms are crippled, if so, they cannot punch.
- When calculating damage, factor in arms or legs health for punches/kicks respectively.
- Check if both legs are crippled, if so, they cannot kick.
- For each unit of damage their head takes, reduce their accuracy by that amount.
- If the damaged limb reaches 0hp and is the enemy's weakness, the player wins the battle.

#### Methods:
- game_of_death.rb
    - main()

- methods.rb
    - fight(player, location, enemies)
    - slow_print(message, speed)
    - display_stats(person)
    - higher(num1, num2)
    - pause(message)

- classes.rb
    - Human class
        - initialize(name, health, accuracy, location, - prefers_attack)
        - get_random_limb()
        - get_combat_options()
        - attack_has_hit(attack_type)
        - take_damage(body_part, damage)
        - check_ability_to_fight

    - Enemy < Human class
        - initialize(name, health, accuracy, location, prefers_attack)
        - talk(struck_limb)

- data.rb
    - location_descriptions(index, player)
    - taunts()
    - speak(index, struck_limb, weak_limb)
    - damage_message(limb)

### Unique battles with Unique characters
The game aims to have a comical feel, with verbose opponents who taunt and poke fun at the player when he misses attacks.  Sometimes opponents will even reveal their weaknesses, so it pays to pay attention.  When an enemy speaks, it is randomly selected from an array, so each battle is slightly different.  A player hopefully feels encouraged to play the game through multiple times to discover each piece of dialogue.

#### Checklist:
- Write detailed, witty dialogues for the opponents
- Write at least 6 dialogue options for each opponent in combat
- Randomly select & return dialogue from an array within a method, when called
- Write a method that slowly prints text to the screen, as if being typed
- Create combat messages showing strike locations and damage dealt to the player

Please refer to the Trello Board (linked below) for the implementation plan:

https://trello.com/b/M8VsoZnM/game-of-death

or:

[Offline version](https://github.com/Radicals27/game_of_death/blob/master/docs/gameofdeathtrellofinal.png)

## R10. Help

### Introduction & Installation

Welcome to 'Game of Death', a short, action-adventure combat game based on the famous Bruce Lee movie from 1970's.

System Requirements: Any computer running Ruby 2.0+ and terminal (Ubuntu 1.8.0.4 was used to create this app) will run the app.  No other hardware or software is required.  Requisite Gems can be installed via Bundle, as detailed below.

To get started, install ruby in your terminal, then navigate to the folder where you placed /game_of_death/src

Then simply run:

```ruby
bundle install
```
In your terminal, to install all necessary Gems from the Gemfile automatically.

then run:

```ruby
./runme.sh
```
To start the game.  

NOTE: There is a command line option to change the player's name to another name.  To edit this, open "runme.sh" in a text editor and change the line:

```ruby
ruby ./game_of_death.rb "Bruce"
```

To something like:

```ruby
ruby ./game_of_death.rb "John"
```


You will be presented with the welcome screen and an introduction to what's happening in the story.

You will soon be prompted to choose either a punch or kick.  Just press "p" or "k" on your keyboard, followed by the enter key, to make your selection.

You will then be asked what body part to target on your opponent.

Pay attention to the status bar at the top of the screen!  It will give you an idea of which body parts are still healthy or weak.

### Guide to combat

Punching is much more accurate than kicking, but deals less damage.  The healthier your arms are, the more damage they do.  Kicking is less accurate but deals far more damage than punching, and the healthier your legs are, the more damage they do.

Attacking different body parts/limbs has different effects.  An opponent with 2 crippled arms cannot punch.  An opponent with 2 crippled legs cannot kick.  The same goes for you, too!

Every unit of damage a persons head takes, reduces their accuracy by 1 unit.  So it is possible to reduce someone's accuracy by 25 points (25%) by reducing their head to zero health.

Attacking the groin or torso have no special effects, except in the instance of...

### Weaknesses

Each opponent comes with a randomly-selected weakness.  A limb that when struck, will take 1.5x damage.  In addition to this, if it is crippled (reduced to 0 health) you will automatically win the fight!

Opponents will sometiems reveal their weaknesses to you when they speak, so pay attention!

### Replayability

Try to get through the game with more health at the final screen than your previous attempts!  Can you find all 5 enemies weaknesses?

Can you find/read all of the enemies random dialogue?

![Bruce Lee](https://thediplomat.com/wp-content/uploads/2013/12/sizes/medium/yellowjumpsuit_edited.jpg)