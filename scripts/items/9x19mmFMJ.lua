
local RPD = require "scripts/lib/commonClasses"

local item = require "scripts/lib/item"

return item.init{
    desc  = function (self, item)
        return {
            image         = 3,
            imageFile     = "items/GunAmmo.png",
            name          = "Патроны 9х19 мм FMJ",
            info          = "Базовый патрон для пистолета Волкер Р9м и пистолета-пулемета Гадюка 5. Оболочечная пуля. Слабое бронебойное действие.",
            price         = 1.3,
            stackable     = true
        }
    end,

    activate = function(self, item, hero)
    end,

    deactivate = function(self, item, hero)
    end
}
