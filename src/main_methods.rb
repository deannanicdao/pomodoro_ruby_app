require 'colorize'
require 'colorized_string'
require 'pastel'
require 'tty-prompt'
require 'tty-font'

def banner  # Pomodoro title
    $pastel = Pastel.new
    font = TTY::Font.new(:block)
    title = File.open("./ASCII_art/title_page.txt")
    puts ($pastel.yellow.bold(" ~ ") + $pastel.white.bold(" ~ ")) * 15
    puts title.read.colorize(:light_white)
    puts ($pastel.yellow.bold(" ~ ") + $pastel.white.bold(" ~ ")) * 15
end

def main_menu   #  Present welcome screen & main menu
    system('clear')
    $prompt = TTY::Prompt.new
    banner
    
    @choices = [
        {"Begin Pomodoro session" => -> do @option = 1 end}, 
        {"Set Timers" => -> do @option = 2 end}, 
        {"Set Tasks" => -> do @option = 3 end},
        {"Help" => -> do @option = 4 end},
        {"Exit" => -> do @option = 5 end}
    ]

    $prompt.select("Select an option: ", @choices)
    puts ($pastel.yellow.bold(" ~ ") + $pastel.white.bold(" ~ ")) * 15

end

# Farewell message
def farewell(message)
    system('clear')
    puts message
    @death.play
    sleep(1)
    system('clear')
    exit
end