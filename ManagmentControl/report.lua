-----------------------------------------------------------------------------------------
--
-- report.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local database = require("database")
local shapes = require("shapes")
local devices = require("devices")


local _W = display.contentWidth
local _H = display.contentHeight


local scrollView 
local currenProyect
local pName = ""
local tittle
local roomsLoaded,devicesLoaded



--------------------------------------------------------
local workGroup, deviceGroup, textGroup
function change()
	composer.gotoScene( "design",options )
end 

function cleanMemory( )
	for c=1,workGroup.numChildren do
		workGroup[c]:removeSelf()
	end
end


function loadVenuefromData(  )
--	if e.phase == "ended" then
		roomsLoaded=database.loadVenue(pName)
		devicesLoaded = database.loadDevs(pName)
		for i=1,#roomsLoaded do
			local rooo = shapes.loadVenue(workGroup,roomsLoaded[i].tipo,roomsLoaded[i].width,roomsLoaded[i].height,roomsLoaded[i].posx,roomsLoaded[i].posy,roomsLoaded[i].rot,roomsLoaded[i].elements, roomsLoaded[i].desc, roomsLoaded[i].rName )		
			print("nombre del cuarto" .. pName)
		end
		local bigH=0
		local higger=_H/2 +420

		for i = 1 ,workGroup.numChildren do
			local roomTittle = display.newText(workGroup[i].getRoomName() , 100, 50, "arial", 24  )
			workGroup[i]:lock()
			roomTittle.x = _W/2
			roomTittle.y = higger+40

			roomTittle:setFillColor(0)
			textGroup:insert(roomTittle)
			local roomDesc = display.newText([[]]..workGroup[i].getRoomDescription() ..[[]],0,0, _W/2,300,"arial",22,"left" )
			roomDesc.x=_W/2
			roomDesc.y = roomTittle.y + (180)
			roomDesc:setFillColor(0)
			textGroup:insert( roomDesc )
			local deviceList = display.newText(database.getDeviceInRoport(),_W/3,roomDesc.y +(roomDesc.contentHeight/2) +50,300,100,"arial",20,"left" )
			deviceList:setFillColor(0)
			textGroup:insert(deviceList)
			bigH=deviceList.y

			for j=1, #devicesLoaded do
				if(devicesLoaded[j].rName == workGroup[i].getRoomName()   ) then
					local devDesc = display.newText([[-]]..devicesLoaded[j].desc..": "..devicesLoaded[j].coment , _W/3+50,deviceList.y + (50*j) ,_W/2,80,"arial",20,"left" )
					devDesc:setFillColor(0)
					higger=devDesc.y +80
					textGroup:insert(devDesc)

				end
			end
			if deviceList.y> higger then higger=deviceList.y +80 end

		end

		if(higger>bigH) then bigH=higger end
		local dot = display.newCircle(textGroup, 5,bigH+100,2)

		local venueHeight = workGroup.contentHeight

--		for i=1, #devicesLoaded do
--			local devv = devices.spawnDevice(devicesLoaded[i].brand,devicesLoaded[i].tipo,devicesLoaded[i].posx,devicesLoaded[i].posy + venueHeight/2 ,devicesLoaded[i].rName )
--			deviceGroup:insert(devv)
--		end
	
end



function scene:create( event )
	local sceneGroup = self.view
	local background = display.newRect(sceneGroup,0,0,_W,_H)
	background.anchorX=0;background.anchorY=0

	workGroup = display.newGroup()
	deviceGroup = display.newGroup()
	textGroup = display.newGroup()

	tittle = display.newText("Default",100,60,"arial",24)
	tittle.x = _W/2
	tittle.y = 100
	tittle:setFillColor(0)

	local function scrollListener( event )
		local phase = event.phase
		local direction = event.direction
		
		if "began" == phase then
		elseif "moved" == phase then
		elseif "ended" == phase then
		end
		
		if event.limitReached then
			if "up" == direction then
				print( "Reached Top Limit" )
			elseif "down" == direction then
				print( "Reached Bottom Limit" )
			elseif "left" == direction then
				print( "Reached Left Limit" )
			elseif "right" == direction then
				print( "Reached Right Limit" )
			end
		end
				
		return true
	end

	botonVolver = widget.newButton{
		defaultFile="cancelButton.png",	overFile="cancelButton-over.png",
		width=80, height=90,
		strokeWidth=3,
		onRelease = change	-- event listener function
    }
    botonVolver.x =  225
    botonVolver.y =  _H*0.05

	-- Create a ScrollView
	 scrollView = widget.newScrollView
	{
		left =0,
		top = 60,
		width = _W,
		height = _H,
		id = "onBottom",
--		bottomPadding = 50,
		isBounceEnabled=false,
		horizontalScrollingDisabled = true,
		verticalScrollingDisabled = false,
		maskFile = "botones/scrollViewMask-350.png",
		listener = scrollListener
	}
	sceneGroup:insert(scrollView)
	sceneGroup:insert(botonVolver)
	scrollView:insert(tittle)


end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	
		currenProyect = database.getData()
		pName = currenProyect.proyect

	elseif phase == "did" then
	
	tittle.text = pName


	loadVenuefromData()
	scrollView:insert(workGroup)
	scrollView:insert(deviceGroup)
	scrollView:insert(textGroup)
	end	

end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

		roomsLoaded=nil
		devicesLoaded=nil
		print(workGroup.numChildren .. " tg = " .. textGroup.numChildren)
		for i= textGroup.numChildren,1,-1 do
			textGroup[i]:removeSelf()
			print("Cleaning")
			textGroup[i]=nil
		end
		for i=workGroup.numChildren,1,-1 do 
			workGroup[i]:removeSelf()

		end
				scrollView:scrollTo("top",{time=100})
--		for i = 1 , deviceGroup.numChildren do
--			deviceGroup[i]:removeSelf()
--			deviceGroup[i] = nil
--		end
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		
		
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end		

end

function scene:destroy( event )
	local sceneGroup = self.view
	
--	-- Called prior to the removal of scene's "view" (sceneGroup)
--	-- 
--	-- INSERT code here to cleanup the scene	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene

