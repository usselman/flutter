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
			trigscore=true
			for i=0,50 do
		
			diamondtext(player.x,player.y)
			end

			if mget(player.x/8+1,player.y/8)==104 then
				mset(player.x/8+1,player.y/8,0)
			  elseif mget(player.x/8+1,player.y/8+1)==104 then
				mset(player.x/8+1,player.y/8+1,0)
			  elseif mget(player.x/8+1,player.y/8-1)==104 then
				mset(player.x/8+1,player.y/8-1,0)
			  elseif mget(player.x/8,player.y/8)==104 then
				mset(player.x/8,player.y/8,0)
			  end

			sfx(4)
		player.score+=100

	end

end