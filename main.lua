local love = require "love"
local enemy = require "Enemy"

math.randomseed(os.time())
local game = {
    difficulty = 1,
    state = {
        menu = true,
        paused = true,
        running = true,
        ended = true
    }
}
local player = {
    radius = 20,
    x = 0,
    y = 0,
    isMoving = false -- controla se o jogador esta seguindo o mouse
}

local enemies = {}

function love.load()
    love.window.setTitle("Save the Ball")
    love.mouse.setVisible(false)

    -- calcula as coordenadas centrais e ajuda a posição do jogador
    local centerX = love.graphics.getWidth() / 2
    local centerY = love.graphics.getHeight() / 2

    player.x = centerX
    player.y = centerY

    -- enemies
    table.insert(enemies, 1, enemy())

end

function love.update()

    if player.isMoving then
        player.x, player.y = love.mouse.getPosition()
    end

    for i = 1, #enemies do
        enemies[i]:move(player.x, player.y)
    end
        
end

function love.draw()

    love.graphics.printf("FPS:" .. love.timer.getFPS(), love.graphics.newFont(16), 10, love.graphics.getHeight() - 30,
    love.graphics.getWidth())

    if game.state["running"] then

        for i = 1, #enemies do
            enemies[i]:draw()
        end

        love.graphics.circle("fill", player.x, player.y, player.radius)
    end

    if not game.state["running"] then
        love.graphics.circle("fill", player.x, player.y, player.radius / 2)
    end

    -- verifica se o mouse foi clicado para começar o movimento
    function love.mousepressed(x, y, button, istouch, presses)
        if button == 1 then   -- botão esquerdo do mouse
            player.isMoving = true
        end
    end

end
