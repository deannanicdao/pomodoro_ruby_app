require 'tomate'
require 'rouge'

class Timer
    attr_accessor :work_timer, :rest_timer
    def initialize()
        @work_timer = work_timer
        @rest_timer = rest_timer
        choose_timer
    end

    def set_time
        puts "How many minutes would you like to add (we recommended 15/5 min work/rest session)?"
        set_time = (gets.to_f) * 60
        return set_time
    end

    def set_another_timer
        loop do
            puts "Would you like to (a) set another timer or (b) exit?"
            input = gets.chomp
                if input == "a"
                    choose_timer
                elsif input == "b"
                    display
                    exit
                else
                    puts "Invalid input. Please press 'a' or 'b"
                end
        end
    end

    def choose_timer
        loop do
            puts "Which timer would you like to set: 'work' or 'rest'?"
            input = gets.chomp
            if input == "work"
                @work_timer = set_time
                set_another_timer
            elsif input == "rest"
                @rest_timer = set_time
                set_another_timer
            else 
                puts "Invalid input. Please press 'a' or 'b"
            end  
        end
    end

    def countdown_work_timer
        time_now = Time.local 
        time_start = time_now
        end_time = work_timer + time_start
        while time_now < end_time
            if end_time == time_start
                puts "Great work, time to rest"
                #alarm_sound_work
                #switch_timer
            end
        end
    end

    def countdown_rest_timer
        time_now = Time.local 
        time_start = Time.now
        end_time = rest_timer + time_start
        while time_now < end_time
            if end_time == time_start
                puts "Back to work"
                #alarm_sound_rest
                #switch_timer
            end
        end
    end

    # def switch_timer
    #     if start_timer = work_timer
    #         end_timer = work_timer
    #         start_timer = rest_timer
    #     elsif start_timer = rest_timer
    #         end_timer = rest_timer
    #         start_timer = work_timer
    #     end
    # end

    def display
        # convert to minutes for both timers here
        puts "Timers:"
        puts "-------"
        puts "Work Timer: #{@work_timer}"
        puts "Rest Timer: #{@rest_timer}"
        return nil
    end

end

timer = Timer.new()


