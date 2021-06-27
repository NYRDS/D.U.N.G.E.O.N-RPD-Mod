
local RPD = require "scripts/lib/commonClasses"

local item = require "scripts/lib/item"

return item.init{
    desc  = function (self, item)
        return {
            image         = 1,
            imageFile     = "items/GunAmmo.png",
            name          = "Патроны 5,45x39 мм ",
            info          = "Стандартный патрон для автоматов Aкм-74/2, Акм-74/2У, Обокан. Простой сердечник, оболочечная пуля.",
            price         = 2,
            stackable     = true
        }
    end,

    activate = function(self, item, hero)
    end,

    deactivate = function(self, item, hero)
    end
}
