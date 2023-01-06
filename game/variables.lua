--variables

function _init()
	
	--menu
	scene="menu"
	state=0
	
	--stars
	map1y=0
	map2y=0
	map1_spd=1
	map2_spd=.65
	map_height=180
	
	player={
		sp=1,
		x=59,
		y=50,
		w=8,
		h=8,
		flp=false,
		dx=0,
		dy=0,
		max_dx=4,
		max_dy=4,
		acc=1.8,
		boost=4.2,
		anim=0,
		running=false,
		jumping=false,
		falling=false,
		landed=false,
		ducking=false,
		dead=false,
		start=false,
		speeding=false,
		score=0,
		spd=0,
	}
	
  --up down ghost
  enemy_list = {}
  for i=1,4 do
  local enemy={
  sp=33,
   -- this or something similar so they don't end up in the same spot
  --x=map_end,
  x=i * 180 - flr(150*rnd())-124,
  y=flr(rnd(64))+10,
  w=8,
  h=8,
  dx=1,
  dy=1,
  dir=.02
  }
  
 enemy_list[i]=enemy
 end
 
 --side ghost
 enemy2_list = {}
  for i=1,7 do
  local enemy={
  sp=16,
   -- this or something similar so they don't end up in the same spot
  x=flr(rnd(1024/i))*i+128*2,
  y=flr(rnd(84))+12,
  w=8,
  h=8,
  dx=-(rnd(1.5)+.25),
  dy=0,
  dir=0
  }
  
 enemy2_list[i]=enemy
 end
	
	particle={
		x=0,
		y=0,
		sp=17
	}
	
	level=1
	gravity=0.3
	friction=0.85
	
	--bg candle--
	
	--simple camera
	cam_x=0
	
	--map limits=8 screens
	map_start=0
	y_offset=32
	x_offset=127
	map_end=1024
	map_x=map_start
	bg_x=map_start
	bg_spd=25
	
	--levels
	lv_x={0,16,32,48,64,80,96,112}
	lv_y={32,48}
	
	--iterator
	itr=0
	
	
	--rescroll
	rescroll=false
	
	--sfx variables
	trig=false
	trigstart=false
	trigspeed=false
	trigscore=false
	
	--text
	wind={}
	
	--start screen
	--[[
	addwind(24,24,90,64,
	{"press ❎ to start!",
	"❎=jump! ⬅️=slow!",
	"❎ in air=fly!",
	"good luck, runner!",
	"- wb games 2022 -"})
	]]--
	--score
	addwind(cam_x+6,10,10,10,
	{"score:"..flr(player.score)})
	
	
	-----test--------------
	x1r=0	y1r=0 x2r=0 y2r=0
	collide_l="no"
	collide_r="no"
	collide_u="no"
	collide_d="no"
	--test = true
	-----------------------

	for x=0,2 do
	map_gen()
	rescroll=false
	end
end

