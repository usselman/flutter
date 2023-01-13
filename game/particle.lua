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
    if rnd()>0.4 then
        local _angle = rnd()
        local _dx = sin(_angle)*(player.w/8)*0.1
        local _dy = cos(_angle)*(player.h/8)*0.1

        add_particles(_x+_dx+player.w/4,_y+_dy+6,0,3+rnd(3),{rnd(15),6,5,0})

        --add_particles(_x-player.w/4,_y+player.h/2,0,6+rnd(5))
    end
end

function spawncircle(_x,_y)
    if rnd()>0.3 then
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
        
    end
    
end

function draw_particles()
    for i=1,#particle do
        _p=particle[i]

        --pixel particle
        if _p.t==0 then
           pset(_p.x,_p.y,_p.col)
           pset(_p.x,_p.y+rnd(player.h/4),_p.col)
           --pset(_p.x,_p.y+rnd(player.h/2),5)  
           pset(_p.x,_p.y-rnd(player.h/4),_p.col)
           --pset(_p.x,_p.y-rnd(player.h/2),7)
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
    end

end