local pd <const> = playdate
local gfx <const> = pd.graphics

import "weapons/weapon"

local weaponDisplaySprite

function createWeaponDisplay()
    weaponDisplaySprite = gfx.sprite.new()
    updateScoreDisplay()
    weaponDisplaySprite:setCenter(0, 0)
    weaponDisplaySprite:moveTo(20, 4)
    weaponDisplaySprite:add()
end

function updateWeaponDisplay()
    local weaponDisplayText = CURRENT_WEAPON:getName()
    local textWidth, textHeight = gfx.getTextSize(weaponDisplayText)
    local weaponDisplayImage = gfx.image.new(textWidth, textHeight)
    gfx.pushContext(weaponDisplayImage)
        gfx.drawText(weaponDisplayText, 0, 0)
    gfx.popContext()
    weaponDisplaySprite:setImage(weaponDisplayImage)
end