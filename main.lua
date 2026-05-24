-- INFERNO JUMP PSP
-- Jogo de Plataforma 2D para PSP

-- Música
music = Sound.load("sounds/musica.mp3")
Sound.play(music, LOOP)

-- Player
player = {
    x = 50,
    y = 180,
    w = 20,
    h = 20,
    speed = 3,
    jumpPower = -8,
    gravity = 0.4,
    dy = 0,
    grounded = false
}

-- Inimigo
enemy = {
    x = 300,
    y = 200,
    w = 20,
    h = 20,
    dir = 1,
    speed = 1
}

-- Moeda
coin = {
    x = 200,
    y = 170,
    collected = false
}

score = 0

groundY = 220

while true do

    screen:clear()

    pad = Controls.read()

    --------------------------------
    -- MOVIMENTO PLAYER
    --------------------------------

    if pad:left() then
        player.x = player.x - player.speed
    end

    if pad:right() then
        player.x = player.x + player.speed
    end

    --------------------------------
    -- PULO
    --------------------------------

    if pad:cross() and player.grounded then
        player.dy = player.jumpPower
        player.grounded = false
    end

    --------------------------------
    -- GRAVIDADE
    --------------------------------

    player.dy = player.dy + player.gravity
    player.y = player.y + player.dy

    if player.y >= groundY then
        player.y = groundY
        player.dy = 0
        player.grounded = true
    end

    --------------------------------
    -- INIMIGO IA
    --------------------------------

    enemy.x = enemy.x + enemy.speed * enemy.dir

    if enemy.x > 400 then
        enemy.dir = -1
    end

    if enemy.x < 250 then
        enemy.dir = 1
    end

    --------------------------------
    -- COLISÃO MOEDA
    --------------------------------

    if not coin.collected then

        if player.x < coin.x + 16 and
           player.x + player.w > coin.x and
           player.y < coin.y + 16 and
           player.y + player.h > coin.y then

            coin.collected = true
            score = score + 1
        end
    end

    --------------------------------
    -- COLISÃO INIMIGO
    --------------------------------

    if player.x < enemy.x + enemy.w and
       player.x + player.w > enemy.x and
       player.y < enemy.y + enemy.h and
       player.y + player.h > enemy.y then

        player.x = 50
        player.y = 180
    end

    --------------------------------
    -- DESENHAR CENÁRIO
    --------------------------------

    -- Céu
    screen:fillRect(0,0,480,272,Color.new(80,180,255))

    -- Chão
    screen:fillRect(0,240,480,32,Color.new(50,200,50))

    --------------------------------
    -- DESENHAR PLAYER
    --------------------------------

    screen:fillRect(
        player.x,
        player.y,
        player.w,
        player.h,
        Color.new(255,0,0)
    )

    --------------------------------
    -- DESENHAR INIMIGO
    --------------------------------

    screen:fillRect(
        enemy.x,
        enemy.y,
        enemy.w,
        enemy.h,
        Color.new(0,0,0)
    )

    --------------------------------
    -- DESENHAR MOEDA
    --------------------------------

    if not coin.collected then
        screen:fillRect(
            coin.x,
            coin.y,
            12,
            12,
            Color.new(255,255,0)
        )
    end

    --------------------------------
    -- HUD
    --------------------------------

    screen:print(
        10,
        10,
        "INFERNO JUMP",
        Color.new(255,255,255)
    )

    screen:print(
        10,
        30,
        "SCORE: "..score,
        Color.new(255,255,255)
    )

    screen:print(
        10,
        50,
        "X = PULAR",
        Color.new(255,255,255)
    )

    --------------------------------
    -- ATUALIZAR TELA
    --------------------------------

    screen.waitVblankStart()
    screen.flip()

end
