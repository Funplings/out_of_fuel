local pd <const> = playdate
local gfx <const> = playdate.graphics

import "enemySpawner"
import "player"
import "weapons/weapon"
import "weaponBox"
import "scoreDisplay"

class('GameScene').extends(gfx.sprite)

function GameScene:init()
    -- Add self
    self:add()

    -- Reset the graphics and great the score display
    gfx.clear()
    createScoreDisplay()
    createWeaponDisplay()

    -- Reset the score
    GAME_MANAGER:resetScore()
    self.gameOver = false


    -- Set up compoments
    self.player = Player(200, 120, self)
    startSpawner()
    WeaponBox(40, 360, 20, 220)

end

function GameScene:update()
    updateWeapon()
    if (self.gameOver and pd.buttonJustPressed(pd.kButtonA)) then
        SCENE_MANAGER:switchScene(GameScene)
    end
end

function GameScene:playerDeath()
    stopSpawner()
    self.gameOver = true
end