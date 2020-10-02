require_relative './task_manager.rb'
require_relative './timer.rb'
# require_relative './clock.rb'
require 'ruby2d'

# Background music #
# menu_song = Music.new('./Sounds/menu_music_pomodoro_pal.mp3')
# rest_song = Music.new('./Sounds/rest_music_pomodoro_pal.mp3')

# === Variables === #
task_list = []
timers  = []
message = "Farewell"
seconds = 3
# chosen_timer = nil

# === Main === #
def main_menu
    system('clear')
    puts " ~ " * 20
    puts " " * 15 + "Welcome to PomodoroPal™"
    puts " ~ " * 20  
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
    @option = gets.chomp
end

# logged_in_user = User.new(:username => username, :task_tickbox => false)

# CSV.open("tasks_to_do.csv", "w", headers: true) do |csv|
#     csv << [:username, :task_title, :task_note, :task_tickbox]
# end

system('clear')
main_menu
while @option != "7"

    if @option == "1"
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
                    wait
                end
            elsif timers.include?(timers.at(input_timer)) == false or input_timer != Integer
                puts "Invalid number. Please enter a number from the list."
                wait
            else
                puts "Invalid input. Please enter a number from the list."
                wait
            end
        end

    elsif @option == "2"
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
    elsif @option == "3"    # TASK MANAGER
        system('clear')
        puts "What would you like to do?"
        puts "(1) Create task"
        puts "(2) View tasks"
        puts "(3) Edit/Update tasks"
        puts "(4) Delete tasks"
        option = gets.chomp

        case option
        when "1"    # ADDING NEW TASKS
            required_details = ["Title", "Note", "User"]
        
            if !File.exists?("tasks.csv")
                CSV.open("tasks.csv", "w", headers: true) do |csv|
                        csv << ["Title", "Note", "Status", "User"]
                end
                task_card(required_details)
            else
                task_card(required_details)
            end
        
            #   VIEWING TASK LIST
            view_tasks(task_list)
            
        when "2"    # VIEWING TASK LIST
            view_tasks(task_list)
        
        when "3"    # UPDATING TASKS
            # if File.exists?("tasks.csv") && !task_list.empty? 
            view_tasks(task_list)
            puts "What task would you like to edit?"
            input = gets.chomp.to_i
                # raise error if not integer
            
            confirm_selection(input)
            confirm = gets.chomp.strip.upcase
            if confirm == "Y"
                # Opening existing csv and selecting row
                selected_row = CSV.read("tasks.csv")[input]
                headers = CSV.read("tasks.csv")[0]
                remaining_rows = CSV.read("tasks.csv")
                
                # Editing selected row and headers
                remaining_rows.delete(selected_row) # Removing a row
                remaining_rows.delete(headers)    # Removing headers
                
                # Writing back to csv
                CSV.open("tasks.csv", "w", headers: true) do |csv|
                    csv << ["id", "title", "note", "user", "status"]
                end
                
                CSV.open("tasks.csv", "a", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: false) do |csv|
                    remaining_rows.each do |array|
                        csv << array
                    end
                end
                
                # Adding new task
                required_details = ["Title", "Note", "User"]
                task_card(required_details)
                view_tasks(task_list)
            elsif confirm == "N"
                return
            else
                puts "Please select a valid answer: 'Y' or 'N'"
            end
        
        when "4"    # DELETING TASKS #
                p view_tasks(task_list)
                p task_list
                puts "What task would you like to delete?"
                input = gets.chomp.to_i
                
        
                confirm_selection(input)
                confirm = gets.chomp.strip
                # raise error if not integer
                option = gets.chomp.upcase
                case option
                when "Y"
                    # Opening existing csv and selecting row
                    selected_row = CSV.read("tasks.csv")[input]
                    headers = CSV.read("tasks.csv")[0]
                    remaining_rows = CSV.read("tasks.csv")
        
                    # Deleting selected row and headers
                    remaining_rows.delete(selected_row) # Removing a row
                    remaining_rows.delete(headers)    # Removing headers
                    view_tasks(task_list)
                    
                when "N"
                    return
                else
                    puts "Please select an existing task number."
                end
        else
            puts "Please select a valid option '1', '2', '3' or '4'"
        end
        
    elsif @option == "4"    # PICK A PAL
    elsif @option == "5"    # SETTINGS
        # case for music setting
        # case for alarm setting
        
    elsif @option == "6"    # HELP
        # puts help manual here
    end

    main_menu
end

system('clear')
puts "#{message.to_s}!"
@death.play
sleep(1)
system('clear')
exit
