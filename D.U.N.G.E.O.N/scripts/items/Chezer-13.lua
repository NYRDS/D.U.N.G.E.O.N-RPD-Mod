
local RPD = require "scripts/lib/commonClasses"
local RS = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local hero=RPD.Dungeon.hero
local BulNow=BulNow
local x
local y
local hx
local hy
local ex
local ey
local cell2
local cell3
local missCh
local missCh2
local missCh3
local dmgCof
local maxBul=6
local maxDmg=16
local minDmg=8
local bul="12x70mmFraction"
local P="Guns/ChezerP.oga"
local V="Guns/ChezerV.oga"
local weapon = "chezer-13"
local item = require "scripts/lib/item"
return item.init {
    desc  = function (self, item)
if BulNow == nil then
BulNow=0
end
        return {
            image         = 5,
            imageFile     = "items/weapon.png",
            name          = "Чейзер-13",
            info          = "Гладкоствольное помповое ружьё американского производства, созданное для применения в самых неблагоприятных условиях и отличающееся высокой надёжностью. Все детали снабжены антикоррозийным покрытием.",
            defaultAction = "ВЫСТРЕЛИТЬ",
            price         = 200,
            upgradable = true,
            equipable     = "weapon"
        }
    end,
  
activate = function(self, item, hero)
 
    end,
    
    blockSlot = function(self, item, hero)
     return "LEFT_HAND"
    end,
    
deactivate = function(self, item, hero)
 end,
 
actions = function(self, item, hero)
local Weapon = storage.gameGet(weapon) or {}
if Weapon.bullets ~= nil then
  BulNow = Weapon.bullets
 end
if item:isEquipped(RPD.Dungeon.hero) then
return {"ВЫСТРЕЛИТЬ","ПЕРЕЗАРЯДИТЬСЯ("..tostring(BulNow).."/"..tostring(maxBul)..")"}
else
return {}
end
end,

execute = function(self, item, hero, action)
local Weapon = storage.gameGet(weapon) or {}
if Weapon.bullets ~= nil then
  BulNow = Weapon.bullets
 end
        if action == "ВЫСТРЕЛИТЬ" then
        if BulNow ~=0 then
            item:selectCell( "ВЫСТРЕЛИТЬ" , "Выберете клетку")
            else
while item:getUser():getBelongings():getItem(bul) ~= nil and BulNow < maxBul do
        item:getUser():getSprite():operate()
    item:getUser():getBelongings()
:getItem(bul):detach(item:getUser():getBelongings()
.backpack)
BulNow=BulNow+1
end
hero:spend(1)
if BulNow ~= 0 then
RPD.glog("++ Вы перезарядились. В магазине "..BulNow.."/"..maxBul.."патронов")
RPD.playSound(P)
end
if item:getUser():getBelongings():getItem(bul) == nil then
RPD.glog("-- В рюкзаке закончились боеприпасы")
end
end
end


if action == "ПЕРЕЗАРЯДИТЬСЯ("..BulNow.."/"..maxBul..")" then
       while item:getUser():getBelongings():getItem(bul) ~= nil and BulNow < maxBul do
        item:getUser():getSprite():operate()
    item:getUser():getBelongings()
:getItem(bul):detach(item:getUser():getBelongings()
.backpack)
BulNow=BulNow+1
end
hero:spend(1)
if BulNow~=0 then
RPD.glog("++ Вы перезарядились. В магазине "..BulNow.."/"..maxBul.."патронов")
RPD.playSound(P)
end
if item:getUser():getBelongings():getItem(bul) == nil then
RPD.glog("-- В рюкзаке нет боеприпасов")
end
end
storage.gamePut(weapon, {bullets = BulNow})
end,

cellSelected = function(self, thisItem, action, cell)
local hero=RPD.Dungeon.hero
local Weapon = storage.gameGet(weapon) or {}
 if action == "ВЫСТРЕЛИТЬ" and cell ~= nil then
    thisItem:getUser():getSprite():zap(cell)
   pos = RPD.Ballistica:cast(thisItem  :getUser():getPos(),cell,true,true,true)
   local enemy = RPD.Actor:findChar(pos)
   local hero=RPD.Dungeon.hero
   local level= RPD.Dungeon.level
 hx = level:cellX(hero:getPos())
 hy = level:cellY(hero:getPos())
 if enemy~=RPD.Dungeon.hero then
 ex = level:cellX(pos)
 ey = level:cellY(pos)
 else
 ex=level:cellX(cell)
 ey=level:cellY(cell)
 end
 if hx>ex then
 x=hx-ex
 else
 x=ex-hx
 end
 if hy>ey then
 y=hy-ey
 else
 y=ey-hy
 end
 if x>y then
 dmgCof=x
 if ey+1<=level:getWidth() then
 cell2=level:cell(ex,ey+1)
 end
 if ey-1>=0 then
 cell3=level:cell(ex,ey-1)
 end
 else
 dmgCof=y
 if ex+1<=level:getHeight() then
 cell2=level:cell(ex+1,ey)
 end
 if ex-1>=0 then
 cell3=level:cell(ex-1,ey)
 end
 end
 pos2 = RPD.Ballistica:cast(thisItem  :getUser():getPos(),cell2,true,true,true)
 local enemy2 = RPD.Actor:findChar(pos2)
 pos3 = RPD.Ballistica:cast(thisItem  :getUser():getPos(),cell3,true,true,true)
 local enemy3 = RPD.Actor:findChar(pos3)
 missCh= RS.missChanse(pos)
 missCh2= RS.missChanse(pos2)
 missCh3= RS.missChanse(pos3)
   local maxCh=hero:attackSkill()
   RPD.zapEffect(thisItem:getUser():getPos(),pos,"PoisonArrow")
   RPD.zapEffect(thisItem:getUser():getPos(),pos2,"PoisonArrow")
   RPD.zapEffect(thisItem:getUser():getPos(),pos3,"PoisonArrow")
   RPD.playSound(V)
  thisItem:getUser():spend(1)
  BulNow=BulNow-1
  if enemy and enemy~= RPD.Dungeon.hero then
  if math.random(0,maxCh)>=missCh then
    enemy:damage(math.random((minDmg+(3*thisItem:level())-enemy:dr()/1.5)/dmgCof,(maxDmg+(3*thisItem:level())-enemy:dr()/1.5)/dmgCof), thisItem:getUser())
    else
    enemy:getSprite():showStatus(0xffff00,"промах")
    end
 end
 
 if enemy2 and enemy2~= RPD.Dungeon.hero then
  if math.random(0,maxCh)>=missCh2 then
    enemy2:damage(math.random((minDmg+(3*thisItem:level())-enemy2:dr())/dmgCof,(maxDmg+(3*thisItem:level())-enemy2:dr())/dmgCof), thisItem:getUser())
    else
    enemy2:getSprite():showStatus(0xffff00,"промах")
    end
 end
 
 if enemy3 and enemy3~= RPD.Dungeon.hero then
  if math.random(0,maxCh)>=missCh3 then
    enemy3:damage(math.random((minDmg+(3*thisItem:level())-enemy3:dr())/dmgCof,(maxDmg+(3*thisItem:level())-enemy3:dr())/dmgCof), thisItem:getUser())
    else
    enemy3:getSprite():showStatus(0xffff00,"промах")
    end
 end
 storage.gamePut(weapon, {bullets = BulNow})
 end
        end
}
