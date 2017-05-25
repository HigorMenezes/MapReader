map = require("mapRender")
Camera = require("camera")
camera = Camera(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
function love.load()
	map:create({file = "map/level1", mapName = "level1", tileSetName = "default", tileSetFile = "img/map2.png",
		originX = 40, originY = 200})
end

function love.update(dt)
	if love.keyboard.isDown("d") then
	    camera:move(math.floor(200*dt), 0)
	end
	if love.keyboard.isDown("a") then
	    camera:move(-math.floor(200*dt), 0)
	end
	if love.keyboard.isDown("w") then
	    camera:move(0,-math.floor(200*dt))
	end
	if love.keyboard.isDown("s") then
	    camera:move(0,math.floor(200*dt))
	end
end

function love.draw()
	camera:attach()
	map:draw("level1")
    camera:detach()
end

function love.wheelmoved(x, y)
    camera:zoom(1 + y/10)
end

