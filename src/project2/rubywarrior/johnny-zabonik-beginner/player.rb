class Player
  @health = 20
  def play_turn(warrior)
    # add your code here
	if warrior.feel.empty?
		if warrior.health > 18 || @health > warrior.health
			warrior.walk!
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
	@health = warrior.health
  end
end
