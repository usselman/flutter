--collisions

function collide_map(obj,aim,flag)
	--obj = table needs x,y,w,h	
	--aim = right, up, left, down
	
	local x=obj.x	local y=obj.y
	local w=obj.w local h=obj.h
	
	local x1=0 local y1=0
	local x2=0 local y2=0
	 
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
	
	--pixels to tiles
	x1/=8					y1/=8
	x2/=8    	y2/=8
	
	if fget(mget(x1,y1), flag)
	or fget(mget(x1,y2), flag)
	or fget(mget(x2,y1), flag)
	or fget(mget(x2,y2), flag) then
	return true
	else
		return false
	end	
end