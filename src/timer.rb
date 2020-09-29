require 'time'

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
        # p time_now
        sleep(1)
        tick += 1
        puts "#{tick}s"
        time_now = Time.now.strftime("%s").to_i
    end
end

def check_timer_list(timers)
    if timers.empty? == false
        puts "Here are your current timers:"
        timers.each_with_index {|timer, index| puts "#{index+1}. Work timer: #{timer[0]} min | Rest timer: #{timer[1]} min"}
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

