--ui

function addwind(_x,_y,_w,_h,_txt)
	local w={x=_x,
			y=_y,
			w=_w,
			h=_h,
			txt=_txt}
	add(wind,w)
	return w
end

function drawind()
	for w in all(wind) do
		local wx,wy,ww,wh=w.x,w.y,w.w,w.h
		
		--which line
		wx+=4
		wy+=4
		
		clip(wx,wy,ww-8,wh-8)
		for i=1,#w.txt do
			local txt=w.txt[i]
			print(txt,wx,wy,1)
			wy+=12
		end
		
		if w.dur!=nil then
			w.dur-=1
			if w.dur<=0 then
				del(wind,w)
			end
		end	
	end
end

--textbox that disappears
function showmsg(txt,dur)
	local x=player.x
	local y=player.y
	local wid=#txt*4+7
	local w=addwind(x,y-10,wid,13,{txt})
	drawind()
	w.dur=dur
	
end

function rectfill2(_x,_y,_w,_h,_clr)
	rectfill(_x,_y,_x+_w-1,_y+_h-1,_clr)
end