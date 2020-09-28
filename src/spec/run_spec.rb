# write at least one test for each class
# guides class definition and ensures we write sound code
# start from lowest level data structure


require_relative '../timer'
require_relative '../task_manager'
require_relative '../pomodoro_pal'
require_relative '../clock'

# describe TaskManager do
#     it 'should create a task manager' do
#         name = "Task Manager"
#         task_list = {}
#         task_manager = TaskManager.new(name, task_list)
#         expect(task_manager.name).to eq(name)
#     end
    # it 'should show a list of options: create, read, update and delete' do
    # end
    # it 'should have a create option, that adds a new task to the hash' do
    #     name = "To-do list"
    #     task_list = {}
    #     task = Task.new(name, note, tickbox)
    #     expect(taskname).to eq(name)
    # end
# end

describe Timer do
    it 'should set a time' do
        set_time = 45 * 60
        expect(set_time).to eq(set_time)
    end
    it 'should set a work timer' do
        set_time = 45 * 60
        work_timer = set_time
        expect(work_timer).to eq(2700)
    end
    it 'should set a rest timer' do
        set_time = 15 * 60
        rest_timer = set_time
        expect(rest_timer).to eq(900)
    end
    it 'should display your timers' do
        rest_timer = 900
        work_timer = 2700
        myTimer = Timer.new(900, 2700)
        expect(myTimer.display).to eq(nil)
    end
    it 'should countdown' do
        
    end
end


