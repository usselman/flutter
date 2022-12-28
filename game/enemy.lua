--enemy--

--up and down ball--
function enemy_update(e)
	local enemy=e
	
	enemy.dy+=enemy.dir
	enemy.y+=enemy.dy
	enemy.x+=enemy.dx
	
	if enemy.y>80 then
			enemy.dy=-1
	end		
	if enemy.y<20 then 
			enemy.dy=.5	
	end
	if enemy.x>map_end then
		enemy.x=map_start
	end
	if enemy_collide(player,"right",3,enemy) then
			player.dead=true
	end
	
end

--side to side ghost
function enemy2_update(e)
	local enemy=e
	e.x+=e.dx
	
	--enemy.dx=-1	
	if e.x<map_start then
		e.x=map_end
		e.y=flr(rnd(80))+16
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

