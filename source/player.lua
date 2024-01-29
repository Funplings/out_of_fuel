import "weapons/bullet"
import "weapons/machineGun"
import "weapons/shotgun"
import "weapons/revolver"
import "weapons/weapon"
import "util"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Player').extends(gfx.sprite)

function Player:init(startingX, startingY, gameScene)
    -- graphics
    self:setImage(gfx.image.new("images/player"))
    self:add()

    -- move to starting position
    self:moveTo(startingX, startingY)

    -- set variables
    setWeapon(Revolver(self))
    self.xMoveVelocity = 0
    self.yMoveVelocity = 0
    self.moveDecay = 0.9
    self.gameScene = gameScene

    -- create collider
    self:setCollideRect(0, 0, 10, 10)

end


function Player:update()
    -- point at crankAngle
    local crankAngle = pd.getCrankPosition()
    self:setRotation(crankAngle)

    -- move in move direction, slow down
    local x, y = self:getPosition()
    local actualX, actualY, collisions, length = self:moveWithCollisions(
        x + self.xMoveVelocity,
        y + self.yMoveVelocity
    )

    -- collision
    if length > 0 then
        for index, collision in pairs(collisions) do
            local collidedObject = collision['other']
            -- collide with enemy
            if collidedObject:isa(Enemy) then
                self.gameScene:playerDeath()
                self:remove()
            -- collide with weapon box
            elseif collidedObject:isa(WeaponBox) then
                setWeapon(collidedObject.weapon(self))
                collidedObject:SpawnNewWeaponBox()
                GAME_MANAGER:incrementScore()
            end
        end
    end

    self.xMoveVelocity *= self.moveDecay
    self.yMoveVelocity *= self.moveDecay

    -- bounce off horizontal walls
    x, y = self:getPosition()
    if x < 0 then
        self:moveTo(0, y)
        self.xMoveVelocity = -self.xMoveVelocity
    elseif x > 400 then
        self:moveTo(400, y)
        self.xMoveVelocity = -self.xMoveVelocity
    end

    -- bounce off vertical walls
    if y < 0 then
        self:moveTo(x, 0)
        self.yMoveVelocity = -self.yMoveVelocity
    elseif y >= 240 then
        self:moveTo(x, 240)
        self.yMoveVelocity = -self.yMoveVelocity
    end
end

function Player:addVelocity(xVelocity, yVelocity)
    self.xMoveVelocity += xVelocity
    self.yMoveVelocity += yVelocity
end

function Player:collisionResponse()
    return "overlap"
end
