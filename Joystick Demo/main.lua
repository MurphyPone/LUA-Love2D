    
local joystick, position, speed
    function love.load()
        joysticks = love.joystick.getJoysticks()
        looped = 0
        for i in ipairs(joysticks) do
          looped = looped + 1
        end
        joystick = joysticks[looped]
        position = {x = 0, y = 0}
        speed = 10

    end

    function love.update(dt)
       if joystick then
          axis1, axis2 = joystick:getAxes()
          position.x, position.y = position.x + axis1 * speed * dt, position.y + axis2 * speed * dt
      end
    end

    function love.draw()
       love.graphics.circle("fill", position.x, position.y, 50)
    end