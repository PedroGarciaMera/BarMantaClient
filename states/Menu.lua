local Menu = {}

function Menu:init() end
function Menu:enter(oldState)
	local menuBs = _MenusBs[_MenuSel];

  menuBs[#menuBs].txt = "Mesa ".._mesaPd
end

function Menu:keyreleased(key)
	if key == 'escape' then _GS.switch(_Gs.PickMesa) end
end

function Menu:longTouch()
	local menuBs = _MenusBs[_MenuSel];

	if isPointInRectangle(_TPos[1],_TPos[2],menuBs[#menuBs]) then _GS.switch(_Gs.PickMesa,true)
	else _QT=true
	end
end

function Menu:touchreleased( id, x, y, dx, dy, pressure )
	if _QT then
		for i,B in ipairs(_MenusBs[_MenuSel]) do
			if isPointInRectangle(x,y,B) then B.exe(); break end
		end
	end
end

function Menu:update(dt) end

function Menu:draw()
	local menuBs = _MenusBs[_MenuSel];

	love.graphics.setFont( Fonts[5] )
	love.graphics.setColor(Colors.orange)
	drawButtons(menuBs)
	if _Mesas[_mesaPd] then
		love.graphics.setColor(Colors.yellow)
		drawButton(menuBs[#menuBs])
	end
end

function Menu:leave() end


return Menu
