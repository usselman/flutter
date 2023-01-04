--update and draw
music(10,0,15)
--menu functions--
function update_menu()
		if btnp(❎) then
				scene="game"
		end
end

function draw_menu()
	cls()
		---bg----
	for map_x=0,map_end,127 do
		for bg_x=0, map_end,127 do
	
		--draw stars----------------
		map(32,16,bg_x,map1y,16,16)
		map(48,16,bg_x,map2y,16,16)
		map(32,16,bg_x+127,map1y-map_height,16,16)
		map(48,16,bg_x+127,map2y-map_height,16,16)
		

		end
	end
	--stars--------
	map1y+=map1_spd
	map2y+=map2_spd
	if map1y>map_height then
		map1y=0
	elseif map2y>map_height then
		map2y=0
	end	
	---------------
	circfill(64,64,52,7)
	circfill(64,64,50,3)
	
	circ(64,64,58,6)
	circ(64,64,56,1)
		wind={}
		
		--start screen
		print("✽flutter✽",44,27,rnd(16))
		addwind(28,36,90,80,
		{"press x to start!",
		"x=jump! ⬅️=slow!",
		"x in air=fly!",
		"good luck, runner!",
		"✽wb games 2023✽",
	    "     v 0.1     "})
		drawind()
end

function _update()
 --menu--
 if scene=="menu" then
 		update_menu()
 		state=0
 elseif scene=="game" then
 		update_game()
 		state=1
 		
 end
end 

function _draw()
	--state
	if scene=="menu" then
 		draw_menu()
 elseif scene=="game" then
 		draw_game()
 end
end


function update_game()
 --game state--
 	
	rand=rnd(16)
	if btn(❎) then
	 player.start=true
 end
	
	
	
	if player.start then
	sec=time()
		--rescroll=true
		if player.start and trigstart==false then
			--sfx(1,-1,4)
			trigstart=true
		else 
			trigstart=true
		end
		
		trigscore=false
		
		map_update()
		player_update()
		player_animate()
		particle_update(player.x,player.y)
		
		
		break_pot()
		
		--enemy_collide(player)
		
	end
	
	--speed calc--------
	player.spd=player.dx

	--stars--------
	map1y+=map1_spd
	map2y+=map2_spd
	if map1y>map_height then
		map1y=0
	elseif map2y>map_height then
		map2y=0
	end	
	---------------
 
	
	--simple camera
	cam_x=player.x-64+(player.w/2)

	--[[
	if cam_x<map_start then
		cam_x=map_start
	end
	if cam_x>map_end-128 then
		cam_x=map_end-128
	end
	--]]
	camera(cam_x,0)

end

function draw_game()
	cls()
	
	bg_x=map_x
	
---bg----
	for map_x=0,map_end,127 do
		for bg_x=0, map_end,127 do
	--candles--------------------
	map(0,16,map_x,0,16,16)
	
	--draw stars----------------
	map(32,16,bg_x,map1y,16,16)
	map(48,16,bg_x,map2y,16,16)
	map(32,16,bg_x+127,map1y-map_height,16,16)
	map(48,16,bg_x+127,map2y-map_height,16,16)
	
	--pillars--
	map(16,16,map_x,0,16,16)
		end
	end
	
	--map_x-=bg_spd
	--map scroll----------------
	map(0,0,map_x,0,map_end,16)
	
	--level--
	map(0,0,0,0,map_x+map_end,16)
	map(0,0,map_end,0,8,16)
	map(0,0,-map_end,0,8,16)

	--player--
	spr(player.sp,player.x,player.y,1,1,player.flp)
	
	if player.start then
	
	if sec>20 then
	for i=1,#enemy_list do
		--for j=1,#enemy2_list do
  enemy_update(enemy_list[i])
  enemy_animate(enemy_list[i])
  spr(enemy_list[i].sp,enemy_list[i].x,enemy_list[i].y)
		--[[
		if enemy_collide(player,"right",3,enemy_list[i]) then
			player.dead=true
		end
		--]]
	end
	end
	
	for i=1,#enemy2_list do
		enemy2_update(enemy2_list[i])
		spr(enemy2_list[i].sp,enemy2_list[i].x,enemy2_list[i].y) 
 	--[[
 	if	ememy_collide(player,"right",3,enemy2_list[i]) then
 		player.dead=true
 	end
 	--]]
 
 end
 end
 
	if player.jumping then
		particle_update(player.x,player.y,17)
		spr(particle.sp,particle.x,particle.y,1,1,player.flp)
	end
	if player.ducking then
		particle_update(player.x,player.y,18)
		spr(particle.sp,particle.x+5,particle.y-16,1,1,player.flp)
	end
	
	
	if player.spd%1==.25 then
		
		print("keep going!",player.x-14,player.y-10,rand)
		if trigspeed==false then
			sfx(2)
			trigspeed=true
		else
			trigspeed=true
		end
		--player.speeding=false
		
	end
	if rescroll==true then
		for i=0,5 do
			map_gen()
		end
	end
	

	--reset--
	if player.dead then
		if player.dead and trig==false then
			--death sfx--
			sfx(3,1)
			sfx(6)
			music(-1)
			trig=true
		else
			trig=true
		end
		cls(1)
		
		player.x=59
		player.y=59
		player.dx=0
		player.dy=0
		state=2
		print("you died! press up",29,39)
		print("score: "..flr(player.score),44,49,7)
		--change scene--
		--scene="dead"
		if btn(⬆️) then
			player.start=false
			run()
			
		end
	end
	
	--textbox
	if player.start==false then
		drawind()
	end
	---------test----------
	if test then
	rect(x1r,y1r,x2r,y2r,7)
	print("⬅️= "..collide_l,player.x,player.y-10)
	print("➡️= "..collide_r,player.x,player.y-16)
	print("⬆️= "..collide_u,player.x,player.y-28)
	print("⬇️= "..collide_d,player.x,player.y-22)
	print("jump? "..(player.jumping and 'true' or 'false'),player.x,player.y-34)
	print("speed: "..player.dx, cam_x+6,20,7)
	end
	-----------------------
	--score
	if player.start then
		--drawind()
	end
	
	
	print("score:",cam_x+6,10,7)
	print(" "..flr(player.score),cam_x+30,10,rnd(15))
    --print("dx: "..player.spd, cam_x+6,30)

end
