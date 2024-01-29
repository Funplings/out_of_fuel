local pd <const> = playdate

import "scoreDisplay"

class('GameManager').extends()

GAME_MANAGER = nil

function GameManager:init()
    if GAME_MANAGER == nil then
        GAME_MANAGER = self
        self.score = 0
    end
end

function GameManager:incrementScore()
    self.score += 1
    updateScoreDisplay()
end

function GameManager:resetScore()
    self.score = 0
    updateScoreDisplay()
end