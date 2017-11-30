sodapop = require('sodapop')
require("ship")

Fire = {}

function Fire:new()
	f = {
		fireSprite = sodapop.newAnimatedSprite(player.xPos, player.yPos+32),
		xGap = 16
	}
  		f.fireSprite:addAnimation('thrust', {
    		image        = love.graphics.newImage("img/fire/sheey.png"),
    		frameWidth   = 32,
    		frameHeight  = 48,
   			 frames       = {
      			{1, 1, 4, 1, .1},
   			 },
  		})

  	setmetatable(f, { __index = Fire })
  	return f
 end 


function Fire:update(dt)
	f.fireSprite.r = player.rotation
	f.fireSprite.x = player.xPos
	f.fireSprite:update(dt)
end 

function Fire:draw()
	f.fireSprite:drawf(0,-24)
end 