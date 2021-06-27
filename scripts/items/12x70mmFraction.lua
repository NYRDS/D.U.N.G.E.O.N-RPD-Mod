
local RPD = require "scripts/lib/commonClasses"

local item = require "scripts/lib/item"

return item.init{
    desc  = function (self, item)
        return {
            image         = 2,
            imageFile     = "items/GunAmmo.png",
            name          = "Патроны 12x70 мм Дробь",
            info          = "Обычный патрон 12-го калибра, снаряжённый 6-мм дробью. На близких дистанциях обладает огромным убойным действием. Предназначен для дробовиков ТоСТ 34, ВМ 17, «Чейзер 13», СПСА14. Наиболее эффективен на дальностях до 30 метров.",
            price         = 2 ,
            stackable     = true
        }
    end,

    activate = function(self, item, hero)
    end,

    deactivate = function(self, item, hero)
    end
}
