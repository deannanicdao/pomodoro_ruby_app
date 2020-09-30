require 'ruby2d'
require 'tty-progressbar'
require 'pastel'
timer_length = 10 # min
pastel = Pastel.new
green = pastel.on_green(" ")
red = pastel.on_red(" ")
system('clear')
bar = TTY::ProgressBar.new("Progress [:bar]", 
    total: timer_length,
    complete: green,
    incomplete: red
)

timer_length.times do
  sleep(1)
  bar.advance(1)
end

# alert.volume = 100

# test_song.volume = 80

# song.loop = true
# song.volume = 20

# s = Square.new(x: 10, y:20, size: 25, color: 'white')
# t = Triangle.new(x: 10, y:20, size: 25, color: 'white')
# s.add
# t.add
# Circle.new(
#     x: 200, y: 175,
#     radius: 150,
#     sectors: 32,
#     color: 'fuchsia',
#     z: 10
# )



# puts "music should be playing"
# if input == exit
#   close
# end

# require 'ruby2d'

# set title: "Hello Triangle"

# Triangle.new(
#   x1: 320, y1:  50,
#   x2: 540, y2: 430,
#   x3: 100, y3: 430,
#   color: ['red', 'green', 'blue']
# )

# show