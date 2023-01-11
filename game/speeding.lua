--speeding up--

function speed_up(score)
	
	if flr(score%150)==1
	and score>5 then
		
		--showmsg("keep going!",120)
		player.max_dx+=.5

		--max speed--
	elseif player.max_dx>12 then
		player.max_dx=12	
	end
	
end