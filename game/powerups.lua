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
			fset(104,2,false)
			for i=0,50 do
			--print("+100!", cam_x+6+cam_x_offset, 24, rnd(15))
			print("+100!", player.x, player.y-player.w, 12)
			end
	end
	-- right
	if fget(104,2) == false then
		

		mset(player.x/8+1,player.y/8,0)
		spr(0,_p.x,_p.y, 1,1)
		--mset(player.x/8,player.y/8,0)
		--mset(player.x/8-1,player.y/8,0)
		--mset(player.x/8-1,player.y/8,0)
		--mset(player.x/8,player.y/8+1,0)
		--mset(player.x/8,player.y/8-1,0)


		sfx(4)
		--player.score*=1.10
		player.score+=100

	end
	fset(104,2,true)
end