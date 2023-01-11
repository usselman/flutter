--powerups

function break_pot()
	if trigscore then
	mget(player.x,player.y)
	mset(player.x,player.y,88)
	end
end

function diamonds()
	--diamonds
	if collide_map(player,"right", 2) then
		--or collide_map(player,"up", 2) or collide_map(player,"down", 2) or collide_map(player, "left", 2)
		-- pset(player.x+player.w*2,player.y,7)
			trigscore=true
			sfx(4)
			player.score*=1.10
			showmsg("1.05x!", 120)
			fset(104,2,false)
	end
	-- right
	if fget(104,2) == false then
		mset(player.x/8+1,player.y/8,0)
	end
	fset(104,2,true)
end