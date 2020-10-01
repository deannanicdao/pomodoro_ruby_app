require 'csv'




# class Task
#     attr_accessor :task_title, :task_note, :task_tickbox, :username, :tasks
#     def initialize(args)
#         @task_id = args[:task_id] || 0
#         @task_tickbox = args[:task_tickbox] || false
#         @task_title = args[:task_title] || ""
#         @task_note = args[:task_note] || ""
#         @username = args[:username] || ""
#         @tasks = []
#     end
# end

def check_task_list(tasks)
    if tasks.empty? == false
        puts "Here are your current tasks:"
        # print csv rows
    else tasks.empty? == true
        puts " "
        puts "You haven't set any tasks yet."
        puts "Go create one under (3) Set Tasks."
        puts " "
        sleep(2)
    end
end

# def add_task(logged_in_user, user)

# end

########### MAIN #############
# system('clear')
# puts "Username:"
# logged_in_user = gets.chomp.capitalize
# tasks = []

# loop do
#         system('clear')
#         if !File.exists?("tasks_to_do.csv")
#             CSV.open("tasks_to_do.csv", "w", headers: false) do |csv|
#                 csv << ["Username", "Task Title", "Task Note", "Task Tickbox"]
#             end

#             # Choose user to assign task to #
#             puts "Would you like to assign this task to (a) yourself or (b) another user?"
#             option = gets.chomp.downcase
#             case option
#             when "a"
#                 username = logged_in_user
#                 new_task = Task.new(:username => logged_in_user)
#                 puts "Assign task to: #{username}? (Y/N)"
#                 input = gets.chomp.upcase
#                 # raise error here
#             when "b"
#                 puts "Who would you like to assign this task to?"
#                 username = gets.chomp.capitalize
#                 new_task = Task.new(:username => username)
#                 puts "Assign task to: #{username}? (Y/N)"
#                 input = gets.chomp.upcase
#                 # raise error here
#             when "c"
#                 return
#             else
#                 system('clear')
#                 puts "Please select (a) or (b) or (c) to return to menu"
#                 return
#             end
#         else
#             # Choose user to assign task to #
#             puts "Would you like to assign this task to (a) yourself or (b) another user?"
#             option = gets.chomp.downcase
            
#             case option
#             when "a"
#                 username = logged_in_user
#                 # new_task = Task.new(:username => logged_in_user)
#                 puts "Assign task to: #{username}? (Y/N)"
#                 input = gets.chomp.upcase
#                 tasks << username
#                 # raise error here
#             when "b"
#                 puts "Who would you like to assign this task to?"
#                 username = gets.chomp.capitalize
#                 # new_task = Task.new(:username => username)
#                 puts "Assign task to: #{username}? (Y/N)"
#                 input = gets.chomp.upcase
#                 tasks << username
#                 # raise error here
#             else
#                 system('clear')
#                 puts "Please select (a) or (b)"
#                 sleep(2)
#             end

#             puts "Task title:"
#             task_title = gets.chomp
#             tasks << task_title
#             puts "Task note:"
#             task_note = gets.chomp
#             tasks << task_note
#             task_tickbox = false
#             tasks << task_tickbox
#             # tasks << [task_title, task_note, task_tickbox, username]
#             # check_task_list(tasks)
        
#             CSV.open("tasks_to_do.csv", "a", headers: true) do |csv|
#                 csv << tasks
#             end
        
#             puts "Add another task?"
#             input = gets.chomp.upcase
#             # raise error for Y/N

#             if input == "Y"
#                 puts "Task title:"
#                 task_title = gets.chomp
#                 tasks << task_title
#                 puts "Task note:"
#                 task_note = gets.chomp
#                 tasks << task_note
#                 task_tickbox = false
#                 tasks << task_tickbox
#                 # tasks << [task_title, task_note, task_tickbox, username]
#                 # check_task_list(tasks)
            
#                 CSV.open("tasks_to_do.csv", "a", headers: true) do |csv|
#                     csv << tasks
#                 end

#             elsif input == "N"
#                 # show list of tasks
#             else 
#                 puts "Please enter 'Y' or 'N'".
#             end
#             puts "end of loop?"
#         end
#         puts "External loop reached"
#     end
# end

# ------------- above is broken ------------- #

# user.tasks.each do |username, task_title, task_note, task_tickbox|
#     puts "Username: #{username} Task Title: #{task_title} Task Note: #{task_note} Complete? #{task_tickbox}"
# end

# new_user = User.new(:username => @username, :task_tickbox => false)

# require 'csv'

# class TaskManager
# task_title
# task_note

# class Task
#     def initialize(name, task_list)
#         CSV.open("tasks_to_do.csv", "w", headers: true) do |csv|
#             csv << tasks([Title, Note, Tickbox, Username])
#           end
#     end
# end


# def create_task
#     puts "Please add your task title."
#     # add rescue here if empty
#     tasks_to_do << gets.chomp
    
#     puts "Add a short note? (Y/N)"
#     input = gets.chomp.capitalize
#     # add rescue here if input is not Y/N
    
#     if input == "Y"
#         task_note = gets.chomp
#         tasks_to_do << task_note
#     end
    
#     CSV.open("tasks_to_do.csv", "a", headers: true) do |csv|
#         csv << tasks_to_do
#     end
# end

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