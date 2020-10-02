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

# === Task methods === #
case option
when "1"    # ADDING NEW TASKS
    required_details = ["Title", "Note", "User"]

    def task_card(details)
        loop do
            task = []
            puts "Add a task? (Y/N)"
            answer = gets.chomp.upcase
            if answer == "Y"
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
            else answer == "N" 
                return
            end
        end
    end

    if !File.exists?("tasks.csv")
        CSV.open("tasks.csv", "w", headers: true) do |csv|
                csv << ["Title", "Note", "Status", "User"]
        end
        task_card(required_details)
    else
        task_card(required_details)
    end

    #   VIEWING TASK LIST
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
    
when "2"    # VIEWING TASK LIST
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

when "3"    # UPDATING TASKS
    if File.exists?("tasks.csv") && ![].empty? 
        # VIEWING TASK
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
        puts "Your task list is empty! :o"
        # END VIEWING TASK

        puts "What task would you like to edit?"
        input = gets.chomp.to_i
            # raise error if not integer

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
        # remaining_rows.task_card(required_details)  

        # VIEWING TASK
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
        puts "Your task list is empty! :o"
        # END VIEWING TASK
    else
        puts "Your task list is empty! :o"
    end
    
when "4"    # DELETING TASKS #
    if File.exists?("tasks.csv")
        # VIEWING TASK
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
        # END VIEWING TASK

        puts "What task would you like to delete?"
        input = gets.chomp.to_i
            # raise error if not integer

        # Opening existing csv and selecting row
        selected_row = CSV.read("tasks.csv")[input]
        headers = CSV.read("tasks.csv")[0]
        remaining_rows = CSV.read("tasks.csv")
        
        # Deleting selected row and headers
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

        # VIEWING TASK
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
        # END VIEWING TASK

    else
        puts "Your task list is empty! :o"
    end
else
    puts "Please select a valid option '1', '2', '3' or '4'"
end