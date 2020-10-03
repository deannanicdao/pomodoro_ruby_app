# gem for spinning animation
def show_spinner()
    spinner = TTY::Spinner.new("[:spinner] ...Adding")
        spinner.auto_spin
            sleep(1)
                spinner.success('(successful)')
end

def show_spinner2()
    spinner = TTY::Spinner.new("[:spinner] Checking the stocks. Please Wait ...", format: :bouncing_ball)
        spinner.auto_spin 
        sleep(1) 
        spinner.stop('Done!')

end

def pause()
    prompt = TTY::Prompt.new
    prompt.keypress(" Press space or enter to continue ", keys: [:space, :return])
                    system("clear")

end

