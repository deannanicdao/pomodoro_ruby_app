require_relative './task_manager.rb'
require_relative './timer.rb'

timers  = []
chosen_timer = []

loop do
    puts "Welcome to PomodoroPalTM"
    puts "What would you like to do first?"
        puts "(1) Begin Pomodoro session"
        puts "(2) Set Timers"
        puts "(3) To-Do List"
        puts "(4) Pick a Pal"
        puts "(5) Settings"
        puts "(6) Help"
        puts "(7) Exit"

    option = gets.chomp

    case option
    when "1"
        puts "Which timer would you like to use?"
        timers.each_with_index {|timer, index| puts "#{index+1}. Work timer: #{timer[0]} min | Rest timer: #{timer[1]} min"}
        input_timer = gets.chomp.to_i - 1
        if timers.include?(timers.at(input_timer)) == true
            chosen_timer << timers.at(input_timer)
            puts "Your timer settings are:"
            puts "Work timer: #{chosen_timer[0][0]}"
            puts "Rest timer: #{chosen_timer[0][1]}"
            puts "Ready to begin?"
            input = gets.chomp.upcase
            if input == "Y"
                countdown(chosen_timer[0][0])
                puts "Your work timer is finished."
                puts "Starting rest timer:"

                countdown(chosen_timer[0][1])
                puts "Your session has ended"
                puts "Would you like to:"
                puts "(a) return to menu"
                puts "(b) exit"

                if input == "a"
                    chosen_timer = []
                    next
                elsif input == "b"
                    chosen_timer = []
                    exit
                else
                    puts "Please select a valid option: 'a' or 'b'"
                end
            elsif input == "N"
                chosen_timer = []
                next
            else
                puts "Please select 'Y' or 'N'"
            end
        elsif timers.include?(timers.at(input_timer)) == false
            puts "Invalid number. Please enter a number from the list."
            redo
        else
            puts "Invalid input. Please enter a number from the list."
        end
    when "2"
        puts "What would you like to do?"
        puts "(1) Create timers"
        puts "(2) View timers"
        puts "(3) Delete timers"
        
        option = gets.chomp

        case option

        when "1"
            puts "Work timer:"
            work_timer = gets.chomp.to_i * 60
            puts "Rest timer:"
            rest_timer = gets.chomp.to_i * 60
            timers << [work_timer, rest_timer]
            puts timers
            next  
        when "2"
            if timers.empty? == false
                puts "Here are your current timers:"
                timers.each_with_index {|timer, index| puts "#{index+1}. Work timer: #{timer[0]} min | Rest timer: #{timer[1]} min"}
                next
            else timers.empty? == true
                puts "You haven't set any timers yet."
                next
            end
        when "3"
            puts "Choose a timer to delete"
            timers.each_with_index {|timer, index| puts "#{index+1}. Work timer: #{timer[0]} min | Rest timer: #{timer[1]} min"}
            input = gets.chomp.to_i - 1

            puts "Would you like to delete this timer? (Y/N)"
            puts "Work timer: #{timers[input][0]}min | Rest timer: #{timers[input][1]}min"
            answer = gets.chomp.upcase

            if answer == "Y"
                timers.delete_at(input)
            elsif answer == "N"
                next
            elsif timers.empty? == true
                puts "You haven't set any timers yet."
                next
            else
                puts "Please enter a valid timer to delete."            # TEST THIS CONDITION TOMORROW
                next
            end
        end

    when "3"

        next
    when "4"
        next
    when "5"
        # case for music setting
        # case for alarm setting
        next
    when "6"
        # puts help manual here
        next
    when "7"
        puts "See you next time."
        exit
    else
        puts
        puts "Please select a valid option: '1', '2', '3', '4', '5', '6' or '7'."
        puts
    end
end

# if option == "1"

#     CSV.open("tasks_to_do.csv", "w", headers: true) do |csv|
#         csv << ["Title", "Note", "Tickbox"]
#     end

#     create_task

#     puts "Add another task? (Y/N)"
#     input2 == gets.chomp.capitalize
#         # rescue here if input is not Y/N

#         if input2 == "Y"
#             create_task
#         end

#     end