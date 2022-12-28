--map gen--

function map_gen()
	cls()
	gen_tiles()
	rescroll=false
end

------------
--tiles
------------
function gen_tiles()
	
	local t=rndtiles(5,1)	
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

	for _x=32,127,2 do
		--for _y=16,48 do
			for _y=4,11,3 do
			if doestilefit(t,_x,_y) then
				
				add(cand,{x=rnd(_x),y=_y})
				if rescroll then
					for i=1,#cand do
						del(cand,i)
					end
				end
				
			end
		end
	end

	if #cand==0 then return false end

	c=getrnd(cand)
	t.x=c.x
	t.y=c.y
	
	
	for _x=0,t.w do
		for _y=0,t.h-1 do
			tile=65
			pot=0
			grass=0
			trap=0
			coin=0
				if _x%2==1 then
					tile=81
					grass=100
				end
				if _x%5==1 then
					tile=114
					grass=101
				end
				if _x%3==1 then
					pot=68
					grass=116
					
				end
				if _x%4==1 then
					grass=117
				end
				if _x%5==1 then
					trap=97
				end
				
				mset(_x+t.x+10,_y+t.y,tile)
				mset(t.x+1+10,t.y-1,pot)
				mset(t.x+2+10,t.y-1,grass)
				mset(t.x+3+10,t.y-1,trap)
		end
	end	
end

function map_update()

end

function getrnd(arr)
	return arr[1+flr(rnd(#arr))]
end

function doestilefit(t,x,y)

		if x<64 then
			return false	
	end	
	return true
end