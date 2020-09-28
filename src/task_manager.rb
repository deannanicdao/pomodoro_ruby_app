# require 'csv'

# class TaskManager
# task_title
# task_note

# class TaskManager
#     def initialize(name, task_list)
#         @name = name
#         populate_task_list(task_list)
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


# def read_task
# end

# def update_task
# end

# def delete_task
# end