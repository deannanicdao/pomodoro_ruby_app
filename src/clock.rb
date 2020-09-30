require 'ruby2d'

set title: "Hello world", background: 'blue', width: 640, height: 480, resizeable: true, borderless: false
song = Sound.new('./rest_music_pomodoro_pal.mp3')
song.play

# song.loop = true
# song.volume = 20

s = Square.new(x: 10, y:20, size: 25, color: 'white')
t = Triangle.new(x: 10, y:20, size: 25, color: 'white')
s.add
t.add
Circle.new(
    x: 200, y: 175,
    radius: 150,
    sectors: 32,
    color: 'fuchsia',
    z: 10
)

show

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