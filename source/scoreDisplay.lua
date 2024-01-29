local pd <const> = playdate
local gfx <const> = pd.graphics

local scoreSprite

function createScoreDisplay()
    scoreSprite = gfx.sprite.new()
    updateScoreDisplay()
    scoreSprite:setCenter(0, 0)
    scoreSprite:moveTo(320, 4)
    scoreSprite:add()
end

function updateScoreDisplay()
    local scoreText = "Score: " .. GAME_MANAGER.score
    local textWidth, textHeight = gfx.getTextSize(scoreText)
    local scoreImage = gfx.image.new(textWidth, textHeight)
    gfx.pushContext(scoreImage)
        gfx.drawText(scoreText, 0, 0)
    gfx.popContext()
    scoreSprite:setImage(scoreImage)
end