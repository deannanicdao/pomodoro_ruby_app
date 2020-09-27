require_relative './task_manager.rb'


puts "Welcome to PomodoroPalTM"
puts "What would you like to do first?"
    puts "(1) To-Do List"
    puts "(2) Set Timers"
    puts "(3) Pick a Pal"
    puts "(4) Settings"
    puts "(5) Help"

option = gets.chomp

if option == "1"

    CSV.open("tasks_to_do.csv", "w", headers: true) do |csv|
        csv << ["Title", "Note", "Tickbox"]
    end

    create_task

    puts "Add another task? (Y/N)"
    input2 == gets.chomp.capitalize
        # rescue here if input is not Y/N

        if input2 == "Y"
            create_task
        end
end