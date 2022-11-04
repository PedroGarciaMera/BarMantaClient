local History = {}

function History:init() end

function History:enter(oldState,LT)
  self.Bs = {}; local B;
  -- Back
	table.insert(self.Bs,newButton(0,0,w_h*0.1,w_h*0.1,"<-",
		function() _GS.switch(_Gs.PickMesa) end
	))
  -- Mesas
  for i,mesa in ipairs(_MesasHistory) do
    B = newPosButton(i,mesa.i,function() _GS.push(_Gs.HistoryMesa, mesa) end)
		table.insert(self.Bs,B)
  end
end

function History:keyreleased(key)
	if key == 'escape' then _GS.switch(_Gs.PickMesa) end
end

function History:touchreleased( id, x, y, dx, dy, pressure )
	if self.longT then self.longT=false; return end

	for i,B in ipairs(self.Bs) do
		if isPointInRectangle(x,y,B) then B.exe(self); break end
	end
end

function History:draw()
	drawTittle("HISTORIAL")

  love.graphics.setColor(Colors.orange)
  drawButtons(self.Bs)
end

return History
