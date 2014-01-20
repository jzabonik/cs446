# instance var	:
# class var		:
# constants		:
# array			:
# hash			:
# function		:
# comments		:

class Player
  MAX_HEALTH = 20	# maximum health for a warrior
  FIGHT_THRESHHOLD = 14	# when you want to just go for the kill. otherwise you could get caught up in retreating to gain health over and over again
  @health = MAX_HEALTH	# @health keeps track of the current warrior health to see if they took damage last turn
  @hit_wall = false		# determines whether the warrior has seen a wall before
  @in_middle = false	# indicates that the player is not next to a wall to start off with
  
  def play_turn(warrior)
	if @hit_wall || @in_middle
		take_action(warrior)
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
  
  def take_action(warrior)
	if warrior.feel.empty?
		if warrior.health == MAX_HEALTH || @health > warrior.health
			if @health > warrior.health && warrior.health < FIGHT_THRESHHOLD
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
  end
end
