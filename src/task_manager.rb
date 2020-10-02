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
                current = CSV.read("test.csv")
                id = current.length
                task << id
                details.each do |column|
                    puts "#{column}:"
                    input = gets.chomp
                    task << input
                end
                task << "incomplete"
                CSV.open("test.csv", "a", headers: true) do |csv|
                    csv << task
                end
            else answer == "N" 
                return
            end
        end
    end

    if !File.exists?("test.csv")
        CSV.open("tasks.csv", "w", headers: true) do |csv|
                csv << ["Title", "Note", "Status", "User"]
        end
        task_card(required_details)
    else
        task_card(required_details)
    end

when "2"    # VIEWING TASK LIST
    if File.exists?("test.csv")
        task_list = []
        index = 0
        CSV.foreach("test.csv", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: true) do |row|
            task_list << Task.new(row[:user], row[:title], row[:note], row[:status])
        end
        task_list.each do |task|
            index += 1
            puts "#{index}. User: #{task.user.upcase} | #{task.title.upcase}: #{task.note} | Status: #{task.status.upcase}"
        end
    else
        puts "No tasks yet."
    end

when "3"    # UPDATING TASKS
    if File.exists?("test.csv")
        # VIEWING TASK
        task_list = []
        index = 0
        CSV.foreach("test.csv", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: true) do |row|
            task_list << Task.new(row[:user], row[:title], row[:note], row[:status])
        end
        task_list.each do |task|
            index += 1
            puts "#{index}. User: #{task.user.upcase} | #{task.title.upcase}: #{task.note} | Status: #{task.status.upcase}"
        end
        # END VIEWING TASK

        puts "What task would you like to edit?"
        input = gets.chomp.to_i
            # raise error if not integer

        # Opening existing csv and selecting row
        selected_row = CSV.read("test.csv")[input]
        headers = CSV.read("test.csv")[0]
        remaining_rows = CSV.read("test.csv")
        
        # Deleting selected row and headers
        remaining_rows.delete(selected_row) # Removing a row
        remaining_rows.delete(headers)    # Removing headers
        
        # Writing back to csv
        CSV.open("test.csv", "w", headers: true) do |csv|
            csv << ["id", "title", "note", "user", "status"]
        end
        
        CSV.open("test.csv", "a", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: false) do |csv|
            remaining_rows.each do |array|
                csv << array
            end
        end

        # VIEWING TASK
        task_list = []
        index = 0
        CSV.foreach("test.csv", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: true) do |row|
            task_list << Task.new(row[:user], row[:title], row[:note], row[:status])
        end
        task_list.each do |task|
            index += 1
            puts "#{index}. User: #{task.user.upcase} | #{task.title.upcase}: #{task.note} | Status: #{task.status.upcase}"
        end
        # END VIEWING TASK
    else
        puts "No tasks yet."
    end
    
when "4"    # DELETING TASKS #
    if File.exists?("test.csv")
        # VIEWING TASK
        task_list = []
        index = 0
        CSV.foreach("test.csv", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: true) do |row|
            task_list << Task.new(row[:user], row[:title], row[:note], row[:status])
        end
        task_list.each do |task|
            index += 1
            puts "#{index}. User: #{task.user.upcase} | #{task.title.upcase}: #{task.note} | Status: #{task.status.upcase}"
        end
        # END VIEWING TASK

        puts "What task would you like to delete?"
        input = gets.chomp.to_i
            # raise error if not integer

        # Opening existing csv and selecting row
        selected_row = CSV.read("test.csv")[input]
        headers = CSV.read("test.csv")[0]
        remaining_rows = CSV.read("test.csv")
        
        # Deleting selected row and headers
        remaining_rows.delete(selected_row) # Removing a row
        remaining_rows.delete(headers)    # Removing headers
        
        # Writing back to csv
        CSV.open("test.csv", "w", headers: true) do |csv|
            csv << ["id", "title", "note", "user", "status"]
        end
        
        CSV.open("test.csv", "a", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: false) do |csv|
            remaining_rows.each do |array|
                csv << array
            end
        end

        # VIEWING TASK
        task_list = []
        index = 0
        CSV.foreach("test.csv", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: true) do |row|
            task_list << Task.new(row[:user], row[:title], row[:note], row[:status])
        end
        task_list.each do |task|
            index += 1
            puts "#{index}. User: #{task.user.upcase} | #{task.title.upcase}: #{task.note} | Status: #{task.status.upcase}"
        end
        # END VIEWING TASK

    else
        puts "No tasks yet."
    end
else
    puts "Please select a valid option '1', '2', '3' or '4'"
end