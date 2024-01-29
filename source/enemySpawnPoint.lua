import "enemy"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('EnemySpawnPoint').extends(gfx.sprite)

function EnemySpawnPoint:init(x, y, enemyType)
    self.enemyType = enemyType

    -- graphics
    self:setImage(gfx.image.new("images/spawn_point"))
    self:add()

    -- move to starting position
    self:moveTo(x, y)
    self.x = x
    self.y = y
    self.radius = 10

    -- set spawnDelay
    self.spawnDelay = 1000
    pd.timer.performAfterDelay(self.spawnDelay, function()
        self.enemyType(self.x, self.y)
        self:remove()
    end)
end


function EnemySpawnPoint:update()
    gfx.drawCircleAtPoint(self.x, self.y, self.radius)
end