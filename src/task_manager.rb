require 'csv'

class Task
    attr_accessor :task_title, :task_note, :task_tickbox, :username, :tasks
    def initialize(args)
        @task_id = args[:task_id] || 0
        @task_tickbox = args[:task_tickbox] || false
        @task_title = args[:task_title] || ""
        @task_note = args[:task_note] || ""
        @username = args[:username] || ""
    end
end

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

#         puts "Task title:"
#         user.task_title = gets.chomp
#         puts "Task note:"
#         user.task_note = gets.chomp
#         CSV.open("tasks_to_do.csv", "a", headers: true) do |csv|
#             csv << [user.username, user.task_title, user.task_note, user.task_tickbox]
#         end
# end

def add_task(logged_in_user, user)
    while input == "Y"
        puts "Task title:"
        task_title = gets.chomp
        puts "Task note:"
        user.task_note = gets.chomp
        task_tickbox = false

        tasks << [task_title, task_note, task_tickbox, username]
        check_task_list(tasks)

        CSV.open("tasks_to_do.csv", "a", headers: true) do |csv|
            csv << tasks
        end
    end
    puts "Add another task?"
    input = gets.chomp.upcase
    # raise error for Y/N
end


if !File.exists?("tasks_to_do.csv")
    CSV.open("tasks_to_do.csv", "w", headers: false) do |csv|
        csv << ["Username", "Task Title", "Task Note", "Task Tickbox"]
    end

    # Choose user to assign task to #
    puts "Would you like to assign this task to (a) yourself or (b) another user?"
    option = gets.chomp.downcase
    case option
    when "a"
        username = logged_in_user
        new_task = Task.new(:username => logged_in_user)
    
    when "b"
        puts "Who would you like to assign this task to?"
        username = gets.chomp.capitalize
        new_task = Task.new(:username => username)
    end
else

    # Choose user to assign task to #
    puts "Would you like to assign this task to (a) yourself or (b) another user?"
    input = gets.chomp.downcase
    
    if input == "a"
        username = logged_in_user
        new_task = Task.new(:username => logged_in_user)
    
    elsif input == "b"
        puts "Who would you like to assign this task to?"
        username = gets.chomp.capitalize
        new_task = Task.new(:username => username)
    end
    
    add_task(logged_in_user, new_task)
end










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

