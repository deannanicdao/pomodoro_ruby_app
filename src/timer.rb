require 'time'
require 'pastel'
require 'ruby2d'

# Sounds for timers #
@death = Sound.new('./Sounds/death_pomodoro_pal.wav')
@alert = Sound.new('./Sounds/tamagotchi-alert.wav')

def countdown(timer)
    time_now = Time.now.strftime("%s").to_i
    end_time = time_now + timer
    seconds = end_time.to_i - time_now.to_i
    while time_now < end_time
        system('clear')
        puts Time.at(seconds).utc.strftime("Time remaining: %M:%S")
        #  put #{seconds} seconds remaining"
        puts " "
        puts "Current time: " + Time.new.getlocal.strftime("%H:%M:%S")
        puts " "
        puts "Today is " + Time.new.getlocal.strftime("%A | %d-%m-%Y")
        sleep(1)
        seconds -= 1
        time_now = Time.now.strftime("%s").to_i
        system('clear')
    end
    @alert.play
end

def loading(seconds)
    total_seconds = seconds + 1 # to reach zero
    total_seconds.times do
        system('clear')
        puts "#{seconds}"
        sleep(1)
        seconds -= 1
    end
    @alert.play
end

def check_timer_list(timers)
    system('clear')
    if timers.empty? == false
        banner
        puts "Here are your current timers:"
        timers.each_with_index {|timer, index| puts "#{index+1}. Work timer: #{timer[0].to_f / 60 } min | Rest timer: #{timer[1].to_f / 60} min"}
    else timers.empty? == true
        banner
        puts " "
        puts "You haven't set any timers yet."
        puts "Go create one under (2) Set Timers."
        puts " "
        pause("Press enter to return to menu...")
    end
end