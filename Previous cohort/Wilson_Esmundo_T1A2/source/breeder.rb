require "tty-table"

class Breeder
    
    attr_accessor :collection

    def initialize
        @collection = []
        
    end
        # adds the input to an array
    def update_database(bird)
        @collection.push(bird)
        File.open("@collection.yml", "w") { |file| file.write(@collection.to_yaml) }
    end    
        # iterates data on a array
    def list_stocks
            p = Pastel.new
            @collection = YAML.load(File.read("@collection.yml"))
            @collection.each do |element|
                
            id_tag = p.decorate("ID TAG",:black, :on_green)
            type = p.decorate("TYPE",:black, :on_green)
            mutation = p.decorate("MUTATION",:black, :on_green)
            sex = p.decorate("SEX",:black, :on_green)
            age = p.decorate("AGE (mos)",:black, :on_green)
            table = TTY::Table.new ["#{id_tag}","#{type}","#{mutation}","#{sex}","#{age}"], [[element.id_tag, element.type, element.mutation, element.sex, element.age]]
                puts table.render(:unicode, alignments: [:center, :center, :center, :center, :center])
            
            end
    end
        # removes data from an array
    def delete_stocks
        prompt = TTY::Prompt.new
        self.list_stocks
        prompt.ok("Which of them you want to delete (e.g.) 1 - 10 first one at the top."  )
        user_delete_input = gets.chomp.to_i
        if user_delete_input.between?(1, @collection.length)
            @collection.slice!(user_delete_input.to_i - 1)
            box = TTY::Box.warn("Are you sure you want to delete?")
                    print box
                    user_input = prompt.ask("Press Y / N then hit Enter", required: true) 
                        if user_input == "y" 
                            File.open("@collection.yml", "w") { |file| file.write(@collection.to_yaml) }
                            box = TTY::Box.success("Bird Record Deleted")
                            print box
                            pause
                        else
                            delete_stocks
                        end
        else 
            box = TTY::Box.error("Invalid Choice")
            print box
            pause 
        
        end
    end
end
