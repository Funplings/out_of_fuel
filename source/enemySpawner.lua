import "enemySpawnPoint"
import "basicEnemy"

local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer
local minX = 40
local maxX = 360
local minY = 40
local maxY = 200

local minTimeBetweenEnemySpawns = 1500
local maxTimeBetweenEnemySpawns = 3500
function startSpawner()
    math.randomseed(pd.getSecondsSinceEpoch())
    createTimer()
end

function createTimer()
    local spawnTime = math.random(minTimeBetweenEnemySpawns, maxTimeBetweenEnemySpawns)
    spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
        createTimer()
        spawnEnemy()
    end)
end

function stopSpawner()
    if spawnTimer then
        spawnTimer:remove()
    end
end

function spawnEnemy()
    local x, y = math.random(minX, maxX), math.random(minY, maxY)
    EnemySpawnPoint(x, y, BasicEnemy)
end