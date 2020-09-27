# write at least one test for each class
# guides class definition and ensures we write sound code
# start from lowest level data structure


require_relative '../timer'
require_relative '../task_manager'
require_relative '../pomodoro_pal'
require_relative '../clock'

describe TaskManager do
    it 'should create a task manager' do
        name = "Task Manager"
        task_list = {}
        task_manager = TaskManager.new(name, task_list)
        expect(task_manager.name).to eq(name)
    end
    # it 'should show a list of options: create, read, update and delete' do
    # end
    # it 'should have a create option, that adds a new task to the hash' do
    #     name = "To-do list"
    #     task_list = {}
    #     task = Task.new(name, note, tickbox)
    #     expect(taskname).to eq(name)
    # end
end


