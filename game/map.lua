--map gen--

function map_gen()
	gen_tiles()
	rescroll=false
end

------------
--tiles
------------
function gen_tiles()
	
	--create random tiles of w, h
	local t=rndtiles(7,1)	
	place_tile(t)

end

function rndtiles(mw,mh)
	local _w=2+flr(rnd(mw))
	local _h=1+flr(rnd(mh-1))
	
	return {
		x=16,
		y=16,
		w=_w,
		h=_h
	}

end

function place_tile(t)
	local cand,c={}
	--   for _y=3,10,3 do
	-- 	for _x=1,127 do
	-- 	--clear objects
		
	-- 	end
	-- end

	-- for _x=16+(cam_x_offset/8),16,2 do
		for _x=64,96,16 do
			for _y=4,11,3 do
			if doestilefit(t,_x,_y) then
				
				add(cand,{x=rnd(_x)+16,y=_y})
				-- if rescroll then
				-- 	for i=1,#cand do
				-- 		del(cand,i)
				-- 	end
				-- end
				
			end
		end
	end


	if #cand==0 then return false end

	c=getrnd(cand)
	t.x=c.x
	t.y=c.y
	
	
	--draw tiles
	for _x=0,t.w do
		for _y=0,t.h-1 do
			rock=0
			tile=65
			pot=0
			diamond=0
			grass=0
			trap=0
			coin=0
			pile=0
				if _x%2==1 then
					tile=81
					grass=100
				end
				if _x%5==1 then
					tile=114
					grass=116
					--rock=89
					--pile=121
				end	
				if _x%3==1 then
					--pot=68
					diamond=104
					grass=116
					
				end
				if _x%4==1 then
					grass=117
				end
				if _x%5==1 then
					--diamond=105
				end
				if _x%2==0 then
					grass=101
				end
				
			-- mset(_x+t.x+10,_y+t.y,tile)
			mset(_x+t.x,_y+t.y,tile)
			mset(t.x+rnd(t.w),t.y-1,grass)
			mset(t.x+3,t.y-1,diamond)
				
		end
	end	
	return c
end

function map_update()
	--clear tiles
	for _y=4,11,3 do
		for _x=1,127 do
			--clear tiles and objects
		  	mset(_x, _y, 0)
			mset(_x, _y-1,0)
		end
	  end
end

function getrnd(arr)
	return arr[1+flr(rnd(#arr))]
end

function doestilefit(t,x,y)

	if x>100 or x<48 then
		return false	
	end	
	return true
end