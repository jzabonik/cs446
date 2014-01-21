# instance var	:
# class var		:
# constants		:
# array			:
# hash			:
# function		:
# comments		:

class Player
  MAX_HEALTH = 20	# maximum health for a warrior
  @@fight_threshhold = MAX_HEALTH * 0.7	# when you want to just go for the kill. otherwise you could get caught up in retreating to gain health over and over again
  @health = MAX_HEALTH	# @health keeps track of the current warrior health to see if they took damage last turn
  @hit_wall = false		# determines whether the warrior has seen a wall before
  @in_middle = false	# indicates that the player is not next to a wall to start off with
  @@action_map =  { :nothing => "melee", :Captive => "melee", :Wizard => "range", :wall => "melee", :Archer => "range", :Sludge => "melee" }
  
  def play_turn(warrior)
	if @hit_wall || @in_middle
		look_around(warrior)
	else
		if  warrior.feel(:backward).wall?
			# go forward
			@hit_wall = true
		elsif warrior.feel(:forward).wall?
			# go backward
			warrior.pivot!
			@hit_wall = true
		else
			warrior.pivot!
			@in_middle = true
		end
	end
	@health = warrior.health
  end
  
  def look_around(warrior)
    @attack_type = "melee"
	warrior_sight = warrior.look
	warrior_sight.each { |object|
		if object.to_s == "nothing"
			next
		else
			key = object.to_s
			@attack_type = @@action_map[key.to_sym]
			break
		end
	}
	take_action(warrior)
  end
  
  def take_action(warrior)
	if @attack_type == "melee"
		if warrior.feel.empty?
			if warrior.health == MAX_HEALTH || @health > warrior.health
				if @health > warrior.health && warrior.health < @@fight_threshhold
					warrior.walk!(:backward)
				else
					warrior.walk!
				end
			else
				warrior.rest!
			end
		else
			if warrior.feel.captive?
				warrior.rescue!
			else
				warrior.attack!
			end
		end
	else
		warrior.shoot!
	end
  end
end
