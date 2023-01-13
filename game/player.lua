--player

function player_update()

	if player.score<=0 then
		player.score=0
	end

	if player.acc>0 and
	player.dead==false
	 then
		player.score+=player.spd/2
		speed_up(player.score)
	end
	
	--record score 
	poke2(0x5f80, player.score)
	--record gamestate
	poke2(0x5f81, state)

	
	--physics
	--player.dx=2
	player.dy+=gravity
	player.dx*=friction
	
	--runner--
	player.dx=player.max_dx/2
	
	--controls
	
	if btn(⬅️) and player.dead==false then
		player.dx+=-1
		player.score-=player.spd/2

	end
	
	--jump
	if btnp(❎) and player.dead==false
	and player.landed then
		player.dy-=player.boost
		player.landed=false
		player.jumping=true
		--jump!--
		sfx(0)		
	end	
	
	--duck
	if btn(⬇️) and player.dead==false then
		player.ducking=true
		spawndust(player.x,player.y)
		--player.y = 2
	else 
		player.ducking=false	
	end	
	
	
	--floor
	if player.dy>0 then
		player.falling=true
		player.landed=false
		player.jumping=false

		if btnp(❎) and player.dead==false and player.falling then
			--flutterjump
			player.dy-=player.boost/0.5
			player.landed=false
			player.jumping=true
			sfx(5)
				
		end
		
		
		
		player.dy=limit_speed(player.dy,player.max_dy)
		
		if collide_map(player,"down",0) then
			player.landed=true
			player.falling=false
			player.dy=0
			player.y-=(player.y+player.h)%8
			
			-------test------
			collide_d="yes"
			else collide_d="no"
			-----------------
		end
	--ceiling	
		elseif player.dy<0 then
		player.jumping=true
		
		if collide_map(player,"up",1) then
			player.dy+=3
			player.dx=0
			spawndust(player.x,player.y)
			sfx(7, 2)
			--player.score-=10
			
			-------test------
			collide_u="yes"
			else collide_u="no"
			-----------------
		end
	end
--left and right	
	if player.dx<0 then
	player.running=true	

--max speed
	player.dx=limit_speed(player.dx,player.max_dx)
	--left
		if collide_map(player,"left",1) then
			player.dx=0
		
			-------test------
			collide_l="yes"
			else collide_l="no"
			-----------------
		end
	elseif player.dx>0 then	

	--max
		player.dx=limit_speed(player.dx,player.max_dx)
	--right
		if collide_map(player,"right",1) then
			player.dx=0
			if player.dx==0 then
				--player.x+=-.8
				player.dx+=-4
				player.dy+=.5
				sfx(7, 2)
			end
			-------test------
			collide_r="yes"
			else collide_r="no"
			-----------------
		end
		--trap
		if collide_map(player,"right",3) then
			player.dead=true
		end
	end			
	player.x+=player.dx
	player.y+=player.dy
 
 if player.dx==0 then
 	--player.score-=5	
 end
 
 
 --death conditions	
	if collide_map(player,"right",3) then
		player.dead=true	
	elseif collide_map(player,"down",3) then
		player.dead=true	
	elseif collide_map(player,"up",3) then
		player.dead=true
	elseif collide_map(player,"left",3) then
		player.dead=true
	elseif player.y<0 then
		player.dead=true
	elseif player.y>128 then
		player.dead=true	
	end

	--rescrolling--
	if player.x>map_end-player.w then
		rescroll=true
		player.x=player.x-map_end
		
	else
			rescroll=false
	end
	return rescroll 
end

function player_animate()
		if player.jumping then
			player.sp=2
			spawntrail(player.x,player.y)
			
		elseif player.ducking then
			player.sp=4	
			fset(65,0,false)
			fset(81,0,false)
			fset(114,0,false)
			player.dy+=1
			player.falling=true
		elseif player.landed then
			
			player.sp=1
			spawntrail(player.x,player.y)
		elseif player.falling then
			player.sp=3	
			fset(65,0,true)
			fset(81,0,true)
			fset(114,0,true)
			--spawntrail(player.x,player.y-player.w/2)	
		end	
	
		--player particles
		--spawntrail(player.x,player.y)
end

function limit_speed(dx,maximum)
	return	mid(-maximum,dx,maximum)
end

