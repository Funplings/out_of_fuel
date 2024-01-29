import "weapons/bullet"
import "util"
import "weaponDisplay"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Weapon').extends()

CURRENT_WEAPON = nil

function setWeapon(current_weapon)
    CURRENT_WEAPON = current_weapon
    updateWeaponDisplay()
end

function Weapon:init(player)
    self.player = player
end

function updateWeapon()
    if (pd.buttonJustPressed(pd.kButtonA)) then
        CURRENT_WEAPON:buttonJustPressed()
    elseif (pd.buttonIsPressed(pd.kButtonA)) then
        CURRENT_WEAPON:buttonIsPressed()
    elseif (pd.buttonJustReleased(pd.kButtonA)) then
        CURRENT_WEAPON:buttonJustReleased()
    end
end