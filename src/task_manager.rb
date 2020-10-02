require 'csv'

class Task
    attr_reader :user, :title, :note, :status
    def initialize(user, title, note, status)
        @user = user
        @title = title
        @note = note
        @status = status
    end
end


puts "What would you like to do?"
puts "(1) Create task"
puts "(2) View tasks"
puts "(3) Edit/Update tasks"
puts "(4) Delete tasks"

option = gets.chomp

# === Variables === #
task_list = []

# === Task methods === #
def task_card(details)
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
                input = gets.chomp
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
        return
    else 
        puts "Please select a valid answer: 'Y' or 'N'"
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
        end
        if task_list.empty? == true
            puts "Your task list is empty! :o"
            return
        end
    else
        puts "Your task list is empty! :o"
    end
end

def to_csv  # Writing back to csv
    CSV.open("tasks.csv", "w", headers: true) do |csv|
        csv << ["id", "title", "note", "user", "status"]
    end

    CSV.open("tasks.csv", "a", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: false) do |csv|
        remaining_rows.each do |array|
            csv << array
        end
    end
end

def confirm_selection(input)
    selected_row = CSV.read("tasks.csv")[input]
    puts "Is this the correct selection? (Y/N)"
    puts "Task: #{selected_row[1]} | Note: #{selected_row[2]} | Assigned to: #{selected_row[3]} | Status: #{selected_row[4]}"
end

# === MAIN === #

case option
when "1"    # ADDING NEW TASKS
    required_details = ["Title", "Note", "User"]

    if !File.exists?("tasks.csv")
        CSV.open("tasks.csv", "w", headers: true) do |csv|
                csv << ["Title", "Note", "Status", "User"]
        end
        task_card(required_details)
    else
        task_card(required_details)
    end

    #   VIEWING TASK LIST
    view_tasks(task_list)
    
when "2"    # VIEWING TASK LIST
    view_tasks(task_list)

when "3"    # UPDATING TASKS
    # if File.exists?("tasks.csv") && !task_list.empty? 
    p view_tasks(task_list)
    puts "What task would you like to edit?"
    input = gets.chomp.to_i
        # raise error if not integer
    
    confirm_selection(input)
    confirm = gets.chomp.strip.upcase
    if confirm == "Y"
        # Opening existing csv and selecting row
        selected_row = CSV.read("tasks.csv")[input]
        headers = CSV.read("tasks.csv")[0]
        remaining_rows = CSV.read("tasks.csv")
        
        # Editing selected row and headers
        remaining_rows.delete(selected_row) # Removing a row
        remaining_rows.delete(headers)    # Removing headers
        
        # Writing back to csv
        CSV.open("tasks.csv", "w", headers: true) do |csv|
            csv << ["id", "title", "note", "user", "status"]
        end
        
        CSV.open("tasks.csv", "a", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: false) do |csv|
            remaining_rows.each do |array|
                csv << array
            end
        end
        
        # Adding new task
        required_details = ["Title", "Note", "User"]
        task_card(required_details)
        view_tasks(task_list)
    elsif confirm == "N"
        return
    else
        puts "Please select a valid answer: 'Y' or 'N'"
    end

when "4"    # DELETING TASKS #
        p view_tasks(task_list)
        p task_list
        puts "What task would you like to delete?"
        input = gets.chomp.to_i
        

        confirm_selection(input)
        confirm = gets.chomp.strip
        # raise error if not integer
        option = gets.chomp.upcase
        case option
        when "Y"
            # Opening existing csv and selecting row
            selected_row = CSV.read("tasks.csv")[input]
            headers = CSV.read("tasks.csv")[0]
            remaining_rows = CSV.read("tasks.csv")

            # Deleting selected row and headers
            remaining_rows.delete(selected_row) # Removing a row
            remaining_rows.delete(headers)    # Removing headers
            view_tasks(task_list)
            
        when "N"
            return
        else
            puts "Please select an existing task number."
        end
else
    puts "Please select a valid option '1', '2', '3' or '4'"
end