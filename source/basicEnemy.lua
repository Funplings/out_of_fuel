import "util"
import "enemy"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('BasicEnemy').extends('Enemy')

TIME_TO_MOVE = "0"
IN_PROGRESS = "1"
TIME_TO_STOP = "2"

function BasicEnemy:init(startingX, startingY)
    -- super init
    Enemy.init(self, startingX, startingY, 100, "images/goblin")

    -- fields
    self.moving = false
    self.speed = 2
    self.minMoveTime = 1000
    self.maxMoveTime = 2000
    self.minWaitTime = 1000
    self.maxWaitTime = 2000
    self.moveDirection = 0
    self.moveState = TIME_TO_MOVE
    self.health = 100
end

function BasicEnemy:update()
    local function stop()
        self.moveState = TIME_TO_STOP
    end

    local function start()
        self.moveState = TIME_TO_MOVE
    end

    if self.moving then
        self:moveBy(getXComponent(self.speed, self.moveDirection), getYComponent(self.speed, self.moveDirection))
    elseif self.needsToStart then
        start()
    end

    if self.moveState == TIME_TO_MOVE then
        self.moving = true
        self.moveDirection = math.rad(math.random(0, 359))
        local moveTime = self.minMoveTime + math.random() * (self.maxMoveTime - self.minMoveTime)
        self.moveState = IN_PROGRESS
        pd.timer.performAfterDelay(moveTime, stop)
    elseif self.moveState == TIME_TO_STOP then
        self.moving = false
        local waitTime = self.minWaitTime + math.random() * (self.maxWaitTime - self.minWaitTime)
        self.moveState = IN_PROGRESS
        pd.timer.performAfterDelay(waitTime, start)
    end

    -- bounce off horizontal walls
    x, y = self:getPosition()
    if x < 0 then
        self:moveTo(0, y)
        self.moveDirection = math.pi - self.moveDirection
    elseif x > 400 then
        self:moveTo(400, y)
        self.moveDirection = math.pi - self.moveDirection
    end

    -- bounce off vertical walls
    if y < 0 then
        self:moveTo(x, 0)
        self.moveDirection = -self.moveDirection
    elseif y >= 240 then
        self:moveTo(x, 240)
        self.moveDirection = -self.moveDirection
    end
end


