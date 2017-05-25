local BASE = (...):match('(.-)[^%.]+$')

quads = require(BASE .. "quadGenerator")
Map = {}

maps = {}

function Map:create(param)
	local newMap = {}
	newMap.originX = param.originX or 0
	newMap.originY = param.originY or 0
	newMap.file = param.file
	newMap.mapName = param.mapName
	newMap.tileSetName = param.tileSetName
	newMap.tileSetFile = param.tileSetFile
	newMap.map = require(newMap.file)

	local r = newMap.map.tilesets[1]

	quads:create({quadName = newMap.tileSetName, imageFile = newMap.tileSetFile, 
		margin = r.margin, spacing = r.spacing, tileWidth = r.tilewidth, tileHeight = r.tileheight})

	maps[newMap.mapName] = newMap
end

function Map:draw(mapName)
	for k,v in pairs(maps) do
		if k == mapName then
			r = v.map.layers[1]
			for k1,v1 in pairs(r.data) do
				if v1 ~= 0 then
					sx, sy = 1, 1
					local x = v.originX + ((k1-1)%r.width)*v.map.tilesets[1].tilewidth*sx
					local y = v.originY + math.floor(((k1-1)/r.width))*v.map.tilesets[1].tileheight*sy
					image, quad = quads:getQuad(v.tileSetName, v1)
					love.graphics.draw(image, quad, x, y, 0 , sx, sy)
				end
			end
		end
	end
end
return Map