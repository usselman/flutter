--powerups

function break_pot()
	if trigscore then
	mget(player.x,player.y)
	mset(player.x,player.y,88)
	end
end