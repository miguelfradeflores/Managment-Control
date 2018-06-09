 module(..., package.seeall)

local _W = display.contentWidth
local _H = display.contentHeight

state = {}

-----variables para contar el indice del dispositvo por tipo
local currentDevice = 1

local contadorMic =1
local contadorMixer=1
local contadorProc =1
local contadorPower =1
local contadorMomit=1

function resetCounters( )

	contadorMic =1
	 contadorMixer=1
	 contadorProc =1
	 contadorPower =1
	 contadorMomit=1

end

function sendPos( self,event )
	local phase = event.phase
	local posx = self:getInXEdge()
	local posx2 = self:getOutXEdge()
	local posIy= self:getInY()
	local posOy= self:getOutY()
	if "began" == phase then
		print("Selected Device , devGroupx: " .. posx)
			state:dispatchEvent({name="change",state="link",devIX= posx,devOX=posx2, devIY=posIy,devOY=posOy, device=self });
	
	elseif phase == "moved" then

	elseif phase == "ended" or phase == "cancelled" then
	
	end

end



 function onTouch( self, event )
		local t = event.target
		local phase = event.phase

	--	if self.dragable == true then
			if "began" == phase then
				local parent = t.parent
				parent:insert( t )
				display.getCurrentStage():setFocus( t )
				self.isFocus = true
				-- Store initial position
				t.x0 = event.x - t.x
				t.y0 = event.y - t.y
			elseif self.isFocus then
				if "moved" == phase then

					if event.x >160 and event.x<_W-80 and event.y>190 and event.y< _H-250 then
					t.x = event.x 
					t.y = event.y 
					end
				elseif "ended" == phase or "cancelled" == phase then
					display.getCurrentStage():setFocus( nil )
				
	--		        state:dispatchEvent({name="change",state="showInfo",info=inf,roomN=na, rm=self });
					self.isFocus = false
				end
			end
	--	end
	return true
end


function highIO( a,b )
	if a>b then return a 
	else return b
	end	
	
end

local yamahaDevices ={
		{name = "01V96i", descripcion="Consola",kind="control",salidas= 4,entradas=18},
		{name = "DSR112",descripcion = "Monitor",kind="monit",entradas=2,salidas=4},
		{name = "SP2060", descripcion="Receiver",kind="process",entradas=3,salidas=6 }
}


local shureDevice ={
	{name = "SM58", descripcion="Microfono",salidas=1,entradas=0, kind="mics"  }
}

local AKGDevice = {
	{name ="DSR800",kind="mics", descripcion="Receiver ",salidas=6,entradas=0,type=" "    },
	{name ="SR4500",kind="mics", descripcion="Reference Digital Receiver 2ch",salidas=6,entradas=0 ,type=" "} ,
	{name ="DMSTetrad",kind="mics", descripcion="Reference Digital Receiver 2ch",salidas=6,entradas=0, type=" "}
}

local crownDevice = {
	{name ="CTs1200",kind="power", descripcion="Two channel, 600W",salidas=6,entradas=2},
	{name ="CTs3000",kind="power", descripcion="2 ch, 1500W",salidas=6,entradas=2},
	{name ="CTs4200",kind="power", descripcion="4 ch,2600W",salidas=6,entradas=4}

}


local dbxDevice = {
	{name ="DriveRack4820",kind="process",  descripcion="Procesador",salidas=8,entradas=4},
	{name ="DriveRackPA",kind="process", descripcion="Procesador",salidas=6,entradas=0}
}

local jblDevice = {
	{name ="EON610",kind="monit", descripcion="Speakers",salidas=1,entradas=1},
	{name ="EON618S",kind="monit", descripcion="Speakers",salidas=2,entradas=2}
}


function spawnDevice2( brand,deviceId,posx,posy,roomName,coment )
	local devGroup = display.newGroup()	

	devGroup.x=posx
	devGroup.y=posy

	local device 
		if(brand == "yamaha") then
			local deviceHeight = highIO(yamahaDevices[deviceId].salidas,yamahaDevices[deviceId].entradas )

			device = display.newRect(devGroup,0,0,80,170 )
			device.descripcion = yamahaDevices[deviceId].descripcion
			device.type=yamahaDevices[deviceId].name
			device.name= "yamaha"..yamahaDevices[deviceId].name
			device.kind = yamahaDevices[deviceId].kind
			device.entradas=yamahaDevices[deviceId].entradas
			device.salidas=yamahaDevices[deviceId].salidas

		elseif (brand== "shure") then

			local deviceHeight = highIO(shureDevice[deviceId].salidas,shureDevice[deviceId].entradas )

			device = display.newRect(devGroup,0,0,80,120)
			device.descripcion = shureDevice[deviceId].descripcion
			device.name= "shure "..shureDevice[deviceId].name
			device.type= shureDevice[deviceId].name
			device.kind = shureDevice[deviceId].kind
			device.entradas=shureDevice[deviceId].entradas
			device.salidas=shureDevice[deviceId].salidas

		elseif (brand == "akg") then 

			local deviceHeight = highIO(AKGDevice[deviceId].salidas,AKGDevice[deviceId].entradas )

			device = display.newRect(devGroup,0,0,85,80 )
			device.descripcion = AKGDevice[deviceId].descripcion
			device.name= "akg"..AKGDevice[deviceId].name
			device.type= AKGDevice[deviceId].name
			device.kind = AKGDevice[deviceId].kind

			device.entradas=AKGDevice[deviceId].entradas
			device.salidas=AKGDevice[deviceId].salidas


		elseif brand == "crown" then

			local deviceHeight = highIO(crownDevice[deviceId].salidas,crownDevice[deviceId].entradas )

			device = display.newRect(devGroup,0,0,85,128 )
			device.descripcion = crownDevice[deviceId].descripcion
			device.name= "crown"..crownDevice[deviceId].name
			device.type = crownDevice[deviceId].name
			device.kind = crownDevice[deviceId].kind
			device.entradas=crownDevice[deviceId].entradas
			device.salidas=crownDevice[deviceId].salidas


		elseif brand == "dbx" then
			local deviceHeight = highIO(dbxDevice[deviceId].salidas,dbxDevice[deviceId].entradas )

			device = display.newRect(devGroup,0,0,85,128 )
			device.descripcion = dbxDevice[deviceId].descripcion
			device.type= dbxDevice[deviceId].name
			device.name= "dbx "..dbxDevice[deviceId].name
			device.kind = dbxDevice[deviceId].kind
			device.entradas=dbxDevice[deviceId].entradas
			device.salidas=dbxDevice[deviceId].salidas
			

		elseif brand == "jbl" then
			
			local deviceHeight = highIO(jblDevice[deviceId].salidas,jblDevice[deviceId].entradas )

			device = display.newRect(devGroup,0,0,85,80 )
			device.descripcion = jblDevice[deviceId].descripcion
			device.type= jblDevice[deviceId].name
			device.name= "jbl"..jblDevice[deviceId].name
			device.kind = jblDevice[deviceId].kind
			device.entradas=jblDevice[deviceId].entradas
			device.salidas=jblDevice[deviceId].salidas
			


		end

	device.ins = device.entradas
	device.outs = device.salidas
	device.coment=coment


	device.strokeWidth=3
	device:setStrokeColor(0)
	device:setFillColor( 0,0.2,0.84)

	if device.kind == "mics"then 
		device.type = device.type.."_"..contadorMic
		contadorMic=contadorMic+1
	elseif device.kind == "control" then
		device.type = device.type.."_"..contadorMixer
		contadorMixer=contadorMixer+1
	elseif device.kind == "process" then
		device.type = device.type.."_"..contadorProc
		contadorProc=contadorProc+1
	elseif device.kind == "power" then
		device.type = device.type.."_"..contadorPower
		contadorPower=contadorPower+1
	elseif device.kind == "monit" then
		device.type = device.type.."_"..contadorMomit
		contadorMomit=contadorMomit+1
	end
	
--	device.type = device.type..""..currentDevice
	device.title = display.newText(devGroup,device.type,50,30,"arial",15 )
	device.title.x = device.x
	device.title.y = device.y + device.contentHeight/2 + 15

	device.inFactor = device.contentHeight/ (device.entradas+1)
	device.outFactor = device.contentHeight/ (device.salidas+1)

	device.currentInPoint = device.inFactor
	device.currentOutPoint = device.outFactor

--	currentDevice=currentDevice+1
	device.room=roomName

	device.roomText = display.newText(devGroup,roomName,50,30,"arial",15 )
	device.roomText.y = device.y - device.contentHeight/2 - 15
	device.roomText.x = device.x

	device.brand=brand
	device.id=deviceId


	for j=1,device.entradas do 
		local inDot = display.newCircle(devGroup,device.x-(device.contentWidth/2) ,(device.y -device.contentHeight/2)+(device.inFactor*j),5)
	end	


	for j=1,device.salidas do 
		local outDot = display.newCircle(devGroup,device.x+(device.contentWidth/2) ,(device.y -device.contentHeight/2)+(device.outFactor*j),5)
	end	


	function devGroup:addInFactor(  )
		device.currentInPoint=device.currentInPoint+device.inFactor 
	end

	function devGroup:addOutFactor( )
		device.currentOutPoint= device.currentOutPoint+device.outFactor
	end

	function devGroup:getInY( ... )
		return devGroup.y -device.contentHeight/2 +  device.currentInPoint
	end

	function devGroup:getOutY( ... )
		return  devGroup.y -device.contentHeight/2 + device.currentOutPoint
	end

	function devGroup:resetIOpoints(  )
		device.currentInPoint = device.inFactor
		device.currentOutPoint = device.outFactor
		device.entradas= device.ins
		device.salidas= device.outs

	end

	function devGroup:useIn( )
		device.entradas=device.entradas-1
	end
	function devGroup:useOut( )
		device.salidas= device.salidas-1
	end

	function devGroup:addIn( )
		device.entradas=device.entradas+1
	end
	function devGroup:addOut( )
		device.salidas= device.salidas+1
	end

	function devGroup:getInXEdge(  )
		return devGroup.x - device.contentWidth/2 +3
	end

	function devGroup:getOutXEdge(  )
		return devGroup.x + device.contentWidth/2 -3
	end

	function devGroup:setColors( r,g,b,a )
		device:setFillColor(r,g,b,a)
	end

	function devGroup:getInputs(  )
		return device.entradas
	end

	function devGroup:getOutputs(  )
		return device.salidas
	end

	function devGroup:getkind( )
		return device.kind
	end

	function devGroup:getComent(  )
		return device.coment
	end

	function devGroup:setComent( newComent )
		 device.coment= newComent
	end

	function devGroup:getRoomName(  )
		return device.room
	end

	function devGroup:getId(  )
		return device.id
	end

	function devGroup:setRoomName( newName )
		device.room = newName
		device.roomText.text = ""..newName
	end

	function devGroup:getDeviceId( )
		return device.id
	end

	function devGroup:getName( )
		return device.name
	end

	function devGroup:getBrand(  )
		return device.brand
	end

	function devGroup:getDescription(  )
		return device.type
	end

	function devGroup:getType(  )
		return device.type
	end

	function devGroup:getX( )
		return devGroup.x
	end

	function devGroup:setX( posx )
		devGroup.x =posx
	end

	function devGroup:setY( posy )
		devGroup.y =posy
	end
 
	function devGroup:getY( )
		return devGroup.y
	end

	devGroup.touch=sendPos
	devGroup:addEventListener( "touch", devGroup )
	





	return devGroup
end

function spawnDevice(brand,deviceId,posx,posy,roomName )
	local device 	

		if(brand == "yamaha") then
			device = display.newImageRect("Devices/yamaha"..yamahaDevices[deviceId].name ..".png",200,200)
			device.descripcion = yamahaDevices[deviceId].descripcion
			device.type= "yamaha"..yamahaDevices[deviceId].name
			device.kind = yamahaDevices[deviceId].kind
		elseif (brand== "shure") then
			device = display.newImageRect("Devices/shure"..shureDevice[deviceId].name ..".png",150,150)
			device.descripcion = shureDevice[deviceId].descripcion
			device.type= "shure"..shureDevice[deviceId].name
			device.kind = shureDevice[deviceId].kind
		elseif (brand == "akg") then 
			device = display.newImageRect("Devices/akg"..AKGDevice[deviceId].name ..".png",180,60)
			device.descripcion = AKGDevice[deviceId].descripcion
			device.type= "akg"..AKGDevice[deviceId].name
			device.kind = AKGDevice[deviceId].kind
		elseif brand == "crown" then
			device = display.newImageRect("Devices/crown"..crownDevice[deviceId].name ..".png",150,60)
			device.descripcion = crownDevice[deviceId].descripcion
			device.type= "crown"..crownDevice[deviceId].name
			device.kind = crownDevice[deviceId].kind
		elseif brand == "dbx" then
			device = display.newImageRect("Devices/dbx"..dbxDevice[deviceId].name ..".png",150,60)
			device.descripcion = dbxDevice[deviceId].descripcion
			device.type= "dbx"..dbxDevice[deviceId].name
			device.kind = dbxDevice[deviceId].kind
		elseif brand == "jbl" then
			device = display.newImageRect("Devices/jbl"..jblDevice[deviceId].name ..".png",100,100)
			device.descripcion = jblDevice[deviceId].descripcion
			device.type= "jbl"..jblDevice[deviceId].name
			device.kind = jblDevice[deviceId].kind
		end

	device.descripcion=device.descripcion..""..currentDevice
	currentDevice=currentDevice+1
	device.room=roomName
	device.x=posx
	device.y =posy
	device.brand=brand
	device.id=deviceId


--	device.isVisible = false
	function device:getkind( )
		return device.kind
	end

	function device:getRoomName(  )
		return device.room
	end

	function device:getId(  )
		return device.id
	end

	function device:setRoomName( newName )
		device.room = newName
	end

	function device:getBrand(  )
		return device.brand
	end

	function device:getDescription(  )
		return device.descripcion
	end

	function device:getType(  )
		return device.type
	end

	function device:getX( )
		return device.x
	end

	function device:setX( posx )
		device.x =posx
	end

	function device:setY( posy )
		device.y =posy
	end

	function device:getY( )
		return device.y
	end
	 device.touch=sendPos
	 device:addEventListener( "touch", device )

	return device
end



