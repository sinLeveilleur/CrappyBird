local windowHeight = 500
local windowWidth = 500
local titleImage = love.graphics.newImage("/assets/Title.png")

function love.load()
  -- Initialize game state
  isTitleScreen = true

  -- Bird properties
  bird = {
    x = 100,
    y = 100,
    size = 30,
    velocity = 0,
    gravity = 800,
    jumpForce = -300
  }

  -- Pipes properties
  pipes = {
    x = windowWidth,
    width = 50,
    speed = 200
  }

  resetGap()
end

function resetGap()
  gap = {
    height = love.math.random(100, 200),
    y = love.math.random(50, windowHeight - 200)
  }
end

function love.update(dt)
  -- Only update game if not on title screen
  if not isTitleScreen then
    -- Bird physics
    bird.velocity = bird.velocity + bird.gravity * dt
    bird.y = bird.y + bird.velocity * dt

    -- Pipe movement
    pipes.x = pipes.x - pipes.speed * dt

    -- Reset pipes when they exit screen
    if pipes.x + pipes.width < 0 then
      pipes.x = windowWidth
      resetGap()
    end
  end
end

function love.keypressed(key)
  if key == "space" then
    if isTitleScreen then
      -- Start the game
      isTitleScreen = false
    else
      -- Make bird jump
      bird.velocity = bird.jumpForce
    end
  end
end

function love.draw()
  if isTitleScreen then
    -- Draw title screen
    love.graphics.draw(titleImage, 0, 0)
    return  -- Exit draw function early
  end

  -- Draw game elements
  love.graphics.rectangle("fill", bird.x, bird.y, bird.size, bird.size)
  
  -- Draw top pipe
  love.graphics.rectangle("fill", pipes.x, 0, pipes.width, gap.y)
  
  -- Draw bottom pipe
  local bottomPipeY = gap.y + gap.height
  local bottomPipeHeight = windowHeight - bottomPipeY
  love.graphics.rectangle("fill", pipes.x, bottomPipeY, pipes.width, bottomPipeHeight)
end