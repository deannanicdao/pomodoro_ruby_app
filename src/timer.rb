require 'time'
require 'pastel'
require 'tty-progressbar'
require 'ruby2d'





# class Music(source)
# end

class Timer
    attr_accessor :work_timer, :rest_timer
    def initialize(work, rest)
    end
end

def countdown(timer)
    time_now = Time.now.strftime("%s").to_i
    end_time = time_now + timer
    tick = 0
    while time_now < end_time
        sleep(1)
        tick += 1
        puts "#{tick}s"

        time_now = Time.now.strftime("%s").to_i
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
    alert.play
end

def three_two_one
    sleep(1)
    system('clear')
    puts "3"
    sleep(1)
    system('clear')
    puts "2"
    sleep(1)
    system('clear')
    puts "1"
    sleep(1)
    system('clear')
    puts "0"
    sleep(1)
    alert.play
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
        sleep(2)
    end
end



# ---- notes ----
# %M = shows the minute of the hour
# %S = shows the second of the minute
# %T = time of 24h (%H:%M:%S)
# Time.now.strftime "%M:%S"

