local pd <const> = playdate
local gfx <const> = pd.graphics

import "weapons/machineGun"
import "weapons/shotgun"
import "weapons/revolver"

class('WeaponBox').extends(gfx.sprite)

local weaponArray = { MachineGun, Shotgun, Revolver }

function WeaponBox:init(minX, maxX, minY, maxY)
    -- graphics
    self:setImage(gfx.image.new("images/weapon_box"))
    self:add()

    -- set constants
    self.x = math.random(minX, maxX)
    self.y = math.random(minY, maxY)
    self.minX, self.maxX = minX, maxX
    self.minY, self.maxY = minY, maxY

    -- set random weapon
    self.weapon = weaponArray[math.random(1, #weaponArray)]

    -- move to starting position
    self:moveTo(self.x, self.y)

end


function WeaponBox:update()
    -- create collider
    self:setCollideRect(0, 0, self:getSize())
end

function WeaponBox:collisionResponse()
    return "overlap"
end

function WeaponBox:SpawnNewWeaponBox()
    WeaponBox(self.minX, self.maxX, self.minY, self.maxY)
    self:remove()
end