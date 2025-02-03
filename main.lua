local windowHeight = 500
local windowWidth = 500

function love.load()


--table für bird
bird = {
  x = 100,
  y = 100,
  size = 30,
  velocity = 0,
  gravity = 800,
  jumpForce = -300

}


pipes = {
  x = windowWidth,
  --y = 0,
  width = 50,
  --height = 500,
  speed = 200
}

resetGap()
end

function resetGap()
    -- Randomize gap position and size
    gap = {
        height = love.math.random(100, 200),  -- Gap height (100-200px)
        y = love.math.random(50, windowHeight - 200)  -- Gap start position
    }
end

function love.update(dt)
 --Physics für bird
  bird.velocity = bird.velocity + bird.gravity * dt
  bird.y = bird.y + bird.velocity * dt

  --pipes gehen von x nach links:
  pipes.x = pipes.x - pipes.speed *dt

  if pipes.x +pipes.width < 0 then
    pipes.x = windowWidth
    resetGap()
  end
end

--funktion für den jump, die velocity wird ersetzt durch einen sprung in die höhe der dann mit bird.y addiert wird
function love.keypressed(key)
  if key == "space" then
    bird.velocity = bird.jumpForce -- Apply jump force here!
  end
end



function love.draw()
  --zeichnet bird
  love.graphics.rectangle("fill", bird.x, bird.y, bird.size, bird.size)
  --zeichnet pipes
  love.graphics.rectangle("fill", pipes.x, 0, pipes.width, gap.y)

  local bottomPipeY = gap.y + gap.height
  local bottomPipeHeight = windowHeight - bottomPipeY
  love.graphics.rectangle("fill", pipes.x, bottomPipeY, pipes.width, bottomPipeHeight)
end