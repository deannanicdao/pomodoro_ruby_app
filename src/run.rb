require_relative './task_manager.rb'

def countdown(timer)
    time_now = Time.now.strftime("%s").to_i
    end_time = time_now + timer
    while time_now < end_time
        # p time_now
        time_now = Time.now.strftime("%s").to_i
    end
end

timers  = []

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
        puts "Your timer settings are:"
        puts "Work timer: #{timers[0][0]}"
        puts "Rest timer: #{timers[0][1]}"
        puts "Ready to begin?"
        input = gets.chomp.upcase
        if input == "Y"
            countdown(timers[0][0])
            puts "Your work timer is finished."
            puts "Starting rest timer:"

            countdown(timers[0][1])
            puts "Your session has ended"
            puts "Would you like to:"
            puts "(a) return to menu"
            puts "(b) exit"

            if input == "a"
                next
            elsif input == "b"
                exit
            else
                puts "Please select a valid option: 'a' or 'b'"
            end
        elsif input == "N"
            next
        else input
            puts "Please select 'Y' or 'N'"
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
            work_timer = gets.chomp.to_i * 2
            puts "Rest timer:"
            rest_timer = gets.chomp.to_i * 2
            timers << [work_timer, rest_timer]
            puts timers
            next  
        when "2"
            puts "Here are your current timers"
            timers.each_with_index {|timer, index| puts "#{index+1}: #{timer}"}
            next
        when "3"
            puts "Choose a timer to delete"
            timers.each_with_index {|timer, index| puts "#{index+1}: #{timer}"}

            input = gets.chomp
            if timers.include?(input)
                timers.delete_at(input - 1)
            end
            next    
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
        puts "Please select a valid option: '1', '2', '3', '4', '5' or '6'."
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