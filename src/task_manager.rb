require 'csv'
require 'ruby2d'

class Task
    attr_reader :user, :title, :note, :status
    def initialize(user, title, note, status)
        @user = user
        @title = title
        @note = note
        @status = status
    end
end

# === Task methods === #
def task_card(details)
    system('clear')
    banner
    puts "Add a task? (Y/N)"
    task = []
    answer = gets.chomp.upcase

    case answer
    when "Y"
        until answer == "N" do
            current = CSV.read("tasks.csv")
            id = current.length
            task << id
            details.each do |column|
                puts "#{column}:"
                input = gets.chomp.strip
                until input.empty? == false
                    puts "You haven't entered anything. Please enter a valid #{column.downcase}."
                    input = gets.chomp.strip
                    system('clear')
                end
                task << input
            end

            task << "incomplete"
            CSV.open("tasks.csv", "a", headers: true) do |csv|
                csv << task
            end
        puts "Add a task? (Y/N)"
        task = []
        answer = gets.chomp.upcase
        end
    when "N"
        pause("Changed your mind? Ok, returning to menu...")
             
    else
        "Please select a valid answer: 'Y' or 'N'"
    end
end

def view_tasks(task_list)
    if File.exists?("tasks.csv")
        task_list = []
        index = 0
        CSV.foreach("tasks.csv", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: true) do |row|
            task_list << Task.new(row[:user], row[:title], row[:note], row[:status])
        end

        if !task_list.empty? == true
            puts "Your current task list:"
            task_list.each do |task|
                index += 1
                puts "#{index}. User: #{task.user.upcase} | #{task.title.upcase}: #{task.note} | Status: #{task.status.upcase}"
            end
        else task_list.empty? == true
            puts "Your task list is empty! :o"
            pause("Press enter to return to menu")
        end

    else
        puts "Your task list is empty! :o"
        pause("Press enter to return to menu")
    end
end



def confirm_selection(input)
    system('clear')
    banner
    selected_row = CSV.read("tasks.csv")[input]
    puts "Is this the correct selection? (Y/N)"
    puts " "
    puts "Task: #{selected_row[1].capitalize} | Note: #{selected_row[2].capitalize} | Assigned to: #{selected_row[3].upcase} | Status: #{selected_row[4].upcase}"
end

def pause(message)
    puts message
    if gets
        system('clear')
    end
end

def tick_task
    view_tasks(@task_list)
    puts "Select task number:"
    input = gets.chomp.to_i
    selected_row = CSV.read("tasks.csv")[input]
    confirm_selection(input)
    confirm = gets.chomp.strip.upcase
    case confirm
    when "Y"
        input = input - 1
        table = CSV.parse(File.read("tasks.csv"), headers: true)
        table[input][4]
        puts "Change status to:"
        puts "Complete: 'x' | Incomplete: '-'"
        status = gets.chomp.downcase.strip
        if status == "x"
            status = "complete"
            table[input][4] = status
            table.by_row![input][4]
            table[input]
        elsif status == "-"
            status = "incomplete"
            table[input][4] = status
            table.by_row![input][4]
            table[input]
        else
            pause("Incorrect key pressed. Should be option 'x' or '-'. Returning to menu...")
        end

        # Writing back to csv
        CSV.open("tasks.csv", "w", headers: true) do |csv|
            csv << ["id", "title", "note", "user", "status"]
        end

        CSV.open("tasks.csv", "a", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: false) do |csv|
            table.each do |row|
                csv << row
            end
        end
    when "N"
        pause("Changed your mind? Ok, returning to menu...")
    else
        puts "Please select a valid option: 'Y' or 'N'"
    end
end