--update and draw
music(13,100,7)

function _update()
	update_particles()
	
 --menu--
 if scene=="menu" then
		pal()
 		update_menu()
 		state=0
 elseif scene=="game" then
		pal()
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

--menu functions--
function update_menu()
	for i=0,15 do
		pal(6,rnd(i))
	end
	if btnp(❎) then
		scene="game"
	end
end

function draw_menu()
	cls()
	--title text--
	map(0,32,4,0,16,16)
	rect(0,0,127,127,12)
	rect(1,1,126,126,10)

	--bg--
	--map(32,0,0,0,16,16)
	
	wind={}
	
	addwind(26,62,90,80,
	{"     x:jump!     ",
	 "    left:slow!   ",
	 "  x in air:fly!  ",
	 "  down = duck!   ",
	 "press x to start!"
	})
	drawind()

end

function update_game()
 --game state--
 	
	rand=rnd(16)
	if btn(❎) and player.dead==false then
	 	player.start=true
	end
	
	if player.start and player.dead==false then
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
	camera(cam_x+cam_x_offset,0)
	
end

function draw_game()
	cls()
	
	bg_x=map_x
	
	---bg----
	for map_x=-map_end,map_end,128 do
		for bg_x=-map_end, map_end,128 do
	
	--star bg
	map(32,16,map_x,0,16,16)

	--candles--------------------
	map(0,16,map_x,0,16,16)
	
	--draw stars----------------
	map(32,16,bg_x,map1y,16,16)
	map(48,16,bg_x,map2y,16,16)
	map(32,16,bg_x+127,map1y-map_height,16,16)
	map(48,16,bg_x+127,map2y-map_height,16,16)
		end
	end
	
	--level--
	map(0,0,0,0,map_x+map_end,16)
	map(0,0,map_end,0,8,16)
	map(0,0,-map_end,0,8,16)

	--rescrolling
	map(0,0,map_x-map_end,0,map_end,16)	
	map(0,0,map_x+map_end,0,map_end,16)

	--draw particles
	draw_particles()

	--player--
	spr(player.sp,player.x,player.y,1,1,player.flp)
	
	if player.start then
	--diamonds
	diamonds()
	
	if player.score>2000 then
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
		enemy2_list[2].y = 16

		spr(enemy2_list[i].sp,enemy2_list[i].x,enemy2_list[i].y) 
 	
	end

 end
 
	
	if player.spd%1==.25 then
		--print("keep going!",player.x-14,player.y-10,rand)
		--pal(rnd(15),5)
		if trigspeed==false then
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
		--cls()
		update_particles()
		
		spr(14, player.x,player.y)
		
		if player.dead and trig==false then
			--death sfx--
			sfx(3,1)
			sfx(6)
			map1y=0
	
			music(-1)
			trig=true
		else
			trig=true
		end
		player.start=false
		
		--star bg
		map(32,16,map_x,0,16,16)

		---bg----
		for map_x=-map_end,map_end,128 do
			for bg_x=-map_end, map_end,128 do
			--candles--------------------
			map(0,16,map_x,0,16,16)
		
			--draw stars----------------
			map(32,16,bg_x,map1y,16,16)
			map(48,16,bg_x,map2y,16,16)
			map(32,16,bg_x+127,map1y-map_height,16,16)
			map(48,16,bg_x+127,map2y-map_height,16,16)
		
			--pillars--
			--map(16,16,map_x-player.x/2,0,16,16)
			end
		end	

		
		map(0,0,0,0,map_x+map_end,16)
		map(0,0,map_end,0,8,16)
		map(0,0,-map_end,0,8,16)

		player_update()
		draw_particles()

		--spawn_gem_effect(player.x + player.w/4, player.y + 6)
		deathtrail(player.x+player.w/4,player.y-map1y-player.h)
		
		player.dx=0
		state=2

		--rectfill(player.x-2, 44, player.x+68, 66, 0)
		--rect(player.x-4,42,player.x+70,98,7)
		print("you died!",player.x+player.dx+18,44,7)
		print("press ⬆️ to restart",player.x+player.dx-4,54,7)
		print("score: "..flr(player.score),player.x+16+player.dx,68,7)
		
		--change scene--
		--scene="dead"
		if btnp(⬆️) then
			player.start=false
			scene="menu"
			player.dead=false
			run()
		end
	end
	
	--textbox
	if player.start==false then
		--drawind()
	end
	---------test----------
	if test then
	rect(x1r,y1r,x2r,y2r,12)
	print("⬅️= "..collide_l,player.x,player.y-10)
	print("➡️= "..collide_r,player.x,player.y-16)
	print("⬆️= "..collide_u,player.x,player.y-28)
	print("⬇️= "..collide_d,player.x,player.y-22)
	print("jump? "..(player.jumping and 'true' or 'false'),player.x,player.y-34)
	print("speed: "..player.dx, cam_x+6,20,7)
	end
	-----------------------
	--score
	
	--was 10
    --print("dx: "..player.spd, cam_x+6,30)
	if player.start then
		print("score:",cam_x+6+cam_x_offset,10,7)
		print(" "..flr(player.score),cam_x+30+cam_x_offset,10,rnd(15))

		if player.score>10 and player.score<75 then
			print("get ready...",cam_x+6+cam_x_offset, 18, rnd(15))
		end	

		if player.score>500 and player.score<600 then
			print("keep going!",cam_x+6+cam_x_offset, 18, rnd(15))
		end	

		if player.score>1200 and player.score<1350 then
			print("pretty good!",cam_x+6+cam_x_offset, 18, rnd(15))
		end	

		if player.score>1850 and player.score<2000 then
			print("wow!",cam_x+6+cam_x_offset, 18, rnd(15))
		end	

		if player.score>2400 and player.score<2550 then
			print("keep going!",cam_x+6+cam_x_offset, 18, rnd(15))
		end	

		if player.score>2800 and player.score<3000 then
			print("you're amazing!",cam_x+6+cam_x_offset, 18, rnd(15))
		end	

		if player.score>3400 and player.score<3750 then
			print("flutter my heart <3",cam_x+6+cam_x_offset, 18, rnd(15))
		end	
	end
end
