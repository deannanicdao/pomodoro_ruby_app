require 'pastel'
require 'tty-font'
require 'colorize'

pastel = Pastel.new
font = TTY::Font.new(:starwars)


title = File.open("./ASCII_art/title_page.txt")
puts title.read.colorize(:light_blue)

