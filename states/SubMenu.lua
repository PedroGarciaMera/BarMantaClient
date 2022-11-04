local SubMenu = {}

function SubMenu:init() end
function SubMenu:enter(oldState,type)
	love.graphics.setColor(Colors.orange)
	self.Bs = _SubMenuBs[type]
	_page = 1
end

function SubMenu:keyreleased(key)
	if key == 'escape' then _GS.pop() end
end

function SubMenu:longTouch()
	for i,B in ipairs(self.Bs[_page]) do
		if isPointInRectangle(_TPos[1],_TPos[2],B) then
			if B.txt=="<-" or B.txt=="->" then _QT=true else _GS.switch(_Gs.PickAmount,B) end
			return
		end
	end
end

function SubMenu:touchreleased( id, x, y, dx, dy, pressure )
	if _QT then
		for i,B in ipairs(self.Bs[_page]) do
			if isPointInRectangle(x,y,B) then B.exe(1); return end
		end
	end
end

function SubMenu:update(dt)

end

function SubMenu:draw()
	love.graphics.setFont( Fonts[5] )
	drawTittle("PICK")
	love.graphics.setFont( Fonts[4] )
	drawButtons(self.Bs[_page])
end

function SubMenu:leave()

end

return SubMenu
