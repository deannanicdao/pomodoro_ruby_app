require 'time'

class Timer
    attr_accessor :work_timer, :rest_timer
    def initialize(work, rest)
    end
end

def countdown(timer)
    time_now = Time.now.strftime("%s").to_i
    end_time = time_now + timer
    while time_now < end_time
        # p time_now
        time_now = Time.now.strftime("%s").to_i
    end
end

# ---- notes ----
# %M = shows the minute of the hour
# %S = shows the second of the minute
# %T = time of 24h (%H:%M:%S)
# Time.now.strftime "%M:%S"

