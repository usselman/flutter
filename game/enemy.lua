--enemy--

--up and down ball--
function enemy_update(e)
	local enemy=e
	spawncircle(e.x,e.y)
	enemy.dy+=enemy.dir
	enemy.y+=enemy.dy
	enemy.x+=enemy.dx

	--spawntrail(enemy.x+enemy.w +rnd(enemy.w),enemy.y)
	
	if enemy.y>96 then
			enemy.dy=-1.2
	end		
	if enemy.y<16 then 
			enemy.dy=1	
	end
	if enemy.x<player.x-80 and player.x<map_end-128-cam_x_offset then
		enemy.x=player.x+cam_x_offset+80
	end
	if rescroll then 
		enemy.x=player.x+cam_x_offset+80
	end

	if enemy_collide(player,"right",3,enemy) then
			player.dead=true
	end
	
end

--side to side ghost
function enemy2_update(e)
	local enemy=e
	e.x+=e.dx
	spawncircle(e.x,e.y)

	--enemy reloader--
	if (e.x<player.x-80 and player.x<map_end-128-cam_x_offset) then 
		e.x=player.x+96
		e.y=flr(rnd(64))+32
		e.dx=-(rnd(1)+.25)
	end

	if rescroll then 
		e.x=player.x+64+cam_x_offset+rnd(256)
		e.dx=-(rnd(1)+.25)
		e.y=flr(rnd(64))+32
	end

	
	if	enemy_collide(player,"right",3,enemy) then
 		player.dead=true
 	end
	
end

function enemy_animate(enemy)
	if enemy.dy>0 then
		enemy.sp=33
	end
	if enemy.dy<0 then
		enemy.sp=34
	end	
end


function enemy_collide(obj,aim,flag,e)
	local x=obj.x	local y=obj.y
	local w=obj.w local h=obj.h
	
	local x1=0 local y1=0
	local x2=0 local y2=0
	
	local x3=e.x local y3=e.y
	local w2=e.w local h2=e.h
	
	local x4=x3+w2-1
	local y4=y3+h2-1
	 
	if aim=="left" then
		x1=x-2			y1=y-1
		x2=x+1					y2=y+h
	
	elseif aim=="right" then
		x1=x+w			y1=y+1
		x2=x+w-obj.dx+1					y2=y+h-1
	
			
	elseif aim=="up" then
		x1=x			y1=y-2
		x2=x+w-2	y2=y		
	
	elseif aim=="down" then	
		x1=x+3					y1=y+h
		x2=x+w-4			y2=y+h
		
	elseif aim=="e_down" then	
		x1=x+3					y1=y+h
		x2=x+w-4			y2=y+h+2	
	end
	
	----test------
	x1r=x1 y1r=y1
	x2r=x2 y2r=y2
	--------------
	if (not (x1>x4 or y1>y4 or x2<x3 or y2<y3)) then
		return true
	else
		return false
	end
	
end

