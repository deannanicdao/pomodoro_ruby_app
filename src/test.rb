require 'csv'
require 'smarter_csv'

# CSV.read("tasks.csv")
# table = CSV.parse(File.read("tasks.csv"), headers: true)
# p table.by_row[0]
# puts "--------"
# p table.by_col[0]
# puts "--------"
# p table.by_row
# puts "--------"
# p table.by_col
# puts "--------"
# list = CSV.read("tasks.csv")

# p list.by_row

# id,task,note,user,tickbox
# 1,csv,learn how to edit and delete, deanna, incomplete
# 2,testing,find a good example, deanna, incomplete
# 3,foobar, chill out, deanna, incomplete

# CSV.open("test.csv", "w") do |csv|
#     csv << [:blue, 1]
#     csv << [:white, 2]
#     csv << [:black, 3]
# end

# IntegerConverter = Object.new

# def IntegerConverter.convert(value)
#     Integer(value)
# end

# task_list = SmarterCSV.process('tasks.csv', value_converters: { id: IntegerConverter })

# puts "Edit this task?"
# puts "#{task_list[0][:id]}. #{task_list[0][:task].upcase} | '#{task_list[0][:note].capitalize}' | Assigned to: #{task_list[0][:user].upcase} | Completion: #{task_list[0][:tickbox].upcase}"

# total_chunks = SmarterCSV.process('tasks.csv') do |chunk|
#     chunk.each do |item|   # you can post-process the data from each row to your heart's content, and also create virtual attributes:
#         # item[:full_name] = [item[:first],item[:last]].join(' ')  # create a virtual attribute
#         item.delete(:first) ; item.delete(:last)              # remove two keys
#     end
#     puts chunk.inspect   # we could at this point pass the chunk to a Resque worker..
# end


total_chunks = SmarterCSV.process('test.csv', {:chunk_size => 2, :key_mapping => {:color => :color, :quantity}}) do |chunk|
    chunk.each do |item|   # you can post-process the data from each row to your heart's content, and also create virtual attributes:
        item[:row] = [item[:color],item[:quantity]].join(' ')  
        item.delete(:color) ; item.delete(:quantity)
    end
    puts chunk.inspect   # we could at this point pass the chunk to a Resque worker..
end

# puts "Edit this task?"
# puts "#{task_list[0][:id]}. #{task_list[0][:task].upcase} | '#{task_list[0][:note].capitalize}' | Assigned to: #{task_list[0][:user].upcase} | Completion: #{task_list[0][:tickbox].upcase}"





