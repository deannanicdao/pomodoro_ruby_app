require 'tty-prompt'

prompt = TTY::Prompt.new

list = prompt.ask("Ingredients? (comma sep list)") do |q|
    q.modify :int
end

list_b = prompt.ask("Ingredients? (comma sep list)") do |q|
    q.convert -> (input) { input.split(/,\s*/) }
end

p list.to_i * 10
p list_b