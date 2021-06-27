
local RPD = require "scripts/lib/commonClasses"

local item = require "scripts/lib/item"

return item.init{
    desc  = function (self, item)
        return {
            image         =4,
            imageFile     = "items/GunAmmo.png",
            name          = "Патроны 9x39 мм СП-5",
            info          = "Снайперский патрон для автоматов Гром, Спецавтомата ВЛА и специальной снайперской винтовки Винтарь-ВС. Имеет дозвуковую скорость полета, но за счёт тяжёлой пули особой конструкции пробивает большинство бронежилетов на дальностях до 400 метров.",
            price         = 3,
            stackable     = true
        }
    end,

    activate = function(self, item, hero)
    end,

    deactivate = function(self, item, hero)
    end
}
