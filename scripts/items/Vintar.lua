
local RPD = require "scripts/lib/commonClasses"
local RS = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local hero=RPD.Dungeon.hero
local level=RPD.Dungeon.level
local missCh
local BulNow=BulNow
local mode=false
local maxBul=5
local maxDmg=14
local minDmg=9
local bul="9x39mmSP5"
local P="Guns/MP5P.oga"
local V="Guns/MP5V.oga"
local weapon = "vintar"
local item = require "scripts/lib/item"
return item.init {
    desc  = function (self, item)
if BulNow == nil then
BulNow=0
end
        return {
            image         = 4,
            imageFile     = "items/weapon.png",
            name          = "Винтарь-ВС",
            info          = "«Винтовка снайперская специальная», предназначена для бесшумной и беспламенной снайперской стрельбы и снабжена интегрированным глушителем. С расстояния 400 метров пробивает бронежилет любой степени защиты. Очень ценимое сталкерами любого уровня оружие.",
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
hero:spend(2)
if BulNow~=0 then
RPD.glog("++ Вы перезарядились. В магазине "..BulNow.."/"..maxBul.."патронов")
RPD.playSound(P)
end
if item:getUser():getBelongings():getItem(bul) == nil then
RPD.glog("-- В рюкзаке нет боеприпасов")
end
end
storage.gamePut(weapon,{bullets = BulNow})
end,

cellSelected = function(self, thisItem, action, cell)
local hero=RPD.Dungeon.hero
 local Weapon = storage.gameGet(weapon) or {}
 if action == "ВЫСТРЕЛИТЬ" and cell ~= nil then
 BulNow=BulNow-1
    thisItem:getUser():getSprite():zap(cell)
   pos = RPD.Ballistica:cast(thisItem  :getUser():getPos(),cell,true,true,true)
   local enemy = RPD.Actor:findChar(pos)
   missCh=RS.missChanse(pos)
   local maxCh=hero:attackSkill()
  RPD.zapEffect(thisItem:getUser():getPos(),pos,"CommonArrow")
  RPD.playSound(V)
  thisItem:getUser():spend(1)
  if enemy and enemy~= RPD.Dungeon.hero then
  if math.random(0,maxCh)>=missCh/2 then
    enemy:damage(math.random((minDmg+3*thisItem:level()+3*RS.distance(pos))-enemy:dr(),(maxDmg+3*thisItem:level()+3*RS.distance(pos))-enemy:dr()), thisItem:getUser())
    else
    enemy:getSprite():showStatus(0xffff00,"промах")
    end
    end
 end
 storage.gamePut(weapon,{bullets = BulNow})
 end
}
