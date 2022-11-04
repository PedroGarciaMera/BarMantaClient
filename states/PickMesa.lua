local PickMesa = {}

function PickMesa:init()
	-- Buttons
	local B
	-- 1-9
	self.Bs1 = {}
	for i=1,9 do
		B = newPosButton(i,i,function(self) _mesaPd=i; _GS.switch(_Gs.Menu) end)
		table.insert(self.Bs1,B)
	end
	B = newPosButton(15,"->",function(self) self.Bs=self.Bs2 end)
	table.insert(self.Bs1,B)
	-- 10-19
	self.Bs2 = {}
	for i=1,10 do
		B = newPosButton(i,i+9,function(self) _mesaPd=i+9; _GS.switch(_Gs.Menu) end)
		table.insert(self.Bs2,B)
	end
	B = newPosButton(13,"<-",function(self) self.Bs=self.Bs1 end)
	table.insert(self.Bs2,B)
	B = newPosButton(15,"->",function(self) self.Bs=self.Bs3 end)
	table.insert(self.Bs2,B)
	-- 20-29
	self.Bs3 = {}
	for i=1,10 do
		B = newPosButton(i,i+19,function(self) _mesaPd=i+19; _GS.switch(_Gs.Menu) end)
		table.insert(self.Bs3,B)
	end
	B = newPosButton(13,"<-",function(self) self.Bs=self.Bs2 end)
	table.insert(self.Bs3,B)

	-- History
	B = newPosButton(14,"H",function(self) _GS.switch(_Gs.History) end)
	table.insert(self.Bs1,B); table.insert(self.Bs2,B); table.insert(self.Bs3,B);

	self.Bs = self.Bs1
end

function PickMesa:enter(oldState,LT)
	love.graphics.setFont( Fonts[5] )
	self.longT = LT or false
end

function PickMesa:keyreleased(key)
	if key == 'escape' then love.event.quit() end
end

function PickMesa:touchreleased( id, x, y, dx, dy, pressure )
	if self.longT then self.longT=false; return end

	for i,B in ipairs(self.Bs) do
		if isPointInRectangle(x,y,B) then B.exe(self); break end
	end
end

function PickMesa:draw()
	drawTittle("PICK MESA")

	for i,B in pairs(self.Bs) do
		if _Mesas[B.txt] then love.graphics.setColor(Colors.yellow)
		else love.graphics.setColor(Colors.orange)
		end
		drawButton(B)
	end
end

return PickMesa
