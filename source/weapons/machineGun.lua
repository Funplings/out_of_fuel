import "util"
import "weapons/weapon"
import "weapons/bullet"
import "player"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('MachineGun').extends(Weapon)

function MachineGun:init(player)
    -- super init
    Weapon:init(player)

    -- set constants
    self.reloadTime = 50
    self.bulletSpeed = 8
    self.bulletLifetime = 4000
    self.bulletDamage = 40
    self.recoilVelocity = 2.5
    self.bulletAngleRange = 5
    -- set variables
    self.reloading = false
end

function MachineGun:buttonJustPressed()
end

function MachineGun:buttonIsPressed()
    -- local reload function
    local function reload()
        self.reloading = false
    end
    
    -- if A is pressed and not reloading, shoot bullet
    if pd.buttonIsPressed(pd.kButtonA) and not self.reloading then
        -- create bullet
        local crankAngle = pd.getCrankPosition()
        local moveDirection = math.rad(crankAngle) + math.pi/2

        x, y = self.player:getPosition()
        local bulletAngle = crankAngle + math.random(-self.bulletAngleRange, self.bulletAngleRange)
        Bullet(x, y, bulletAngle, self.bulletSpeed, self.bulletDamage, self.bulletLifetime)

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

function MachineGun:buttonJustReleased()
end

function MachineGun:getName()
    return "Machine Gun"
end