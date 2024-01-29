import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "enemy"
import "player"
import "enemySpawner"
import "sceneManager"
import "gameScene"
import "gameManager"

local pd <const> = playdate
local gfx <const> = pd.graphics

SCENE_MANAGER = SceneManager()
GAME_MANAGER = GameManager()

GameScene()

function pd.update()
	gfx.sprite.update()
	pd.timer.updateTimers()
end