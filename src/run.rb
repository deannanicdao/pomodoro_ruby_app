require_relative './task_manager.rb'

def countdown(timer)
    end_time = time_now + timer
    while time_now < end_time
        p time_now
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

    option = gets.chomp

    case option
        when "1"
            countdown(work_timer)
            puts "Your work timer is finished"
            puts "Starting rest timer"
            countdown(rest_timer)
            puts "Your session has ended"

            

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
                timers << work_timer, rest_timer

            when "2"
                puts "Here are your current timers"
                timers.each_with_index {|timer, index| puts "#{index+1}: #{timer}"}
                
            when "3"
                puts "Choose a timer to delete"
                timers.each_with_index {|timer, index| puts "#{index+1}: #{timer}"}

                input = gets.chomp
                if timers.include?(input)
                    timers.delete_at(input - 1)
                end
                
            end
        when "3"

        when "4"

        when "5"
            # case for music setting
            # case for alarm setting
        when "6"
            # puts help manual here
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