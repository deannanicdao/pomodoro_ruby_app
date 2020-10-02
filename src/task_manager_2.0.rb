# ADDING NEW TASKS

required_details = ["User", "Title", "Note"]

require 'csv'

def task_card(details)
    loop do
        task = []
        puts "Add a task? (Y/N)"
        answer = gets.chomp.upcase
        if answer == "Y"
            details.each do |column|
                puts "#{column}:"
                input = gets.chomp
                task << input
            end
            task << "In progress"
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
            csv << ["User", "Title", "Note", "Status"]
    end
        task_card(required_details)
        
else
        task_card(required_details)
end

# VIEWING TASK LIST

class Task
    attr_reader :user, :title, :note, :status
    def initialize(user, title, note, status)
        @user = user
        @title = title
        @note = note
        @status = status
    end
end

if File.exists?("tasks.csv")
    task_list = []
    index = 0
    CSV.foreach("tasks.csv", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: true) do |row|
        task_list << Task.new(row[:user], row[:title], row[:note], row[:status])
    end
    task_list.each do |task|
        index += 1
        puts "#{index}. User: #{task.user} | #{task.title}: #{task.note} | Status: #{task.status}"
    end

    # File.open("tasks.csv", "r") do |line|
    #     puts line.readlines()[2]
    # end

    # File.open("tasks.csv", "w") do |line|
    #     puts line.readlines()[2]
    # end

else
    puts "No tasks yet."
end


# UPDATING TASKS
if File.exists?("tasks.csv")
    task_list = []
    index = 0

    # CSV.foreach("tasks.csv", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: true) do |row|
    #     task_list << Task.new(row[:user], row[:title], row[:note], row[:status])
    # end

    # task_list.each do |task|
    #     index += 1
    #     puts "#{index}. User: #{task.user} | #{task.title}: #{task.note} | Status: #{task.status}"
    # end

    @table = CSV.parse(File.read("tasks.csv"), headers: true)
    
    @table.by_row[0]
    
    
    puts "Which task would you like to edit?"
    input = gets.chomp.to_i - 1
    p @table.by_row[input]

    table.delete(input)
    p @table.by_row[0]
    new_csv = @table.to_csv
    def <<(row_or_array)
        if row_or_array.is_a? Array  # append Array
          @table << Row.new(headers, row_or_array)
        else                         # append Row
          @table << row_or_array
        end
      
        self # for chaining
    end

    CSV.open("tasks.csv", "w", headers: true) do |csv|
        csv <<(new_csv)
    end


    # if table.include?(values_at(input)) == true
    #     chosen_task = values_at(input)
    #     puts "Would you like to edit this task? (Y/N)"
    #             puts "Task: #{table[input].title} | Note: #{table[input].note}"
    #             answer = gets.chomp.upcase

    #             if answer == "Y"
    #                 table.delete(input)
    #                 puts "Task: #{task_list[input].title} | Note: #{task_list[input].note}"
                    
    #                 CSV.open("tasks.csv", "w", headers: true) do |csv|
    #                     csv << ["User", "Title", "Note", "Status"]
    #                 end
    #                 task_card(required_details)
                              
    #                 # required_details.each do |column|
    #                 #     puts "#{column}:"
    #                 #     input = gets.chomp
    #                 #     task << input
    #                 # end
    #                 # task << "In progress"
    #                 # CSV.open("tasks.csv", "a", headers: true) do |csv|
    #                 #     csv << task
    #                 # end
    #             elsif answer == "N"
    #             else
    #                 puts "Please enter a valid timer to delete."            # TEST THIS CONDITION TOMORROW
    #             end
    # end

    # File.open("tasks.csv", "r") do |line|
    #     puts line.readlines()[2]
    # end

    # File.open("tasks.csv", "w") do |line|
    #     puts line.readlines()[2]
    # end

else
    puts "No tasks yet."
end

# DELETING ROWS #

puts "---- row being removed ----"

p remaining_rows.delete(selected_row)

puts "---- rows remaining ----"
p remaining_rows

puts "---- headers being removed ----"

p remaining_rows.delete(headers)

puts "---- rows remaining ----"
p remaining_rows

puts "---- format of each row before back to csv ----"
remaining_rows.each do |array|
    p array
end


puts "---- back to csv ----"

CSV.open("test_2.csv", "w", headers: true) do |csv|
        csv << ["Index", " Year", " Age", " Name", " Movie"]
end
CSV.open("test_2.csv", "a", col_sep: ",", headers: true, header_converters: :symbol, skip_blanks: false) do |csv|
        remaining_rows.each do |array|
                csv << array
        end
end

new_csv = CSV.read("test_2.csv")
new_csv.each do |row|
    p row
end
