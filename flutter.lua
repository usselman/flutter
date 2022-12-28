-- flutter
-- by shirish sarkar
-- 12.20.22

--variables

function _init()
    
    --menu
    scene="menu"
    state = 0
    
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
  for i=1,8 do
  local enemy={
  sp=16,
   -- this or something similar so they don't end up in the same spot
  x=flr(rnd(1024/i))*i+128*2,
  y=flr(rnd(84))+12,
  w=8,
  h=8,
  dx=-(rnd(1.4)+.25),
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
    x1r=0    y1r=0 x2r=0 y2r=0
    collide_l="no"
    collide_r="no"
    collide_u="no"
    collide_d="no"
    --test = true
    -----------------------

    for x=0,24 do
    map_gen()
    rescroll=false
    end
end


-->8
--update and draw
music(0,0,0)
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
    circfill(64,55,52,7)
    circfill(64,55,50,3)
    
    circ(64,55,50,6)
    circ(64,55,48,1)
        wind={}
        --print("are you ready?",30,63)
        
        --start screen
        print("✽flutter✽",44,18,7)
        addwind(28,28,90,64,
        {"press x to start!",
        "x=jump! ⬅️=slow!",
        "x in air=fly!",
        "good luck, runner!",
        "✽wb games 2022✽"})
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
     if    ememy_collide(player,"right",3,enemy2_list[i]) then
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
    print(" "..flr(player.score),cam_x+30,10,15)
    --print("dx: "..player.spd, cam_x+6,30)

end

-->8
--collisions

function collide_map(obj,aim,flag)
    --obj = table needs x,y,w,h    
    --aim = right, up, left, down
    
    local x=obj.x    local y=obj.y
    local w=obj.w local h=obj.h
    
    local x1=0 local y1=0
    local x2=0 local y2=0
     
    if aim=="left" then
        x1=x-2            y1=y-1
        x2=x+1                    y2=y+h
    
    elseif aim=="right" then
        x1=x+w            y1=y+1
        x2=x+w-obj.dx+1                    y2=y+h-1
    
            
    elseif aim=="up" then
        x1=x            y1=y-2
        x2=x+w-2    y2=y        
    
    elseif aim=="down" then    
        x1=x+3                    y1=y+h
        x2=x+w-4            y2=y+h
        
    elseif aim=="e_down" then    
        x1=x+3                    y1=y+h
        x2=x+w-4            y2=y+h+2    
    end
    
    ----test------
    x1r=x1 y1r=y1
    x2r=x2 y2r=y2
    --------------
    
    --pixels to tiles
    x1/=8                    y1/=8
    x2/=8        y2/=8
    
    if fget(mget(x1,y1), flag)
    or fget(mget(x1,y2), flag)
    or fget(mget(x2,y1), flag)
    or fget(mget(x2,y2), flag) then
    return true
    else
        return false
    end    
end
-->8
--player

function player_update()
    if player.acc>0 and
    player.dead==false
     then
        player.score+=player.spd/2
        speed_up(player.score)
    end
    
    --record score 
    poke2(0x5f80, player.score)
    --record gamestate
    poke2(0x5f81, state)
	--[[
    if player.start==false then
        state=0
    elseif player.start==true then
        state=1
    elseif player.dead==true then
        state=2
    end
    --]]

    
    --physics
    --player.dx=2
    player.dy+=gravity
    player.dx*=friction
    
    --runner--
    player.dx=player.max_dx/2
    
    --controls
    
    if btn(⬅️) then
        player.dx+=-1
    end
    --[[
    if btn(➡️) then
        player.dx+=player.acc
        player.running=true
        player.flp=false
    end
    --]]
    
    --jump
    if btnp(❎)
    and player.landed then
        player.dy-=player.boost
        player.landed=false
        player.jumping=true
        --jump!--
        sfx(0)        
    end    
    
    --duck
    if btn(⬇️) then
        player.ducking=true
    else 
        player.ducking=false    
    end    
    
    --check collision up and down
    
    --floor
    if player.dy>0 then
        player.falling=true
        player.landed=false
        player.jumping=false
        if player.falling then
            if btnp(❎) then
                player.dy-=player.boost/1.5
                player.landed=false
                player.jumping=true
                sfx(5)
                
            end
        end
        
        player.dy=limit_speed(player.dy,player.max_dy)
        
        if collide_map(player,"down",0) then
            player.landed=true
            player.falling=false
            player.dy=0
            player.y-=(player.y+player.h)%8
            
            -------test------
            collide_d="yes"
            else collide_d="no"
            -----------------
        end
    --ceiling    
        elseif player.dy<0 then
        player.jumping=true
        
        if collide_map(player,"up",1) then
            player.dy=0
            player.score-=10
            
            -------test------
            collide_u="yes"
            else collide_u="no"
            -----------------
        end
    end
--left and right    
    if player.dx<0 then
    player.running=true    

--max speed
    player.dx=limit_speed(player.dx,player.max_dx)
    --left
        if collide_map(player,"left",1) then
            player.dx=0
        
            -------test------
            collide_l="yes"
            else collide_l="no"
            -----------------
        end
    elseif player.dx>0 then    

    --max
        player.dx=limit_speed(player.dx,player.max_dx)
    --right
        if collide_map(player,"right",1) then
            player.dx=0
            if player.dx==0 then
                player.x+=-.8
                player.dy+=.5
            end
            -------test------
            collide_r="yes"
            else collide_r="no"
            -----------------
        end
        --trap
        if collide_map(player,"right",3) then
            player.dead=true
        end
    end            
    player.x+=player.dx
    player.y+=player.dy
 
 if player.dx==0 then
     player.score-=5
     if player.score<=0 then
            player.score=0
        end
 end
 
 --death conditions    
    if collide_map(player,"right",3) then
        player.dead=true    
    elseif collide_map(player,"down",3) then
        player.dead=true    
    elseif collide_map(player,"up",3) then
        player.dead=true
    elseif player.y>128 then
        player.dead=true    
    end
    
    --powerups
    if collide_map(player,"right",2) then
        if trigscore==false then
            sfx(4)
            
            player.score*=1.05
            trigscore=true
            showmsg("x1.25!",50,player.y)
        else
            trigscore=false
        end
        
        --enemy collide
        --[[
        for i=1,#enemy_list do
            if ememy_collide(player,"right",3,enemy_list[i]) then
                player.dead=true
            end
        end
    
        for i=1,#enemy2_list do
            if    ememy_collide(player,"right",3,enemy2_list[i]) then
                player.dead=true
            end
        end
        --]]
    end
    
    if player.x>map_end-player.w then
        --map.x=map_start
        
        player.x=map_start-player.w
        
        if player.x==map_start-player.w then
            rescroll=true
            return rescroll    
        else
            rescroll=false
        end
        
    end
        
end

function player_animate()
        if player.jumping then
            player.sp=2
            
        elseif player.ducking then
            player.sp=4
        --elseif player.running then
            --player.sp=5        
        elseif player.landed then
            player.sp=1
        elseif player.falling then
            player.sp=3        
        end    
    
end

function limit_speed(dx,maximum)
    return    mid(-maximum,dx,maximum)
end


-->8
--speeding up--

function speed_up(score)
    
    if flr(score%150)==1
    and score>5 then
    showmsg("keep going!",120)
        --player.speeding=true
        --print("speeding!",player.x,player.y)
        player.max_dx+=.5
        
        --max speed--
    elseif player.max_dx>12 then
        player.max_dx=12    
    end
    
    --return player.max_dx


end
-->8
--particle--

function particle_update(x,y,num)
        particle.x=x-5
        particle.y=y+5
        particle.sp=num
        --particle.x*=friction
        
end
-->8
--enemy--

--up and down ball--
function enemy_update(e)
    local enemy=e
    
    enemy.dy+=enemy.dir
    enemy.y+=enemy.dy
    enemy.x+=enemy.dx
    
    if enemy.y>80 then
            enemy.dy=-1
    end        
    if enemy.y<20 then 
            enemy.dy=.5    
    end
    if enemy.x>map_end then
        enemy.x=map_start
    end
    if enemy_collide(player,"right",3,enemy) then
            player.dead=true
    end
    
end

--side to side ghost
function enemy2_update(e)
    local enemy=e
    e.x+=e.dx
    
    --enemy.dx=-1    
    if e.x<map_start then
        e.x=map_end
        e.y=flr(rnd(80))+16
    end
    
    if    enemy_collide(player,"right",3,enemy) then
         player.dead=true
 end
    
end

function enemy_animate(enemy)
    if enemy.dy>0 then
        enemy.sp=33
    end
    if enemy.dy<0 then
        enemy.sp=34
    end    
    --fset(enemy.sp,3)
    --fset(enemy2.sp,3)
end


function enemy_collide(obj,aim,flag,e)
    local x=obj.x    local y=obj.y
    local w=obj.w local h=obj.h
    
    local x1=0 local y1=0
    local x2=0 local y2=0
    
    local x3=e.x local y3=e.y
    local w2=e.w local h2=e.h
    
    local x4=x3+w2-1
    local y4=y3+h2-1
     
    if aim=="left" then
        x1=x-2            y1=y-1
        x2=x+1                    y2=y+h
    
    elseif aim=="right" then
        x1=x+w            y1=y+1
        x2=x+w-obj.dx+1                    y2=y+h-1
    
            
    elseif aim=="up" then
        x1=x            y1=y-2
        x2=x+w-2    y2=y        
    
    elseif aim=="down" then    
        x1=x+3                    y1=y+h
        x2=x+w-4            y2=y+h
        
    elseif aim=="e_down" then    
        x1=x+3                    y1=y+h
        x2=x+w-4            y2=y+h+2    
    end
    
    ----test------
    x1r=x1 y1r=y1
    x2r=x2 y2r=y2
    --------------
    if (not (x1>x4 or y1>y4 or x2<x3 or y2<y3)) then
        return true
    else
        return false
        --print("yes!",player.x,player.y)
    end
    
end


-->8
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
            --if doestilefit(t,_x,_y) then
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
                --mset(t.x+4,t.y-1,enemy.sp)
                --enemy_update()
        end
    end    
end

function map_update()
    --mset(t.x+enemy.x,t.y-1,trap)
end

function getrnd(arr)
    return arr[1+flr(rnd(#arr))]
end

function doestilefit(t,x,y)

        if x<64 then
            return false    
    end
--]]    
    return true
end
-->8
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
        --rectfill2(wx,wy,ww,wh,6)
        --rectfill2(wx+1,wy+1,ww-2,wh-2,0)
        --rectfill2(wx+2,wy+2,ww-4,wh-4,1)
        
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
    w.dur=dur
    
end

function rectfill2(_x,_y,_w,_h,_clr)
    rectfill(_x,_y,_x+_w-1,_y+_h-1,_clr)
end
-->8
--powerups

function break_pot()
    if trigscore then
    mget(player.x,player.y)
    mset(player.x,player.y,88)
    end
end