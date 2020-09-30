require_relative './task_manager.rb'
require_relative './timer.rb'
require_relative './clock.rb'
require 'ruby2d'

menu_song = Sound.new('./Sounds/menu_music_pomodoro_pal.mp3')
alert = Sound.new('./Sounds/tamagotchi-alert.wav')
rest_song = Sound.new('./Sounds/rest_music_pomodoro_pal.mp3')
option_select = Sound.new('./Sounds/menu_select_pomodoro_pal.mp3')
death = Sound.new('./Sounds/death_pomodoro_pal.wav')
feed = Sound.new('./Sounds/feed_pomodoro.wav')

tasks = []
timers  = []
# chosen_timer = nil


loop do
    set title: "PomodoroPal™", background: 'blue', width: 640, height: 480, resizeable: true, borderless: false
    alert.play
    sleep(1)
    # menu_song.play
    feed.play
    sleep(1)
    death.play
    sleep(1)



    system('clear')
    puts " ~ " * 20
    puts " " * 15 + "Welcome to PomodoroPal™"
    puts " ~ " * 20

    # puts "Enter your name:"
    # username = gets.chomp.lowercase

    # logged_in_user = User.new(:username => username, :task_tickbox => false)

    # CSV.open("tasks_to_do.csv", "w", headers: true) do |csv|
    #     csv << [:username, :task_title, :task_note, :task_tickbox]
    # end
    

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

    system('clear')

    case option
    when "1"
        puts ""
        check_timer_list(timers)
        puts ""
        if timers.empty? == false
            puts "Choose a timer (enter a number)"
            input_timer = gets.chomp.to_i - 1
            if timers.include?(timers.at(input_timer)) == true
                chosen_timer = timers.at(input_timer)
                puts "Your timer settings are:"
                puts "Work timer: #{chosen_timer[0].to_i / 60 } min"
                puts "Rest timer: #{chosen_timer[1].to_i / 60 } min"
                puts "Ready to begin? (Y/N) "
                input = gets.chomp.upcase
                if input == "Y"
                    countdown(chosen_timer[0])
                    puts "Your work timer is finished."
                    alert.play
                    puts "Starting rest timer:"
                    rest_song.play
                    countdown(chosen_timer[1])
                    puts "Your session has ended"
                    puts "Would you like to:"
                    puts "(a) return to menu"
                    puts "(b) exit"

                    if input == "a"
                        chosen_timer = nil
                        next
                    elsif input == "b"
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
    when "2"
        puts "What would you like to do?"
        puts "(1) Create timers"
        puts "(2) View timers"
        puts "(3) Delete timers"
        
        option = gets.chomp

        case option

        when "1"
            puts "Work timer (min):"
            work_timer = gets.chomp.to_f * 60
            puts "Rest timer (min):"
            rest_timer = gets.chomp.to_f * 60
            timers << [work_timer, rest_timer]
            check_timer_list(timers)
            sleep(2)
            # next  
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
                puts "Work timer: #{timers[input_timer][0].to_i / 60 } min | Rest timer: #{timers[input_timer][1].to_i / 60 } min"
                answer = gets.chomp.upcase

                if answer == "Y"
                    timers.delete_at(input_timer)
                elsif answer == "N"
                    next
                else
                    puts "Please enter a valid timer to delete."            # TEST THIS CONDITION TOMORROW
                end
            end
        end

    when "3"    # TASK MANAGER
        puts "What would you like to do?"
            puts "(1) Create task"
            puts "(2) View tasks"
            puts "(3) Edit/Update tasks"
            puts "(4) Delete tasks"
    
        option = gets.chomp

        case option

        when "1"
            # main
            puts "Username:"
            logged_in_user = gets.chomp.capitalize

            create_csv

            puts "Would you like to assign this task to (a) yourself or (b) another user?"
            input = gets.chomp.downcase

            if input == "a"
                username = logged_in_user
                new_task = Task.new(:username => logged_in_user)

            elsif input == "b"
                puts "Who would you like to assign this task to?"
                username = gets.chomp.capitalize
                new_task = Task.new(:username => username)
            end

            add_task(logged_in_user, new_task)
            # def create_task
            #     puts "Task title:"
            #     task_title += gets.chomp
            #     puts "Task note:"
            #     user.task_note += gets.chomp
            #     task_tickbox = false

            #     tasks << [task_title, task_note, task_tickbox, username]
            #     check_task_list(tasks)

            #     CSV.open("tasks_to_do.csv", "a", headers: true) do |csv|
            #     csv << tasks
            # end

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
        
    when "4"    # PICK A PAL
        
    when "5"    # SETTINGS
        # case for music setting
        # case for alarm setting
        
    when "6"    # HELP
        # puts help manual here
        
    when "7"    # EXIT
        puts "See you next time."
        exit
    else
        puts
        puts "Please select a valid option: '1', '2', '3', '4', '5', '6' or '7'."
        puts
    end
    
end