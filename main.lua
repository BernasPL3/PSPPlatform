player = {
    x = 50,
    y = 180,
    speed = 3,
    jump = -8,
    gravity = 0.4,
    dy = 0
}

groundY = 220

while true do
    screen:clear()

    pad = Controls.read()

    -- Movimento
    if pad:left() then
        player.x = player.x - player.speed
    end

    if pad:right() then
        player.x = player.x + player.speed
    end

    -- Pulo
    if pad:cross() and player.y >= groundY then
        player.dy = player.jump
    end

    -- Gravidade
    player.dy = player.dy + player.gravity
    player.y = player.y + player.dy

    -- Chão
    if player.y > groundY then
        player.y = groundY
        player.dy = 0
    end

    -- Jogador
    screen:fillRect(player.x, player.y, 20, 20, Color.new(255,0,0))

    -- Plataforma
    screen:fillRect(0, 240, 480, 30, Color.new(0,255,0))

    screen:print(10,10,"PLATFORM GAME PSP", Color.new(255,255,255))

    screen.waitVblankStart()
    screen.flip()
end
