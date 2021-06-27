
local RPD = require "scripts/lib/commonClasses"
local RS = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local hero=RPD.Dungeon.hero
local BulNow=BulNow
local missCh
local maxBul=8
local maxDmg=8
local minDmg=6
local bul="9x18mm"
local P="Guns/PMP.oga"
local V="Guns/PMV.oga"
local weapon = "pm"
local item = require "scripts/lib/item"
return item.init {
    desc  = function (self, item)
if BulNow == nil then
BulNow=0
end
        return {
            image         = 0,
            imageFile     = "items/weapon.png",
            name          = "ПМм",
            info          = "Наиболее распространённый в Зоне пистолет — наследие советской эпохи. Достаточно надёжен и дешёв, но отличается невысокой ёмкостью магазина при недостаточной мощности и неудовлетворительной кучности патрона. Основное оружие сталкера-новичка.",
            defaultAction = "ВЫСТРЕЛИТЬ",
            price         = 200,
            upgradable = true,
            equipable     = "weapon"
        }
    end,
  
activate = function(self, item, hero)
   
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
if BulNow ~= 0 then
RPD.glog("++ Вы перезарядились. В магазине "..BulNow.."/"..maxBul.."патронов")
end
if item:getUser():getBelongings():getItem(bul) == nil then
RPD.glog("-- В рюкзаке закончились боеприпасы")
end
RPD.playSound(P)
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
RPD.playSound(P)
if BulNow~=0 then
RPD.glog("++ Вы перезарядились. В магазине "..BulNow.."/"..maxBul.."патронов")
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
 BulNow = BulNow-1
 pos = RPD.Ballistica:cast(thisItem  :getUser():getPos(),cell,true,true,true)
 missCh=RS.missChanse(pos)
 RS.shoot(cell,thisItem,minDmg,maxDmg,missCh,V)
 end
 storage.gamePut(weapon,{bullets = BulNow})
        end
}
