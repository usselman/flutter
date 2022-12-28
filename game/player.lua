--player

function player_update()
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
	
	if btn(⬅️) then
		player.dx+=-1
	end
	
	--jump
	if btnp(❎)
	and player.landed then
		player.dy-=player.boost
		player.landed=false
		player.jumping=true
		--jump!--
		sfx(0)		
	end	
	
	--duck
	if btn(⬇️) then
		player.ducking=true
	else 
		player.ducking=false	
	end	
	
	--check collision up and down
	
	--floor
	if player.dy>0 then
		player.falling=true
		player.landed=false
		player.jumping=false
		if player.falling then
			if btnp(❎) then
				player.dy-=player.boost/1.5
				player.landed=false
				player.jumping=true
				sfx(5)
				
			end
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
			player.dy=0
			player.score-=10
			
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
				player.x+=-.8
				player.dy+=.5
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
 	player.score-=5	
 end
 if player.score<=0 then
    player.score=0
end
 
 --death conditions	
	if collide_map(player,"right",3) then
		player.dead=true	
	elseif collide_map(player,"down",3) then
		player.dead=true	
	elseif collide_map(player,"up",3) then
		player.dead=true
	elseif player.y>128 then
		player.dead=true	
	end
	
	--powerups
	if collide_map(player,"right",2) then
		if trigscore==false then
			sfx(4)
			
			player.score*=1.05
			trigscore=true
			showmsg("x1.25!",50,player.y)
		else
			trigscore=false
		end
	end
	
	if player.x>map_end-player.w then
		--map.x=map_start
		
		player.x=map_start-player.w
		
		if player.x==map_start-player.w then
			rescroll=true
			return rescroll	
		else
			rescroll=false
		end
		
	end
		
end

function player_animate()
		if player.jumping then
			player.sp=2
			
		elseif player.ducking then
			player.sp=4	
		elseif player.landed then
			player.sp=1
		elseif player.falling then
			player.sp=3		
		end	
	
end

function limit_speed(dx,maximum)
	return	mid(-maximum,dx,maximum)
end

