--particle--

function particle_update(x,y,num)
    particle.x=x-5
    particle.y=y+5
    particle.sp=num
    
end

function enemy_particle_update(x,y,num)

    enemy_particle.x=x+8
    enemy_particle.y=y
    enemy_particle.sp=num
    if flr(time())%2 then
        enemy_particle.sp=22
    end
end

function add_particles(_x,_y,_type,_dur,_col)
    local _p={}
    _p.x=_x
    _p.y=_y
    _p.t=_type
    _p.d=_dur
    _p.age=0
    _p.col=0
    _p.colarray=_col
    --_p.oldcol=_oldcol 
    add(particle,_p)
    
end

function spawntrail(_x,_y)
    --1/2 chance
    if rnd()>0 then
        local _angle = rnd()
        local _dx = sin(_angle)*0.2
        local _dy = cos(_angle)*(player.h/6)
        spawn_gem_effect(_x + player.w/4, _y + 6)
        add_particles(_x+_dx+player.w/4,_y+_dy+6,0,4+rnd(3),{rnd(15),6,5,0})

        --add_particles(_x-player.w/4,_y+player.h/2,0,6+rnd(5))
    end
end

function spawncircle(_x,_y)
    if rnd()>0.1 then
        local _angle = rnd()
        local _dx = sin(_angle)*0.6
        local _dy = cos(_angle)*0.6
        add_particles(_x+4+_dx,_y+4+_dy,1,rnd(5),{9,6,5,1})
    end
end

function spawndust(_x,_y)
    if rnd()>0.5 then
        local _angle=rnd()
        local _dx=sin(_angle)*0.8
        local _dy=cos(angle)*0.8
        
        add_particles(_x-_dx+6,_y-_dy+4,2,rnd(3),{6,5,1})
    end   
end

function deathtrail(_x,_y)
        local _angle = rnd()
        local _dx = sin(_angle)*0.1
        local _dy = cos(_angle)*0.1
        add_particles(_x+_dx+player.w/4,_y+_dy+6,3,8+rnd(12),{7,6,5,0})
        --spr(21,_p.x-3,_p.y-player.h/2)
end

function spawn_gem_effect(_x, _y)
    local colors = {13, 14, 15}  -- Define colors for the circles
    for i=1,#colors do
        add_particles(_x, _y, 5, i, {colors[i]})
    end
end


function diamondtext(_x,_y) 
    
    add_particles(_x+player.w/4,_y+6,4,5,{12,6,5,0})
    spawn_gem_effect(_x + player.w/4, _y + 6)

end

function update_particles()
    local _p
    for i=#particle,1,-1 do
        _p=particle[i]
        _p.age+=0.25

        --delete when old
        if _p.age>_p.d then
            del(particle,particle[i])
        else
            if #_p.colarray==1 then
                _p.col=_p.colarray[1] 
            else
                --color index
                local _ci = _p.age/_p.d 
                --which color in the array corresponds to our age
                _ci=1+flr(_ci * #_p.colarray)
                _p.col = _p.colarray[_ci]
            end 
            
        end
        -- circles
        if _p.t == 5 then
            -- Increase the radius of the circles over time
            --_p.d += 0.75
            _p.d += 0.5
            -- Decrease the alpha over time to create a fading effect
            _p.col = _p.colarray[1] - flr(_p.age)
            -- Delete the particle if it is faded completely
            if _p.col <= 0 then
                del(particle, particle[i])
            end
        end
        
    end
    
end

function draw_particles()
    for i=1,#particle do
        _p=particle[i]

        --pixel particle
        if _p.t==0 then
           pset(_p.x,_p.y,_p.col)
           pset(_p.x,_p.y+rnd(player.h/8),_p.col) 
           pset(_p.x,_p.y-rnd(player.h/8),_p.col)
        end
        if _p.t==1 then
            --enemy particle
            circfill(_p.x,_p.y,rnd(2),_p.col)
            pset(_p.x,_p.y,_p.col)
        end
        if _p.t==2 then
            circfill(_p.x,_p.y+player.h,rnd(1),_p.col)
            --spr(26,_p.x,_p.y, 1,1)
        
        end
        --death trail--
        if _p.t==3 then
            
            --circfill(_p.x,_p.y,2,_p.col)
            pset(_p.x,_p.y,_p.col)
            pset(_p.x+1,_p.y+rnd(player.h/2),_p.col) 
            pset(_p.x-1,_p.y+rnd(player.h/2),_p.col)
            --pset(_p.x,_p.y,_p.col)
            -- spr(21,_p.x-player.w/4,_p.y-player.h/4)
        end
        --powerup--
        if _p.t==4 then 
            print("+100!",_p.x,_p.y-12,_p.col)
        end
        if _p.t == 5 then
            -- Use circfill to draw the circles with the current radius and color
            -- circ(_p.x, _p.y, _p.d, _p.col)
            pset(_p.x - 3, _p.y, _p.d, _p.col)
        end
    end

end