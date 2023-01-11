--update and draw
music(13,100,7)
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
	
	map(0,0,map_x-map_end,0,map_end,16)	

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
		"good luck, flutter!",
		"✽wb games 2023✽",
	    "     v 0.3     "})
		drawind()

	
end

function _update()
	update_particles()
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
	elseif scene=="dead" then
		
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
		if player.start and trigstart==false then
			trigstart=true
		else 
			trigstart=true
		end
		
		trigscore=false

		player_update()
		player_animate()
		
		
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
	camera(cam_x+cam_x_offset,0)

	
end

function draw_game()
	cls()
	
	bg_x=map_x
	
	---bg----
	for map_x=-map_end,map_end,127 do
		for bg_x=-map_end, map_end,127 do
	--candles--------------------
	map(0,16,map_x,0,16,16)
	
	--draw stars----------------
	map(32,16,bg_x,map1y,16,16)
	map(48,16,bg_x,map2y,16,16)
	map(32,16,bg_x+127,map1y-map_height,16,16)
	map(48,16,bg_x+127,map2y-map_height,16,16)
	
	--pillars--
	map(16,16,map_x-player.dx,0,16,16)
		end
	end
	
	--map_x-=bg_spd
	--map scroll----------------
	--map(0,0,map_x,0,map_end,16)
	
	--level--
	map(0,0,0,0,map_x+map_end,16)
	map(0,0,map_end,0,8,16)
	map(0,0,-map_end,0,8,16)

	--rescrolling
	map(0,0,map_x-map_end,0,map_end,16)	
	map(0,0,map_x+map_end,0,map_end,16)

	--animate diamonds

	--draw particles
	draw_particles()

	--player--
	spr(player.sp,player.x,player.y,1,1,player.flp)

	-- for x=0,1024 do
	-- 	for y=0,15 do
	-- 	  if fget(104, 2) == false then
	-- 		--add(gems, {x, y})
	-- 		mset(x, y, 0)
	-- 	  end
	-- 	end
	--   end


	
	if player.start then
	--diamonds
	diamonds()
	
	if sec>20 then
		for i=1,#enemy_list do
  			enemy_update(enemy_list[i])
  			enemy_animate(enemy_list[i])
  		spr(enemy_list[i].sp,enemy_list[i].x,enemy_list[i].y)

	
		end
	end


	for i=1,#enemy2_list do
		enemy2_update(enemy2_list[i])
		

		--enemy always on lowest y
		enemy2_list[1].y = 94

		--enemy always on highest y
		enemy2_list[4].y = 16

		spr(enemy2_list[i].sp,enemy2_list[i].x,enemy2_list[i].y) 
 
 end
 end
 
	
	if player.spd%1==.25 then
		--print("keep going!",player.x-14,player.y-10,rand)
		--pal(rnd(15),5)
		if trigspeed==false then
			sfx(2)
			trigspeed=true
		else
			trigspeed=true
		end
	end

	--regenerate map
	if rescroll==true then
		map_update()
		for i=0,12 do
			map_gen()
		end
	end
	

	--reset--
	if player.dead then
		if player.dead and trig==false then
			--death sfx--
			sfx(3,1)
			sfx(6)
			--music(-1)
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
		print("you died! press up",29+cam_x_offset,39)
		print("score: "..flr(player.score),44+cam_x_offset,49,7)
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
	
	--was 10
	print("score:",cam_x+6+cam_x_offset,10,7)
	print(" "..flr(player.score),cam_x+30+cam_x_offset,10,rnd(15))
    --print("dx: "..player.spd, cam_x+6,30)

	if player.score>50 and player.score<120 then
		print("get ready...",cam_x+6+cam_x_offset, 18, rnd(15))
	end	

	if player.score>500 and player.score<600 then
		print("keep going!",cam_x+6+cam_x_offset, 18, rnd(15))
	end	

	if player.score>1200 and player.score<1350 then
		print("pretty good!",cam_x+6+cam_x_offset, 18, rnd(15))
	end	

	if player.score>1650 and player.score<1800 then
		print("wow!",cam_x+6+cam_x_offset, 18, rnd(15))
	end	

	if player.score>2000 and player.score<2300 then
		print("keep going!",cam_x+6+cam_x_offset, 18, rnd(15))
	end	

	if player.score>2500 and player.score<3000 then
		print("you're amazing!",cam_x+6+cam_x_offset, 18, rnd(15))
	end	

	if player.score>3200 and player.score<3600 then
		print("flutter my heart <3",cam_x+6+cam_x_offset, 18, rnd(15))
	end	

end
