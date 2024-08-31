--speeding up--

function speed_up(score)
	
	if flr(score%150)==1
	and score>5 then
		
		player.max_dx+=.25

		--max speed--
	elseif player.max_dx>12 then
		player.max_dx=12	
	end
	
end