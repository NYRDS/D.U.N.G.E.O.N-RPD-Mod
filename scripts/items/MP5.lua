
local RPD = require "scripts/lib/commonClasses"
local RS = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local hero=RPD.Dungeon.hero
local level=RPD.Dungeon.level
local missCh
local BulNow=BulNow
local mode=false
local maxBul=30
local maxDmg=10
local minDmg=6
local bul="9x19mmFMJ"
local P="Guns/MP5P.oga"
local V="Guns/MP5V.oga"
local weapon = "mp5"
local item = require "scripts/lib/item"
return item.init {
    desc  = function (self, item)
if BulNow == nil then
BulNow=0
end
        return {
            image         = 1,
            imageFile     = "items/weapon.png",
            name          = "Гадюка-5",
            info          = "Одно из самых лучших в классе пистолетов-пулемётов оружие. В течение последних десятилетий XX века был принят на вооружение спецподразделений армии и полиции во многих странах мира. С началом постепенной его замены более современными моделями стал часто появляться на чёрном рынке, откуда массово попал и в Зону.",
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
storage.gamePut(weapon,{bullets = BulNow})
end,

cellSelected = function(self, thisItem, action, cell)
local hero=RPD.Dungeon.hero
 local Weapon = storage.gameGet(weapon) or {}
 if action == "ВЫСТРЕЛИТЬ" and cell ~= nil then
    thisItem:getUser():getSprite():zap(cell)
   pos = RPD.Ballistica:cast(thisItem  :getUser():getPos(),cell,true,true,true)
   local enemy = RPD.Actor:findChar(pos)
   missCh=RS.missChanse(pos)
   local maxCh=hero:attackSkill()
  RPD.zapEffect(thisItem:getUser():getPos(),pos,"FireArrow")
  RPD.playSound(V)
  RPD.playSound(V)
 for i=0,4 do
  thisItem:getUser():spend(0.2)
  if enemy and enemy~= RPD.Dungeon.hero then
  if BulNow ~= 0 then
  if math.random(0,maxCh)>=missCh*1.2 then
    enemy:damage(math.random(minDmg+(3*thisItem:level())-enemy:dr(),maxDmg+(3*thisItem:level())-enemy:dr()), thisItem:getUser())
    else
    enemy:getSprite():showStatus(0xffff00,"промах")
    end
    BulNow=BulNow-1
    else
    RPD.glog("-- В магазине нет патронов")
    end
 else
 if BulNow ~= 0 then
 BulNow=BulNow-1
 else
 RPD.glog("-- В магазине нет патронов")
 end
 end
 end
 storage.gamePut(weapon,{bullets = BulNow})
 end
 end
}
