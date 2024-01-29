import "util"
import "weapons/weapon"
import "weapons/bullet"
import "player"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Revolver').extends(Weapon)

function Revolver:init(player)
    -- super init
    Weapon:init(player)

    -- set constants
    self.reloadTime = 0
    self.bulletSpeed = 18
    self.bulletLifetime = 4000
    self.bulletDamage = 100
    self.recoilVelocity = 8
end

function Revolver:buttonJustPressed()
    -- create bullet
    local crankAngle = pd.getCrankPosition()
    local moveDirection = math.rad(crankAngle) + math.pi/2
    x, y = self.player:getPosition()
    Bullet(x, y, crankAngle, self.bulletSpeed, self.bulletDamage, self.bulletLifetime)

    -- add recoil to player
    self.player:addVelocity(
        getXComponent(self.recoilVelocity, moveDirection),
        getYComponent(self.recoilVelocity, moveDirection)
    )
end

function Revolver:buttonIsPressed()
end

function Revolver:buttonJustReleased()
end

function Revolver:getName()
    return "Revolver"
end