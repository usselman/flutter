--variables

function _init()
	
	--menu
	scene="menu"
	state=0
	music_on=true

	--simple camera
	cam_x=0
	cam_x_offset=32

	 -- Set up persistent storage with a unique identifier
	 cartdata("flutter-valley")

	 -- Retrieve the stored high score, default to 0 if not set
	 --player.high_score = dget(0) or 0
	
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
		--boost=4.2,
		boost=3,
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
		high_score=0,
		new_high=false,
		gif_timer=0,
	}
	
  enemyamt=4	
  --up down ghost
  enemy_list = {}
  for i=1,enemyamt/2 do
  local enemy={
  sp=33,
   -- this or something similar so they don't end up in the same spot
  --x=map_end,
  x=player.x+cam_x_offset+120,
  y=80/i,
  w=8,
  h=8,
  dx=0.5,
  dy=-0.5,
  dir=-.002
  }
  
 enemy_list[i]=enemy
 end
 
 --side ghost
 enemy2_list = {}
  for i=1,enemyamt do
	
  local enemy={
  sp=16,
   -- this or something similar so they don't end up in the same spot
  x=flr(rnd(512)+256),
  y=flr(rnd(68))+24,
	-- y=(j*16),
  w=8,
  h=8,
  dx=-(rnd(1)+.25),
  dy=0,
  dir=0
  }
	
 enemy2_list[i]=enemy
 end
	
	particle={
		x=0,
		y=0,
		sp=0,
		age=0
	}
	enemy_particle={
		x=0,
		y=0,
		sp=21
	}
	
	level=1
	gravity=0.258
	friction=0.85
	
	--bg candle--
	
	
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

	for x=0,6 do
	map_gen()
	--rescroll=false
	end
end

