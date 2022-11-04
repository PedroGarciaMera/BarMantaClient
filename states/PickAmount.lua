local PickAmount = {}

local function delPedido(KEY)
	local M = _Mesas[_mesaPd]

	if not M or not M.items[KEY] then return end

	M.items[KEY]=nil

	local left = false
	for k,_ in pairs(M.items) do left=true; break	end
	if not left then _Mesas[_mesaPd]=nil end

	love.filesystem.write( "mesas.sav", TSerial.pack(_Mesas))
end

function PickAmount:init()
	self.Bs = {}; local B
	for i=1,9 do
		B = {txt=i}
		for k,v in pairs(PosButtons[i]) do B[k]=v end
		table.insert(self.Bs,B)
	end

	self.Bs2 = {}
	-- Back
	B = newButton(0,0,w_h*0.1,w_h*0.1,"<-", function() _GS.pop() end)
	table.insert(self.Bs2,B)
	-- Delete item
	B = newPosButton(14,"BORRAR",function(SELF) delPedido(SELF.B.txt); _GS.pop(); _GS.push(_Gs.Mesa) end)
	table.insert(self.Bs2,B)
end

function PickAmount:enter(oldState,Button)
	love.graphics.setColor(Colors.orange)
	self.B = Button
	self.firstT = true
end

function PickAmount:keyreleased(key) if key == 'escape' then _GS.pop() end end

function PickAmount:touchreleased( id, x, y, dx, dy, pressure )
	if self.firstT then self.firstT=false; return end

	for _,B in ipairs(self.Bs2) do
		if isPointInRectangle(x,y,B) then B.exe(self); return end
	end

	for i,B in ipairs(self.Bs) do
		if isPointInRectangle(x,y,B) then self.B.exe(i); break end
	end
end

function PickAmount:draw()
	love.graphics.setFont( Fonts[5] )
	drawTittle(self.B.txt)
	love.graphics.setFont( Fonts[4] )
	drawButtons(self.Bs2)
	drawButtons(self.Bs)
end

return PickAmount
