#This test.rb tests 2 class methods in classes.rb; take_damage and check_ability_to_fight.
#It creates a test_person Human class then gives damage to one of their limb variables.
#It then tests that the limb health has indeed been reduced.
#The 2nd test then sets the classes health to zero and checks if they can still fight, which returns false (as expected)

require "test/unit"
require_relative "./classes.rb"

class GameTest < Test::Unit::TestCase
    #This test passes as right arm is equal to 15 after taking 10 damage
    def test_take_damage
        test_person = Human.new("Test person", 100, 80, 1)
        test_person.take_damage("ra", 10)   #give them 10 damage to their right arm, should now be 15, not 25
        assert_equal(test_person.limbs["ra"][1], 15)
    end

    #This test fails, after 40 damage to his head, he is NOT able to fight
    def test_check_ability_to_fight
        test_person2 = Human.new("Test person", 100, 80, 1)
        test_person2.health = 0
        assert(test_person2.check_ability_to_fight)
    end
end