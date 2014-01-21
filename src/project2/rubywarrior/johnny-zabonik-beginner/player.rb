# instance var	: using @health, @hit_wall, and @in_middle
# class var		: using @@fight_threshhold and @@action_map
# constants		: MAX_HEALTH is the only constant I used
# array			: I only used the warrior_sight as an array to hold array returned by warrior.look in the look_around function
# hash			: @@action_map is used to determing what action to take based on the results from looking around
# function		: I used the default play_turn(), then added look_around() and take_action()
# comments		: throughout file

class Player
  MAX_HEALTH = 20	# maximum health for a warrior
  @@fight_threshhold = MAX_HEALTH * 0.7	# when you want to just go for the kill. otherwise you could get caught up in retreating to gain health over and over again
  @health = MAX_HEALTH	# @health keeps track of the current warrior health to see if they took damage last turn
  @hit_wall = false		# determines whether the warrior has seen a wall before
  @in_middle = false	# indicates that the player is not next to a wall to start off with
  @@action_map =  { :nothing => "melee", :Captive => "melee", :Wizard => "range", :wall => "melee", :Archer => "range", :Sludge => "melee" } # hash for action from looking around
  
  def play_turn(warrior)
	if @hit_wall || @in_middle
		look_around(warrior)
	else
		if  warrior.feel(:backward).wall?
			# wall behind warrior, go forward
			@hit_wall = true
		elsif warrior.feel(:forward).wall?
			# warrior in front of warrior, go backward
			warrior.pivot!
			@hit_wall = true
		else
			# no walls directly in front or behind warrior, go backwards for the heck of it
			warrior.pivot!
			@in_middle = true
		end
	end
	@health = warrior.health	# update health to see if warrior is being attacked
  end
  
  # have the warrior look around before deciding what to do
  def look_around(warrior)
    @attack_type = "melee"	# default the action as melee (just walking around)
	warrior_sight = warrior.look	# gather info on warrior's surroundings
	warrior_sight.each { |object|	
		if object.to_s == "nothing"
			next
		else
			key = object.to_s
			@attack_type = @@action_map[key.to_sym]		# set action based on what object the warrior has to deal with
			break
		end
	}
	take_action(warrior)
  end
  
  # warrior takes action based off of what he/she saw when looking around
  def take_action(warrior)
	if @attack_type == "melee"
		if warrior.feel.empty?			# nothing directly in front of warrior
			if warrior.health == MAX_HEALTH || @health > warrior.health
				if @health > warrior.health && warrior.health < @@fight_threshhold	# warrior is hurt, being attacked, and needs to get out of danger to heal
					warrior.walk!(:backward)
				else					#warrior is healthy enough to take on enemy
					warrior.walk!		
				end
			else						#warrior needs to heal
				warrior.rest!
			end
		else							# warrior is next to something
			if warrior.feel.captive?	# warrior is next to captive, free him
				warrior.rescue!
			else						# warrior is next to enemy, attack him
				warrior.attack!
			end
		end
	else	# action is to attack an enemy at range(wizard or archer)
		warrior.shoot!
	end
  end
end
