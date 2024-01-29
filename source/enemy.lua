import "util"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(gfx.sprite)

function Enemy:init(startingX, startingY, maxHealth, image)
    -- set sprite
    self:setImage(gfx.image.new(image))
    self:add()

    -- set health
    self.health = maxHealth

    -- move to starting position
    self:moveTo(startingX, startingY)

    -- create collider
    self:setCollideRect(0, 0, self:getSize())
end

function Enemy:takeDamage(damage)
    self.health -= damage
    if self.health <= 0 then
        self:remove()
    end
end

function Enemy:collisionResponse()
    return "overlap"
end


