class Human
    attr_accessor :name, :health, :accuracy, :location,  :limbs, :is_able_to_fight

    def initialize(name, health, accuracy, location=false, prefers_attack=false)
        @name = name
        @health = health
        @accuracy = accuracy   #Used for calculating chance to hit an opponent
        @location = location   #The physical location they are in (rooms 1-5)
        @is_able_to_fight = true   #changes to false if certain limbs get too damaged

        #Holds the person's limbs with a verbose descriptor and health
        @limbs = {
            "la" => ["left arm", 25],
            "ra" => ["right arm", 25],
            "ll" => ["left leg", 30],
            "rl" => ["right leg", 30],
            "h" => ["head", 25],
            "g" => ["groin", 15],
            "t" => ["torso", 50]
        }
    end
    #Returns a random limb, used for generating a weak initial limb or a random target limb
    def get_random_limb
        random_limb = @limbs.values.sample   #Get a random sample from the limbs hash
        return random_limb
    end
    #If the player's arms are crippled, they can only kick, and vice-a-versa
    def get_combat_options
        if @limbs["ra"][1] > 0 or @limbs["la"][1] > 0
            if @limbs["ll"][1] > 0 or @limbs["rl"][1] > 0
                return "pk"   #can punch and kick
            else
                return "p"   #can only punch
            end
        elsif @limbs["rl"][1] > 0 or @limbs["ll"][1] > 0
            return "k" #can only kick
        else
            return false   #no limbs!
        end
    end
    #Calculates if an attack has landed
    def attack_has_hit(attack_type)
        if attack_type == "p"
            if rand(1..100) < @accuracy
                return true   #punch did hit
            end
        elsif attack_type == "k"
            if (rand(1..100)+15) < @accuracy
                return true   #kick did hit
            end 
        end
        return false   #did not hit
    end
    #Manages damage from an attack
    def take_damage(body_part, damage)
        if body_part == @limbs.key(@weakness)   #If the attack hits their weakness it does 1.5x damage
            @limbs[body_part][1] -= (damage*1.5).to_i
            if @limbs[body_part][1] <0 then @limbs[body_part][1] = 0 end   #Can't go lower than 0hp
            @health -= damage
        elsif body_part == "h"
            if @limbs[body_part][1] - damage <= 0   #If head hp would be less than 0 after taking this damage...
                damage = @limbs[body_part][1]   #Reduce damage to the amount of hp it has
                @limbs[body_part][1] = 0        #And set head hp to 0
                @health -= damage
            else
                @limbs[body_part][1] -= damage
            end
            @accuracy = @accuracy - damage   #Getting hit in the head reduces accuracy
        else
            @limbs[body_part][1] -= damage 
            if @limbs[body_part][1] <0 then @limbs[body_part][1] = 0 end
            @health = @health - damage
        end
        @is_able_to_fight = check_ability_to_fight   #Check if this attack removes their ability to fight
    end
    #If both arms and legs are crippled, they can't fight. Same for their weakness limb
    def check_ability_to_fight
        if @limbs["ra"][1] <= 0 and @limbs["la"][1] <= 0 and @limbs["rl"][1] <= 0 and @limbs["ll"][1] <= 0 
            return false   #all 4 limbs are destroyed
        elsif @health <= 0
            return false   #Their health is 0 or less
        elsif self.class.to_s == "Enemy"
            if @weakness[1] <= 0   #or if the enemies weakness is 0hp
                return false
            end
        end
        return true   #otherwise they can still fight
    end
end

#Enemies can (and do) have a weakness and sometimes have a preferred attack
class Enemy < Human
    attr_reader :weakness, :prefers_attack

    def initialize(name, health, accuracy, location=false, prefers_attack=false)
        super
        @prefers_attack = prefers_attack
        @weakness = self.get_random_limb    #Set a random limb to be a weak limb (if crippled, will remove them from combat)
    end
    def talk(struck_limb)   #When player hits the enemy, talk() is called
        return "#{@name}: #{speak(@location-1, struck_limb, @weakness[0])}"
    end
end