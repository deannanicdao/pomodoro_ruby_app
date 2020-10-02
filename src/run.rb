require_relative './task_manager.rb'
require_relative './timer.rb'
# require_relative './clock.rb'
require 'ruby2d'

# Background music #
# menu_song = Music.new('./Sounds/menu_music_pomodoro_pal.mp3')
# rest_song = Music.new('./Sounds/rest_music_pomodoro_pal.mp3')

tasks = []
timers  = []
message = "Farewell"
seconds = 3
# chosen_timer = nil

loop do
    puts " ~ " * 20
    puts " " * 15 + "Welcome to PomodoroPal™"
    puts " ~ " * 20  
    puts " " * 10 + "What would you like to do first?"
    puts " "
        puts "(1) Begin Pomodoro session"
        puts "(2) Set Timers"
        puts "(3) Set Tasks"
        puts "(4) Pick a Pal"
        puts "(5) Settings"
        puts "(6) Help"
        puts "(7) Exit"
    puts " ~ " * 20
    option = gets.chomp

# logged_in_user = User.new(:username => username, :task_tickbox => false)

# CSV.open("tasks_to_do.csv", "w", headers: true) do |csv|
#     csv << [:username, :task_title, :task_note, :task_tickbox]
# end


puts " " * 10 + "What would you like to do?"
puts " "
puts "(1) Begin Pomodoro session"
puts "(2) Set Timers"
puts "(3) Set Tasks"
puts "(4) Pick a Pal"
puts "(5) Settings"
puts "(6) Help"
puts "(7) Exit"
puts " ~ " * 20
option = gets.chomp 

system('clear')

while option != "7"

    if option == "1"
        system('clear')
        check_timer_list(timers)
        puts ""
        if timers.empty? == false
            puts "Choose a timer (enter a number)"
            input_timer = gets.chomp.to_i - 1
            if timers.include?(timers.at(input_timer)) == true
                chosen_timer = timers.at(input_timer)
                puts "Your timer settings are:"
                puts "Work timer: #{chosen_timer[0].to_f / 60 } min"
                puts "Rest timer: #{chosen_timer[1].to_f / 60 } min"

                puts "Number of sessions:"
                input = gets.chomp.to_i
                # @session = Session.new(input)
                session = 1
                session_total = input
                    # raise error if session_numer <= 0
                    # raise error if session_numer != Integer
                
                puts "Ready to begin? (Y/N)"
                input = gets.chomp.upcase

                if input == "Y"
                    session_total.times do
                        # WORK TIMER SESSION
                        puts "Session #{session} / #{session_total}"
                        puts "Starting work timer in..."
                        sleep(1)
                        loading(3)
                        countdown(chosen_timer[0])
                        puts "Your work timer is finished"
                        sleep(1)
                        system('clear')

                        # REST TIMER SESSION
                        puts "Session #{session} / #{session_total}"
                        puts "Starting rest timer in..."
                        sleep(1)
                        loading(3)
                        countdown(chosen_timer[1])
                        puts "Your rest timer is finished"
                        sleep(1)
                        system('clear')

                        break if session == session_total
                        session += 1

                        puts "Next session is starting in..."
                        sleep(1)
                        loading(3)
                        system('clear')
                    end
                    
                    puts "Your session has ended"
                    puts "Would you like to:"
                    puts "(a) return to menu"
                    puts "(b) exit"
                    input = gets.chomp

                    if input == "a"
                        chosen_timer = nil
                    elsif input == "b"
                        system('clear')
                        puts "#{message.to_s}!"
                        @death.play
                        sleep(1)
                        exit
                    else
                        puts "Please select a valid option: 'a' or 'b'"
                    end

                elsif input == "N"
                    chosen_timer = nil
                    next
                else
                    puts "Please select 'Y' or 'N'"
                end
            elsif timers.include?(timers.at(input_timer)) == false or input_timer != Integer
                puts "Invalid number. Please enter a number from the list."
                redo
            else
                puts "Invalid input. Please enter a number from the list."
            end
        end
    elsif option == "2"
        puts "What would you like to do?"
        puts "(1) Create timers"
        puts "(2) View timers"
        puts "(3) Delete timers"
        
        option = gets.chomp

        case option

        when "1"
            puts "Work timer (min):"
            work_timer = gets.chomp.to_f * 60
            #   raise error when work_timer != Integer or < 0
            puts "Rest timer (min):"
            rest_timer = gets.chomp.to_f * 60
            #   raise error when work_timer != Integer or < 0
            timers << [work_timer, rest_timer]
            check_timer_list(timers)
            
        when "2"
            check_timer_list(timers)
            puts "press enter to return to menu"
            input = gets
                if input
                    next
                else
                    wait
                end
            
        when "3"
            check_timer_list(timers)
            if timers.empty? == false
                puts "Choose a timer to delete"
                input_timer = gets.chomp.to_i - 1

                puts "Would you like to delete this timer? (Y/N)"
                puts "Work timer: #{timers[input_timer][0].to_f / 60 } min | Rest timer: #{timers[input_timer][1].to_f / 60 } min"
                answer = gets.chomp.upcase

                if answer == "Y"
                    timers.delete_at(input_timer)
                elsif answer == "N"
                    next
                else
                    puts "Please enter a valid timer to delete."            # TEST THIS CONDITION TOMORROW
                end
            end
        else
            return
        end
    elsif option == "3"    # TASK MANAGER
        puts "What would you like to do?"
            puts "(1) Create task"
            puts "(2) View tasks"
            puts "(3) Edit/Update tasks"
            puts "(4) Delete tasks"
    
        option = gets.chomp

        case option

        when "1"
            
        when "2"
            check_task_list(tasks)
            puts "press enter to return to menu"
            input = gets
                if input
                    next
                else
                    wait
                end
        when "3"
            check_task_list(tasks)
            if task.empty? == false
                puts "Choose a task to delete"
                input_task = gets.chomp.to_i - 1

                puts "Would you like to delete this task? (Y/N)"
                # "#{index+1}. Work timer: #{timer[0].to_i / 60 } min | Rest timer: #{timer[1].to_i / 60} min"
                # puts "Work timer: #{timers[input_timer][0].to_i / 60 }min | Rest timer: #{timers[input_timer][1].to_i / 60 }min"
                # puts "Timer #{timers[input_timer].to_i / 60}?"
                answer = gets.chomp.upcase

                if answer == "Y"
                    tasks.delete_at(input_task)
                elsif answer == "N"
                    next
                else
                    puts "Please enter a valid timer to delete."            # TEST THIS CONDITION TOMORROW
                end
            end

        when "4"
            check_timer_list(timers)
            if timers.empty? == false
                puts "Choose a timer to delete"
                input_timer = gets.chomp.to_i - 1

                puts "Would you like to delete this timer? (Y/N)"
                puts "Work timer: #{timers[input_timer][0]}min | Rest timer: #{timers[input_timer][1]}min"
                answer = gets.chomp.upcase

                if answer == "Y"
                    timers.delete_at(input_timer)
                elsif answer == "N"
                    next
                else
                    puts "Please enter a valid timer to delete."            # TEST THIS CONDITION TOMORROW
                end
            end

        when "5"
            puts "Who would you like to assign this task to?"
            username = gets.chomp.lowercase
               # if username is found in csv 
                    # then add task with said username to csv
                    # print csv with said username
               # elsif username is not found in csv
                    puts "User not found. Would you like to make a new user?"
                    input = gets.chomp.lowercase
                    if input == "y"
                        puts "Username:"
                        username = gets.chomp.lowercase
                    elsif input == "n"
                        puts "These are the current tasks and users."
                        check_task_list(tasks)
                    else
                        puts "Input invalid. Please select (Y/N)"
                    end
        end
        
    elsif option == "4"    # PICK A PAL
    elsif option == "5"    # SETTINGS
        # case for music setting
        # case for alarm setting
        
    elsif option == "6"    # HELP
        # puts help manual here
    end

system('clear')

puts " " * 10 + "What would you like to do?"
puts " "
puts "(1) Begin Pomodoro session"
puts "(2) Set Timers"
puts "(3) Set Tasks"
puts "(4) Pick a Pal"
puts "(5) Settings"
puts "(6) Help"
puts "(7) Exit"
puts " ~ " * 20
option = gets.chomp 

system('clear')
end

system('clear')
puts "#{message.to_s}!"
@death.play
sleep(1)
exit