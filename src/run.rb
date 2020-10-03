require_relative './task_manager.rb'
require_relative './timer.rb'
require_relative './methods.rb'
require 'ruby2d'
require 'tty-font'
require 'pastel'
require 'colorize'
require 'colorized_string'
require 'tty-prompt'

# Background music #
@menu_song = Sound.new('./Sounds/menu_music_pomodoro_pal.mp3')
rest_song = Music.new('./Sounds/rest_music_pomodoro_pal.mp3')


# === Main === #
def main
    # === Variables === #
    task_list = []
    timers  = []
    message = "Farewell"
    seconds = 3
    
    def main_menu   #   Present welcome screen & main menu
        system('clear')
        $prompt = TTY::Prompt.new
        # @menu_song.play
        banner
        @choices = [
            {"Begin Pomodoro session" => -> do @option = 1 end}, 
            {"Set Timers" => -> do @option = 2 end}, 
            {"Set Tasks" => -> do @option = 3 end},
            {"Pick a Pal" => -> do @option = 4 end},
            {"Settings" => -> do @option = 5 end},
            {"Help" => -> do @option = 6 end},
            {"Exit" => -> do @option = 7 end}
        ]
        $prompt.select("Select an option: ", @choices)
        puts ($pastel.yellow.bold(" ~ ") + $pastel.white.bold(" ~ ")) * 15
    end

    # logged_in_user = User.new(:username => username, :task_tickbox => false)

    # CSV.open("tasks_to_do.csv", "w", headers: true) do |csv|
    #     csv << [:username, :task_title, :task_note, :task_tickbox]
    # end


    system('clear')
    main_menu
    while @option != 7

        case @option
        when 1
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

        when 2  # TIMERS CRUD
            choices = [
            {"Create timers" => -> do @timer_option = 1 end}, 
            {"View timers" => -> do @timer_option = 2 end}, 
            {"Delete timers" => -> do @timer_option = 3 end}
            ]
            
            $prompt.select("Select an option: ", choices)
            puts ($pastel.yellow.bold(" ~ ") + $pastel.white.bold(" ~ ")) * 15
            
            case @timer_option
            when 1  # Create timers
                puts "Work timer (min):"
                work_timer = gets.chomp.to_f * 60
                #   raise error when work_timer != Integer or < 0
                puts "Rest timer (min):"
                rest_timer = gets.chomp.to_f * 60
                #   raise error when work_timer != Integer or < 0
                timers << [work_timer, rest_timer]
                check_timer_list(timers)

            when 2  # View timers
                check_timer_list(timers)
                
            when 3 # View then delete a selected timer
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
                        pause("Changed your mind? Ok, returning to menu...")
                    else
                        puts "Please enter a valid timer to delete."            # TEST THIS CONDITION TOMORROW
                    end
                end
            end
        when 3  # TASK MANAGER CRUD
            choices = [
            {"Create a task" => -> do @task_option = 1 end}, 
            {"View tasks" => -> do @task_option = 2 end}, 
            {"Change a task" => -> do @task_option = 3 end},
            {"Delete tasks" => -> do @task_option = 4 end},
            {"Tick off a task" => -> do @task_option = 5 end}
            ]
            $prompt.select("Select an option: ", choices)
            puts ($pastel.yellow.bold(" ~ ") + $pastel.white.bold(" ~ ")) * 15

            case @task_option
            when 1    # ADDING NEW TASKS
                required_details = ["Title", "Note", "User"]
            
                if !File.exists?("tasks.csv")
                    CSV.open("tasks.csv", "w", headers: true) do |csv|
                            csv << ["Title", "Note", "Status", "User"]
                    end
                    task_card(required_details)
                else
                    task_card(required_details)
                end
                
            when 2    # VIEWING TASK LIST
                view_tasks(task_list)
            
            when 3    # CHANGING TASKS
                # if File.exists?("tasks.csv") && !task_list.empty? 
                view_tasks(task_list)
                puts "What task would you like to edit?"
                input = gets.chomp.to_i
                    # raise error if not integer
                system('clear')
                banner
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
                    pause("Changed your mind? Ok, returning to menu...")
                else
                    puts "Please select a valid answer: 'Y' or 'N'"
                end
            
            when 4    # DELETING TASKS #
                view_tasks(task_list)
                puts "What task would you like to delete?"
                input = gets.chomp.to_i
                    # raise error if not integer
                
                confirm_selection(input)
                confirm = gets.chomp.strip.upcase
                system('clear')
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
                end
            
            
            when 5    # TICK OFF TASK #
                tick_task
                view_tasks(task_list)
            else
                puts "Please select a valid option '1', '2', '3' or '4' or '5'"
            end
            
        when 4  # PICK A PAL
        when 5  # SETTINGS
            # case for music setting
            # case for alarm setting
            
        when 6  # HELP
            help = File.open("help.txt")
            puts help.read
            pause("Ain't much to it, aye. Press enter to return to menu so we can begin.")
        end

        main_menu
    end

    system('clear')
    puts "#{message.to_s}!"
    @death.play
    sleep(1)
    system('clear')
    exit
end

#   Start Pomodoro Pal
main
