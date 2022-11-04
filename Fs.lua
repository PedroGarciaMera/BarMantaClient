function drawTittle(T) love.graphics.printf(T, 0, 0, w_w, "center") end

function newPosButton(pos,T,F)
	local B = {txt=T, exe=F}
	for k,v in pairs(PosButtons[pos]) do B[k]=v end

	return B
end

function newButton(X,Y,W,H,T,F) return {x=X, y=Y, w=W, h=H, txt=T, exe=F} end

function drawButton(B)
	love.graphics.rectangle("line", B.x, B.y, B.w, B.h)
	love.graphics.printf(B.txt, B.x, B.y, B.w, "center")
end

function drawButtons(Bs)
	for i,B in ipairs(Bs) do drawButton(B) end
end

function isPointInRectangle(x,y,R)
	return (x/scalex>=R.x and x/scalex<=R.x+R.w and y/scaley>=R.y and y/scaley<=R.y+R.h)
end

function clearMesa(Mi,toHistory)
	if toHistory then
		table.insert(_MesasHistory,1,{i=Mi;items={}})
		for _,item in pairs(_Mesas[Mi].items) do
			table.insert(_MesasHistory[1].items,{n=item.n; txt=item.txt; isKitchen=item.isKitchen})
		end

		if (#_MesasHistory>15) then table.remove(_MesasHistory,#_MesasHistory) end
	end

	_Mesas[Mi]=nil
	love.filesystem.write( "mesas.sav", TSerial.pack(_Mesas))
end

function checkClients(dt)
	if dt>2 then
		_CsStatus = {K=1;B=1}
		for K,C in pairs(_Cs) do C:disconnectNow() end
	else
		for KEY,C in pairs(_Cs) do
			if _CsStatus[KEY]==1 then _CsStatus[KEY]=2; C:connect()
			elseif _CsStatus[KEY]==2 and C:isConnected() then _CsStatus[KEY]=3
			end
			C:update()
		end
	end
end
