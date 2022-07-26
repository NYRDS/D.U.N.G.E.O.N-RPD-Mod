local RPD = require "scripts/lib/commonClasses"
local Music = luajava.bindClass("com.watabou.noosa.audio.Music")
local FloatingText = luajava.bindClass("com.watabou.pixeldungeon.effects.SystemFloatingText")
local ColorMath = luajava.bindClass("com.watabou.utils.ColorMath")
local Belongings = luajava.bindClass("com.watabou.pixeldungeon.actors.hero.Belongings")

local RS = {
    SwordLightInt = SwordLightInt,
    shoot = function(cell, item, minDmg, maxDmg, missCh, V)
        RPD.Dungeon.hero:getSprite():zap(cell)
        pos = RPD.Ballistica:cast(RPD.Dungeon.hero:getPos(), cell, true, true, false)
        local enemy = RPD.Actor:findChar(pos)
        local maxCh = RPD.Dungeon.hero:attackSkill()
        RPD.zapEffect(RPD.Dungeon.hero:getPos(), pos, "CommonArrow")
        RPD.Dungeon.hero:spend(1)
        if enemy and enemy ~= RPD.Dungeon.hero then
            if math.random(0, maxCh) >= missCh then
                enemy:damage(math.random(minDmg + (3 * item:level()) - enemy:dr(), maxDmg + (3 * item:level()) - enemy:dr()), RPD.Dungeon.hero)
            else
                enemy:getSprite():showStatus(0xffff00, "промах")
            end
            RPD.playSound(V)
        else
            RPD.playSound(V)
        end
    end,

    distance = function(pos)
        local y
        local x
        local level = RPD.Dungeon.level
        local hx = level:cellX(RPD.Dungeon.hero:getPos())
        local hy = level:cellY(RPD.Dungeon.hero:getPos())
        local ex = level:cellX(pos)
        local ey = level:cellY(pos)
        if ex > hx then
            x = ex - hx
        else
            x = hx - ex
        end
        if ey > hy then
            y = ey - hy
        else
            y = hy - ey
        end
        return math.max(x, y) - 1
    end,

    missChanse = function(pos)
        local missCh = 0
        local y
        local x
        local level = RPD.Dungeon.level
        local hx = level:cellX(RPD.Dungeon.hero:getPos())
        local hy = level:cellY(RPD.Dungeon.hero:getPos())
        local ex = level:cellX(pos)
        local ey = level:cellY(pos)
        if ex > hx then
            x = ex - hx
        else
            x = hx - ex
        end
        if ey > hy then
            y = ey - hy
        else
            y = hy - ey
        end
        local enemy = RPD.Actor:findChar(pos)
        if enemy then
            missCh = enemy:defenseSkill()
        end
        if y <= 2 and x == hx then
            missCh = 0
        elseif y == hy and x <= 2 then
            missCh = 0
        elseif y <= 2 and x <= 2 then
            missCh = 0
        end
        return missCh
    end,

    color = function(a, b, p)
        ColorMath:interpolate(a, b, p)
    end,
    show = function(x, y, key, text, color)
        FloatingText:show(x, y, key, text, color)
    end,
    playMusic = function(music, looped)
        Music.INSTANCE:play(music, looped)
    end,

    mute = function()
        Music.INSTANCE:mute()
    end,

    volume = function(value)
        Music.INSTANCE:volume(value)
    end,

    pause = function()
        Music.INSTANCE:pause()
    end,

    resume = function()
        Music.INSTANCE:resume()
    end,

    spawnMob = function(mob, pos, thisIsAPet)
        local maybeMob = RPD.MobFactory:mobByName(mob)
        maybeMob:setPos(pos)
        if thisIsAPet then
            RPD.Dungeon.level:spawnMob(RPD.Mob:makePet(maybeMob, RPD.Dungeon.hero));
        else
            RPD.Dungeon.level:spawnMob(maybeMob)
        end
    end
}
return RS