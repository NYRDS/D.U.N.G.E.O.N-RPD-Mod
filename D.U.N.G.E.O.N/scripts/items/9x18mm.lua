
local RPD = require "scripts/lib/commonClasses"

local item = require "scripts/lib/item"

return item.init{
    desc  = function (self, item)
        return {
            image         = 0,
            imageFile     = "items/GunAmmo.png",
            name          = "Патроны 9x18 мм",
            info          = "Базовый патрон для пистолетов ПМм, ПБ-1с, «Фора-12Мк2». Простой сердечник, оболочечная пуля. Слабое бронебойное действие.",
            price         =1 ,
            stackable     = true
        }
    end,

    activate = function(self, item, hero)
    end,

    deactivate = function(self, item, hero)
    end
}
