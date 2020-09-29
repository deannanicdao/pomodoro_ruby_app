# write at least one test for each class
# guides class definition and ensures we write sound code
# start from lowest level data structure

require 'rspec'
require_relative '../timer'
require_relative '../task_manager'
require_relative '../pomodoro_pal'
require_relative '../clock'

describe "check_timer_list" do
    it 'should check if the array is empty' do
        expect {check_timer_list([])}.to output("You haven't set any timers yet.\n").to_stdout
    end
    it 'should check if the array is not empty' do
        expect {check_timer_list([[1,2],[2,2]])}.to output("Here are your current timers:\n1. Work timer: 1 min | Rest timer: 2 min\n2. Work timer: 2 min | Rest timer: 2 min\n").to_stdout
    end
end


