#The main fighting method, needs a player object, an enemies array and their location
def fight(player, location, enemies)
    for e in enemies
        if e.location == player.location
            opponent = e    #Extract the opponent object from the enemies array
        end
    end

    slow_print(location_descriptions(player.location), 0.05)    #Display the location's info
    puts "\n#{player.name} is attacking #{opponent.name}...".red

    while player.is_able_to_fight and opponent.is_able_to_fight     #Core loop, only executes while either the play or
        attack_selection = nil                                      #opponent can fight
        target_selection = nil

        while !["p", "k"].include?(attack_selection)    #Player can select only punch or kick
            puts "Make a choice:"
            case player.get_combat_options
            when "pk"
                puts "(p)unch or (k)ick"
            when "p"
                puts "(p)unch"
            when "k"
                puts "(k)ick"
            end

            attack_selection = gets.chomp

            begin
                raise NameError, "Invalid key" if !player.get_combat_options.include?(attack_selection)    #Handler for invalid input
            rescue NameError => e
                puts "ERROR: #{e}"
            end
        end
        
        if attack_selection == "p"   #Calculate damage for the attack
            damage = rand(5..10) + (higher(player.limbs["ra"][1], player.limbs["la"][1]))/10
        elsif attack_selection == "k"
            damage = rand(8..15) + (higher(player.limbs["rl"][1], player.limbs["ll"][1]))/10
        end
        damage = damage.to_i
        system "clear"
        display_stats(player)
        display_stats(opponent)
        puts "Where would you like to target?"
        puts "(h)ead (ra)right arm (la)left arm (ll)left leg (rl)right leg (g)roin (t)orso (h)ead"

        while !["h", "g", "t", "ra", "la", "rl", "ll"].include?(target_selection)   #Requires valid target input
            target_selection = gets.chomp
            begin   #Handler for invalid input
                raise NameError, "Invalid key" if !["h", "g", "t", "ra", "la", "rl", "ll"].include?(target_selection)
            rescue NameError => e
                puts "ERROR: #{e}"
            end
        end

        if player.attack_has_hit(attack_selection)  #Player hits opponent
            opponent.take_damage(target_selection, damage)  #Calculate damage and modify opponents health
            system "clear"
            display_stats(player)
            display_stats(opponent)
            puts "#{opponent.name} was hit in the #{opponent.limbs[target_selection][0]}".red

            #If struck limb is crippled (<0 health) then print a damage message to indicate this
            if opponent.limbs[target_selection][1] <= 0
                puts damage_message(opponent.limbs[target_selection][0])
            end
            slow_print(opponent.talk(opponent.limbs[target_selection][0]), 0.05)   #Opponent speaks

        else
            system "clear"
            display_stats(player)
            display_stats(opponent)
            puts "you missed!".yellow
            print "#{opponent.name}: "
            slow_print(taunts, 0.05)    #Opponent taunts player
        end
        
        #Now opponent attacks player...
        if opponent.is_able_to_fight
            target_selection = player.get_random_limb   #Opponent targets a random player limb

            #If enemy has a preferred attack, that becomes their attack selection
            if opponent.prefers_attack == "p" and ["p"].include?(opponent.get_combat_options)
                puts "#{opponent.name} tries to punch you in your #{target_selection}"
                attack_selection = "p"
            elsif opponent.prefers_attack == "k"  and ["k"].include?(opponent.get_combat_options)
                puts "#{opponent.name} tries to kick you in your #{target_selection[0]}"
                attack_selection = "k"
            #Otherwise, randomise their attack selection:
            else
                if opponent.get_combat_options.include?("p")
                    attack_selection = "p"
                    puts "#{opponent.name} tries to punch you in your #{target_selection[0]}"
                elsif opponent.get_combat_options.include?("k")
                    attack_selection = "k"
                    puts "#{opponent.name} tries to kick you in your #{target_selection[0]}"
                else
                    puts "#{opponent.name} has no way to attack you!"
                    return false
                end
                
            end

            pause("Press enter to see if he hits you...!")
            system "clear"
            
            if opponent.attack_has_hit(attack_selection)    #Opponent hits player
                if attack_selection == "p"
                    damage = rand(5..10) + (higher(opponent.limbs["ra"][1], opponent.limbs["la"][1]))/10
                    player.take_damage(player.limbs.key(target_selection), damage)
                elsif attack_selection == "k"
                    damage = rand(10..20) + (higher(opponent.limbs["rl"][1], opponent.limbs["ll"][1]))/10
                    player.take_damage(player.limbs.key(target_selection), damage)
                end
                display_stats(player)
                display_stats(opponent)
                puts "#{opponent.name} hits you in the #{target_selection[0]} for #{damage} damage!".red
            else
                display_stats(player)
                display_stats(opponent)
                puts "...And he misses.".yellow   #Enemy misses player
            end
        else
            puts "#{opponent.name} is too damaged to continue!\nYou win!".green
            pause("Press enter to continue...")
            player.location += 1
        end
    end
end

#Prints a given string one char at a time, at a given speed
def slow_print(string, speed)
    text_wrap_width = 100
    counter = 0
    STDIN.echo = false
    string.each_char {|c| putc c ; 
        sleep speed
        if counter > text_wrap_width   #text is now at minimum width
            if c == " "
                puts "\n"
                counter = 0
            end
        else
            counter += 1
        end
    }
    puts "\n"
    STDIN.echo = true
end

#Displays the player's health of each limb at top of terminal
def display_stats(person)
    stats_to_display = [
        person.limbs["h"], person.limbs["t"], person.limbs["g"], person.limbs["ra"], 
        person.limbs["la"], person.limbs["ll"], person.limbs["rl"]
    ]
    output = ""
    if person.health >= 20
        print "#{person.name}: Health: "
        print "#{person.health}".green
        print " // "
    elsif person.health <20 && person.health >= 10
        print "#{person.name}: Health: "
        print "#{person.health}".yellow
        print " // "
    else
        print "#{person.name}: Health: "
        print "#{person.health}".red
        print " // "
    end

    #Displays the health stats at the top of the screen
    for stat in stats_to_display
        if stat[1] <= 10 and stat[1] > 0
             print "#{stat[0]}:"
             print "#{stat[1]} ".yellow
             print "// "
        elsif stat[1] <= 0
            print "#{stat[0]}:"
            print "CRIPPLED ".red
            print "// "
        else
            print "#{stat[0]}:"
            print "#{stat[1]} ".colorize(:light_green)
        end
    end
    print "\n"
    STDOUT.flush
end

#Returns which number is higher, used for calculating punch or kick strength based on arms and legs HP
def higher(var1, var2)
    if var1 > var2 
        return var1 
    else
        return var2
    end
end

#Prompts the user with a message whilst pausing the game
def pause(message)
    puts message
    pausing = true
    while pausing == true
        if gets
            pausing = false
        end
    end
    system "clear"
end