import "util"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Bullet').extends(gfx.sprite)

function Bullet:init(startingX, startingY, directionInDegrees, velocity, damage, lifetime)
    -- graphics
    self:setImage(gfx.image.new("images/bullet"))
    self:add()

    -- move to starting position
    self:moveTo(startingX, startingY)

    -- set direction and velocity
    self.direction = math.rad(directionInDegrees) - math.pi/2
    self.velocity = velocity

    -- set damage
    self.damage = damage

    -- create collider
    self:setCollideRect(0, 0, self:getSize())

    -- set lifetime
    pd.timer.performAfterDelay(lifetime, function()
        self:remove()
    end)
end


function Bullet:update()
    -- move in direction at velocity
    local x, y = self:getPosition()
    local actualX, actualY, collisions, length = self:moveWithCollisions(
        x + getXComponent(self.velocity, self.direction),
        y + getYComponent(self.velocity, self.direction)
    )

    -- destroy enemy on collision
    if length > 0 then
        for index, collision in pairs(collisions) do
            local collidedObject = collision['other']
            if collidedObject:isa(Enemy) then
                collidedObject:takeDamage(self.damage)
                self:remove()
            end
        end
    end
end

function Bullet:collisionResponse()
    return "overlap"
end