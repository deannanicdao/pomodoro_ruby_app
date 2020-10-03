#Descriptions of the beginning plus each of the 5 locations
def location_descriptions(index, player)
    descriptions = [
        "Your name is #{player.name}, and your girlfriend, Linda, has been kidnapped! The local mafia are keeping her in the top level of the mysterious pagoda on the outskirts of town...  You head towards it...",
        "When you arrive, you step inside.  The room is a dojo of some sort, there is a man meditating.  It is Hwang!  He is known for his brutal kicks!  He hears you enter and approaches you with anger in his eyes, get ready!",
        "You catch your breath and head upstairs.  It's a dark room with a single chair, where another angry man is sitting.  It is Taky, and he is watching PUNCH drunk love while drinking PUNCH...!  You wonder what this could all mean...  He gets up and screams as he lunges at you!",
        "Exhausted, you continue upstairs.  Into an even darker room with an even angrier, louder man, who you know nothing about!  Get ready!",
        "You crawl upstairs.  There is no one here and you are safe.                                Just kidding, you are being attacked!",
        "You have reached the top floor! Your girlfriend is playing Monopoly with Kareem, the mafia boss, and she seems VERY bored...  He attacks you, of course!",
    ]
    return descriptions[index]
end

#Enemy taunts, said when you miss
def taunts
    taunts = [
        "You fight as well as you smell!  Which is to say, bad!",
        "You suck!",
        "Boy I've seen losers before, but this is nuts!",
        "No pain, no gain!",
        "Linda is ours now! Get over it!",
        "You are a bad person!",
        "Get out! This is our pagoda!",
        "You're from that place I don't like!",
        "I trained for years just to kick your butt!",
        "If you were a better boyfriend, you wouldn't be in this situation!",
        "You look like a weakling! Oh! It's because you are!",
        "Hahahah you missed!",
        "Missed me again!",
        "You can't even hit me!",
    ]
    return taunts[rand(0..taunts.length()-1)]
end

#Things enemies will say when you hit them
def speak(index, struck_limb, weak_limb)
    dialogues = [
        ["OW!", "Ow! My #{struck_limb}!", "I love my #{weak_limb}...", "Don't hit my weak #{weak_limb}!!", "Nooooo! My #{struck_limb}!", "Good thing I don't need my #{struck_limb}!", "What did I ever do to you??"],
        ["Oof!", "I'm removing you from Facebook...", "*He is cradling his #{weak_limb}*", "Why'd you have to hit my #{struck_limb}??", "Whatever you do don't hit my #{weak_limb}!", "That hurt more than my last git addbreak up!"],
        ["Oh my God that smarts!", "Owie owie owie!!", "If I put on my glasses would you stop hitting me?", "I'm a bleeder!", "Weak #{weak_limb}?  Who said I had a weak #{weak_limb}??", "Why God? Why!?"],
        ["*cries*", "What did my #{struck_limb} ever do to you?", "My God you're strong! I see why your girlfriend likes you.", "I think we went to the same school!", "I'm so glad you don't know about my weak #{weak_limb}!"],
        ["OW! I should've become a programmer...", "*He tumbles backwards over the Monopoly board*", "I was about to pass GO, too!", "Good thing I don't need my #{struck_limb}", "I'm about to bankrupt you, fool!!", "You just landed on Mayfair, sucker!!", "If it'll make you stop hitting me, my weakness is my #{weak_limb}."],
    ]
    return dialogues[index][rand(0..dialogues[index].length-1)]
end

#Message player will receive when he cripples an enemies limb
def damage_message(limb)
    description = [
        "His #{limb} is not looking very good...!",
        "His #{limb} is destroyed beyond recognition!",
        "#{limb}?  What #{limb}? It is no longer recognisable!",
        "His #{limb} is beaten to a pulp...",
        "#{limb}'s are not supposed to look like *that*",
        "His #{limb} looks like a skin-bag full of mince.",
        "His #{limb} has been knocked clean off!",
        "His #{limb} appears to be broken, mangled and generally unwell.",
        "His busted #{limb} makes you sick to look at",
        "The #{limb} looks nothing like it did a second ago.",
        "His #{limb} is purple, swollen and bleeding.  Consider it unusable.",
        "Looking at his broken #{limb}, you *almost* feel bad..."
    ]
    return description.sample
end