require 'rspec'
require_relative '../timer'
require_relative '../task_manager'
require_relative '../pomodoro_pal'
require_relative './main_methods'
require_relative '../run'

describe "check_timer_list" do
    it 'should check if the array is empty' do
        expect {check_timer_list([])}.to output("You haven't set any timers yet.\n").to_stdout
    end
    it 'should check if the array is not empty' do
        expect {check_timer_list([[1,2],[2,2]])}.to output("\nbanner\n' '\n'You haven't set any timers yet.\n' 'Go create one under (2) Set Timers.\n' 'pause('Press enter to return to menu...')").to_stdout
    end
end


