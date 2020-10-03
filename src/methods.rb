require 'colorize'
require 'colorized_string'
require 'pastel'


def banner
    $pastel = Pastel.new
    font = TTY::Font.new(:block)
    title = File.open("./ASCII_art/title_page.txt")
    puts ($pastel.yellow.bold(" ~ ") + $pastel.white.bold(" ~ ")) * 15
    puts title.read.colorize(:light_white)
    puts ($pastel.yellow.bold(" ~ ") + $pastel.white.bold(" ~ ")) * 15
end