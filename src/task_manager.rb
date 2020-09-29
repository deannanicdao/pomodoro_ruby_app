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