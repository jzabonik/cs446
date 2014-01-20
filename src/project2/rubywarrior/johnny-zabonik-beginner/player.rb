class Player
  MAX_HEALTH = 20
  FIGHT_THRESHHOLD = 14
  @health = MAX_HEALTH
  @hit_wall = false
  def play_turn(warrior)
	if  @hit_wall
		#walk forward
		if warrior.feel.empty?
			if warrior.health == MAX_HEALTH || @health > warrior.health
				if @health > warrior.health && warrior.health < FIGHT THRESHHOLD
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
		if warrior.feel(:backward).wall?
			@hit_wall = true
		elsif warrior.feel(:backward).empty?
			if warrior.health > 18 || @health > warrior.health
				warrior.walk!(:backward)
			else
				warrior.rest!
			end
		else
			if warrior.feel(:backward).captive?
				warrior.rescue!(:backward)
			else
				warrior.attack!(:backward)
			end
		end
	end
	@health = warrior.health
  end
end
