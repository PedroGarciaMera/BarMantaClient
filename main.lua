sock = require "sock"
bitser = require "spec.bitser"

require "libs/Tserial"

--Game States
_GS = require "libs/gamestate"

require "Fs"

local function getGsStates()
	local Gs = {}

	local files = love.filesystem.getDirectoryItems("states")
	local Fname,packageN
	for _, file in ipairs(files) do
		Fname=file:sub(0,-5); packageN="states."..file:sub(0,-5)
		Gs[Fname] = require(packageN)
	end

	return Gs
end



function love.load()
	w_w = 1080 ; w_h = 1920 ; w_w_2 = w_w/2 ; w_h_2 = w_h/2
    realw_w, realw_h = love.graphics.getDimensions( )
    scalex = (realw_w/w_w) ; scaley = (realw_h/w_h)

	_Gs = getGsStates()

	_GS.registerEvents()
	_GS.switch(_Gs.loadData)
end

function love.keyreleased(key)
	if key=='r' then love.event.quit("restart")
	elseif key=='t' then
		_CsStatus = {K=1;B=1}
		for K,C in pairs(_Cs) do C:disconnectNow() end
	end
end

function love.mousepressed( x, y, button, istouch )
	if not istouch then love.touchpressed( button, x, y ) end
end
function love.mousereleased( x, y, button, istouch )
	if not istouch then love.touchreleased( button, x, y ) end
end

function love.touchpressed( id, x, y, dx, dy, pressure ) _TPT=0; _QT=true; _TPos={x,y} end
function love.touchreleased( id, x, y, dx, dy, pressure ) _TPT=false end

function love.update(dt)
	if _Cs then checkClients(dt) end

	if _TPT then
		_TPT=_TPT+dt
		if _TPT>0.4 then _QT=false; _TPT=false
			if _GS.current().longTouch then _GS.current():longTouch() end
		end
	end
end

function love.draw()
	love.graphics.scale(scalex,scaley)
	love.graphics.setColor(Colors.BG[_CsStatus.K])
	love.graphics.rectangle("fill", 0, 0, w_w, w_h_2)
	love.graphics.setColor(Colors.BG[_CsStatus.B])
	love.graphics.rectangle("fill", 0, w_h_2, w_w, w_h_2)
	love.graphics.setColor(Colors.violet)
	love.graphics.setFont( Fonts[1] ); love.graphics.print("1.2");
	love.graphics.setColor(Colors.orange)
end

function love.quit() return false end
