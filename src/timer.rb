require 'time'
require 'pastel'
require 'tty-progressbar'
require 'ruby2d'

# Sounds for timers #
@death = Sound.new('./Sounds/death_pomodoro_pal.wav')
@alert = Sound.new('./Sounds/tamagotchi-alert.wav')
@option_select = Sound.new('./Sounds/menu_select_pomodoro_pal.mp3')
@feed = Sound.new('./Sounds/feed_pomodoro.wav')

# class Timer
#     attr_accessor :work_timer, :rest_timer
#     def initialize(work, rest)
#     end
# end

def countdown(timer)
    time_now = Time.now.strftime("%s").to_i
    end_time = time_now + timer
    seconds = end_time.to_i - time_now.to_i
    while time_now < end_time
        system('clear')
        # puts "Session #{session} / #{session_total}"
        puts "#{seconds} seconds remaining"
        puts " "
        puts "Current time: " + Time.new.getlocal.strftime("%H:%M:%S")
        puts " "
        puts "Today is " + Time.new.getlocal.strftime("%A | %d-%m-%Y")
        sleep(1)
        seconds -= 1
        # sleep(1)
        # tick += 1
        # puts "#{tick}s"
        system('clear')
        # pastel = Pastel.new
        # complete_bar = pastel.on_cyan(" ")
        # progress_bar = pastel.on_white(" ")
        # system('clear')

        # bar = TTY::ProgressBar.new("Progress :bar", 
        #     total: end_time,
        #     complete: complete_bar,
        #     incomplete: progress_bar
        # )

        # end_time do
        #     sleep(end_time / 60)
        #     bar.advance(1)
        # end

    end
    @alert.play
end

def loading(seconds)
    total_seconds = seconds + 1 # to reach zero
    total_seconds.times do
        system('clear')
        # puts "Session #{@session} / #{@session_total}"
        puts "#{seconds}"
        sleep(1)
        seconds -= 1
    end
    @alert.play
end

def check_timer_list(timers)
    system('clear')
    if timers.empty? == false
        puts "Here are your current timers:"
        timers.each_with_index {|timer, index| puts "#{index+1}. Work timer: #{timer[0].to_f / 60 } min | Rest timer: #{timer[1].to_f / 60} min"}
    else timers.empty? == true
        puts " "
        puts "You haven't set any timers yet."
        puts "Go create one under (2) Set Timers."
        puts " "
        wait
    end
end

# ---- notes ----
# %M = shows the minute of the hour
# %S = shows the second of the minute
# %T = time of 24h (%H:%M:%S)
# Time.now.strftime "%M:%S"

