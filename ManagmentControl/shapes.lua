module(..., package.seeall)


local _W = display.contentWidth
local _H = display.contentHeight
state={}
local Venues = {"sq","t","l","z","hc","d","circ"}
local axis={
	{-50,-50 ,50,-50,50,50,-50,50 },
	{-50,50,0,-50,50,50},
	{-40,-40,0,-80,40,-40,40,20,-40,20},
	{-40,-40,0,-80,40,-40,40,20,0,60,-40,20},
	{0,0,0,-20,40,-20,40,20,20,20,20,0},
	{ 0,-110, 27,-35, 105,-35, 43,16, 65,90, 0,45, -65,90, -43,15, -105,-35, -27,-35, }

}


 function onTouch( self, event )
		local t = event.target
		local phase = event.phase
		local na = self:getRoomName()
		local inf = self:getRoomDescription()
		if self.dragable == true then
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
				
			        state:dispatchEvent({name="change",state="showInfo",info=inf,roomN=na, rm=self });
					self.isFocus = false
				end
			end
		end
	return true
end



function newShape(xi,yi ,figure )

	local room = display.newPolygon(xi,yi,axis[figure])
	room:setFillColor(0.74,0.73,0.12)
	room.x0 = xi
	room.y0 = yi
--	room.isFocus = true		-- **tbr - remove later
	touchroom = room		-- **tbr - temp
	--romm.id = event.id	
	--room:addEventListener( "touch", onTouch )

	return room
end

function newRoom( xi,yi,figure )
	local roomGroup= display.newGroup()
	local room = display.newPolygon(xi,yi,axis[figure])
	room:setFillColor(0.72,0.33,0)
	room.strokeWidth=3
	room:setStrokeColor(0)

	roomGroup:insert(room)
	local vertex={}

	for i=2,#axis[figure],2 do
		local shapeAxis = display.newCircle(axis[figure][i-1]+xi,axis[figure][i]+yi,5)
		shapeAxis:setFillColor(0,0,0.83)
		roomGroup:insert(shapeAxis)
	end

	-- for i =1,#axis[figure]/2 do
	-- 	local vx,vy= room.path:getVertex(i)
	-- 	local shapeAxis = display.newCircle(vx+xi,vy+yi,5)
	-- 	shapeAxis:setFillColor(0,0,0.83)
	-- 	roomGroup:insert(shapeAxis)

	-- end

	return roomGroup
end

function loadVenue(rGroup,type,width,height,posx,posy,rota,elements,roomDesc,roomName )

	local groupRoom=display.newGroup()
	local deviceGroup = display.newGroup()
	groupRoom.x=posx
	groupRoom.y=posy
	deviceGroup.x = posx
	deviceGroup.y=posy


	local room1= display.newImageRect(groupRoom,type.."ShapedVenue.png",width,height) 
	room1.x=0
	room1.y=0
	room1.rotation=rota
	room1.description=roomDesc
	room1.type=type
	room1.name=roomName
	room1.originalWidth=width
	room1.originalHeight=height
	room1.dragable=true
	room1.textName = display.newText(groupRoom,""..roomName,50,30,"arial",15)
	room1.textName:setFillColor(1)
	room1.textName.x= -22
	room1.textName.y = -10
	--room1.hasDevices = display.newCircle(groupRoom, 0,0,width/10)
	--room1.hasDevices:setFillColor(1,1,0)
	room1.hasDevices = display.newImageRect(groupRoom,  "Devices/rack.png",width/5,height/5)
	room1.hasDevices.isVisible=false
	room1.hasDevices.x = 20
	room1.hasDevices.y = 50
	

	if elements==true then
		room1.hasDevices.isVisible=true
	end


	function groupRoom:getXPoint()
		return groupRoom.x
	end

	function groupRoom:getYPoint()
		return groupRoom.y
	end
	
	function groupRoom:getRoomRotation()
		return room1.rotation
	end

	function groupRoom:setRoomRotation(val)
		room1.rotation=val
	end
	

	function groupRoom:getRoomType()
		return room1.type
	end

	function groupRoom:getRoomWidth()
		return room1.width
	end

	function groupRoom:setRoomWidth(val)
		room1.width=val
	end

	function groupRoom:getRoomHeight()
		return room1.height
	end

	function groupRoom:setRoomHeight(val)
		room1.height=val
	end

	function groupRoom:getRoomDescription()
		return room1.description
	end
	function groupRoom:getRoomName()
		return room1.name
	end

	function groupRoom:setRoomName(stringName)
		room1.name=stringName
		room1.textName.text=stringName
	end
	function groupRoom:setRoomDescription( newDescription  )
		 room1.description=newDescription
	end

	function  groupRoom:getRoomGroup( )
		return groupRoom
	end

	function groupRoom:setRoomColor( r,g,b,a )
		room1:setFillColor(r,g,b,a)
	end

	function groupRoom:setColor( r,g,b )
		room1:setFillColor(r,g,b)
	end

	function groupRoom:showDevices( )
		deviceGroup.isVisible=true
		print("showing "..deviceGroup.numChildren.." devices")
		for i =1,deviceGroup.numChildren do 
			deviceGroup[i].isVisible=true
			deviceGroup[i].x = _W/2 + math.random(-80,80)
			deviceGroup[i].y = _H/2 + math.random(-80,80)


		end


	end

	function groupRoom:hideDevices( )
		deviceGroup.isVisible=false
		print("hiding "..deviceGroup.numChildren.." devices")
	end


	function groupRoom:getDeviceGroup(  )
		return deviceGroup
	end

	function groupRoom:addDevice( device )
		
	--	deviceGroup:insert(device)
	--	print(deviceGroup.numChildren)
		room1.hasDevices.isVisible=true
	end

	function groupRoom:hideDevice(  )
		room1.hasDevices.isVisible=false
	end

	groupRoom.dragable=true
	deviceGroup.isVisible=false

	function groupRoom:lock( ... )
		groupRoom.dragable=false
	end

	function groupRoom:unlock( ... )
		groupRoom.dragable=true
	end

	 groupRoom.touch=onTouch
	 groupRoom:addEventListener( "touch", groupRoom )




	 rGroup:insert(groupRoom)
 	 groupRoom:insert(deviceGroup)


	return rGroup
end

