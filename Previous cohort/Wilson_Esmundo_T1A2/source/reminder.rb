
class Reminder
    attr_accessor :list_reminder   
   
   def initialize()
       @list_reminder =[]
   end
        # iterates data from an array
   def opening_reminder()
       @list_reminder = YAML.load(File.read("@list_reminder.yml"))
       @list_reminder.each do |element|
       box = TTY::Box.frame(width: 30, height: 10, align: :center, padding: 3, title: {top_left: "NOTES",
           bottom_right: 'wilson® v1.0'}, style: {fg: :bright_yellow, bg: :blue, border: {fg: :bright_yellow,
           bg: :blue}}) do "#{element}"
           end   
           print box 
           
           end
    end
        # adds data to an array
   def writing_reminder()
       prompt = TTY::Prompt.new
       box = TTY::Box.info("Journal Section")
       print box
       @new_reminder = prompt.ask("Please type your notes here...", required: true)
       @list_reminder.push(@new_reminder)
       File.open("@list_reminder.yml", "w") { |file| file.write(@list_reminder.to_yaml) }
       box = TTY::Box.success("Journal Added")
       print box
       pause
   end
        # removes data from an array
   def deleting_reminder()
       prompt = TTY::Prompt.new
       self.opening_reminder()
       prompt.ok("Which of them you want to delete (e.g.) 1 - 10 first one at the top.")
       reminder_delete_input = gets.chomp.to_i
            if reminder_delete_input.between?(1, @list_reminder.length)
                @list_reminder.slice!(reminder_delete_input.to_i - 1)
                box = TTY::Box.warn("Are you sure you want to delete?")
                print box
                user_input = prompt.ask("Press Y / N then hit Enter", required: true) 
                        if user_input == "y"
                            File.open("@list_reminder.yml", "w") { |file| file.write(@list_reminder.to_yaml) }
                            box = TTY::Box.success("Journal Deleted")
                            print box
                            pause
                       else
                           deleting_reminder        
                        end
            else 
                box = TTY::Box.error("Invalid Choice")
                print box
                pause 
            end               
   end

end

