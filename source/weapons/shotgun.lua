import "util"
import "weapons/weapon"
import "weapons/bullet"
import "player"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Shotgun').extends(Weapon)

function Shotgun:init(player)
    -- super init
    Weapon:init(player)

    -- set constants
    self.reloadTime = 250
    self.bulletSpeed = 12
    self.bulletLifetime = 200
    self.bulletDamage = 40
    self.recoilVelocity = 10
    self.bulletCount = 8

    self.bulletAngleRange = 20
    self.bulletSpeedRange = 5

    -- set variables
    self.reloading = false
end

function Shotgun:buttonJustPressed()
     -- local reload function
     local function reload()
        self.reloading = false
    end

    -- if not reloading, shoot bullets
    if not self.reloading then
        -- create bullets
        local crankAngle = pd.getCrankPosition()
        local moveDirection = math.rad(crankAngle) + math.pi/2
        x, y = self.player:getPosition()
        for _ = 1, self.bulletCount do
            local bulletAngle = crankAngle + math.random(-self.bulletAngleRange, self.bulletAngleRange)
            local bulletSpeed = self.bulletSpeed + math.random(-self.bulletSpeedRange, self.bulletSpeedRange)
            Bullet(x, y, bulletAngle, bulletSpeed, self.bulletDamage, self.bulletLifetime)
        end

        -- set reloading to true, initiate reload process
        self.reloading = true
        pd.timer.performAfterDelay(self.reloadTime, reload)

        -- add recoil to player
        self.player:addVelocity(
            getXComponent(self.recoilVelocity, moveDirection),
            getYComponent(self.recoilVelocity, moveDirection)
        )
    end

end

function Shotgun:buttonIsPressed()
end

function Shotgun:buttonJustReleased()
end

function Shotgun:getName()
    return "Shotgun"
end