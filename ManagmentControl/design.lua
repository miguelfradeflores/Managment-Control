
-----------------------------------------------------------------------------------------
--
-- design.lua
--
-----------------------------------------------------------------------------------------
local shapes =require("shapes")
local devices = require("devices")
local widget= require("widget")
local composer = require("composer")
local database = require("database")
local scene = composer.newScene()

local _W = display.contentWidth
local _H = display.contentHeight

  -- local options = {
  --     effect = "fade",
  --     time = 50
  -- }


-----Grupos
local grupoRecintos, grupoDispositivos,lowGroup,yamahaGroup,shureGroup,AKGGroup,crownGroup,dbxGroup,jblGroup, loadGroup, saveGroup, deviceGroup
local state 
local lineGroup
local miY,conY,procY,powY,monY
--widgets
local scrollView,saveButton,cancelButton,createAudioRuthButton,ruthButton,unruthButton,homeButton,deleteFilesBotton,loadFilesBotton

--local botonDispositivos,scrollView,botonRecintos,botonAudio,botonGuardar,saveButton,cancelButton,createAudioRuthButton,ruthButton,unruthButton,homeButton,deleteFilesBotton,loadFilesBotton
--native fields

local commentBox,nameVenueField,backToModelsText,saveBoxField,imageFile,nameVenueStaticText,venueCommentText,roomHeightText,roomWidthText
--Variables para atrapar el touch de los objetos tocados cuarto/dispositivos a conectar
local currentRoom,inDevice,outDevice

--Auxiliar files and variables
local defaultFileForLoad = "BasicVenue"
local proyectName = "BasicVenue"

local updater = 0


--Font defineded for the program
local fontDefined = "arial"

--VenuesShapesNames
local Venues = {"sq","t","l","z","hc","d","circ"}
local Shapes = {}
local DevicesModels = {"Shure","Yamaha","AKG","Crown","DBX","JBL"}
local Model={}
local yamahaNames={"01V96i","DSR112","SP2060"}
local yamahaDevices={}
local shureNames = {"SM58"}
local shureDevices = {}
local AKGDevices ={}
local AKGNames = { "DSR800","SR4500","DMSTetrad"  }
local crownDevices = {}
local crownNames = {"CTs1200","CTs3000","CTs4200"}
local dbxDevices = {}
local dbxNames = {"DriveRack4820","DriveRackPA"}
local jblDevices = {}
local jblNames = {"EON610","EON618S"}



local group = display.newGroup()
local workGroup 
local loadFiles
local loadedNames={}
local insideRoom = false
local conectionFlag = true
local allowEdition =true 
-- local currentRooms = {}
local ruthArray ={}
local conectionsCounter = 1
local startX,startY,endX,endY = 0,0,1,1
local micsx,controlx,processx,powerx,monitx=_W/5-30 ,_W/5+100,_W/5+250,_W/5+410,_W/5+530
local micsy,controly,processy,powery,monity=_H/4-40,_H/4-30,_H/4-50,_H/4-50,_H/4-30


-----------------------------------------------------------------------------------------------------------------------
--funciones globales
function showVenues(  )
	grupoRecintos.isVisible=true
	grupoDispositivos.isVisible=false
	yamahaGroup.isVisible=false
	shureGroup.isVisible=false
	AKGGroup.isVisible=false
	crownGroup.isVisible=false
	dbxGroup.isVisible=false
	jblGroup.isVisible=false
	backToModelsText.isVisible=false
	----------hide ruth audio group
	unlockWorkGroup()
	workGroup.isVisible=true
	lineGroup.isVisible=false
		for i=1,deviceGroup.numChildren do
				deviceGroup[i].isVisible=false
		end
	insideRoom=false

	scrollView:setIsLocked( true)
	----------habilita la edicion de los campos de texto
	allowEdition=true
	roomHeightEditor.isVisible=true
	roomWidthEditor.isVisible=true
	roomRotationBox.isVisible=true
	roomDeleteButton:setLabel("deleteRoom")
	roomRotationText.isVisible=true
	roomWidthText.isVisible=true
	roomHeightText.isVisible=true
			


end

function showDevices( )
	grupoRecintos.isVisible=false
	grupoDispositivos.isVisible=true
	yamahaGroup.isVisible=false
	AKGGroup.isVisible=false
	crownGroup.isVisible=false
	dbxGroup.isVisible=false
	jblGroup.isVisible=false
	backToModelsText.isVisible=false

end



function showYamahaDevices( )
	grupoDispositivos.isVisible=false
	backToModelsText.isVisible=true
	yamahaGroup.isVisible=true
end

function showShureDevices( )
	grupoDispositivos.isVisible=false
	backToModelsText.isVisible=true
	shureGroup.isVisible=true
end

function showAKGDevices( )
	grupoDispositivos.isVisible=false
	backToModelsText.isVisible=true
	AKGGroup.isVisible=true
end

function showCrownDevice(  )
	grupoDispositivos.isVisible=false
	backToModelsText.isVisible=true
	crownGroup.isVisible=true
end

function showDbxDevice(  )
	grupoDispositivos.isVisible=false
	backToModelsText.isVisible=true
	dbxGroup.isVisible=true
end

function showJblDevice(  )
	grupoDispositivos.isVisible=false
	backToModelsText.isVisible=true
	jblGroup.isVisible=true
end

function showDevicesByModel( self,e )
	if self.isVisible==true then
		if(e.phase=="ended") then 
			print(self.id)
			if(self.id==1)then
				showShureDevices()
			elseif(self.id ==2) then 
				showYamahaDevices()
			elseif ( self.id ==3) then
				showAKGDevices()
			elseif self.id==4 then
				showCrownDevice()
			elseif self.id==5 then
				showDbxDevice()
			elseif self.id==6 then
				showJblDevice()
		
			end
		end	
	end
	return true 
end
-----------------------------------------------

function countElementsInWorGroup( )
	print("Este grupo tiene " .. workGroup.numChildren)
end
--------------------------------------
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
-----------------------------------------
function lockWorkGroup(  )
	for i =1,workGroup.numChildren do
		workGroup[i]:lock()
	end
end


function unlockWorkGroup(  )
	for i =1,workGroup.numChildren do
		workGroup[i]:unlock()
	end
end


function showSavedvenues( )
	if loadGroup.isVisible==false then
		loadGroup.isVisible=true	
		lockWorkGroup()
		scrollView:setIsLocked(true)
		
		loadFiles = database.loadVenueNames()

		for i=#loadedNames,1,-1 do
			loadedNames[i]:removeSelf()
			loadedNames[i]=nil
		end

		
		for i=1,#loadFiles do
		loadedNames[i] = display.newText(loadGroup ,loadFiles[i], 80,30,fontDefined,15)
		loadedNames[i].x = _W/3
		loadedNames[i].y= (_H/2 -250 ) + (i*50)
		loadedNames[i]:setFillColor(0,0,1)
		loadedNames[i].textName=loadFiles[i]
		loadedNames[i].touch = updateSelectedTextForLoad
		loadedNames[i]:addEventListener("touch", loadedNames[i])
		end




		cancelButton.isVisible=true
	end
end

function biggestY(  )
	if micsy>= controly and micsy>=processy and micsy>=powery and micsy>=monity then
		return micsy
	elseif controly>= micsy and controly>= processy and controly>=powery and controly>=monity then
		return controly
	elseif processy>= micsy and processy>= controly and processy>=powery and processy>= monity then
		return processy
	elseif	powery>=micsy and powery>=processy and powery>=controly and powery>=monity then
		return powery
	else
		return monity
	end
end

function sortDevices(  )
	for i=1,workGroup.numChildren do 

		local bigY = biggestY()
		print( "el valor grande es :"..bigY)
		micsy,controly,processy,powery,monity=bigY,bigY,bigY,bigY,bigY
		for j = 1,deviceGroup.numChildren do 
			if deviceGroup[j]:getRoomName()==workGroup[i]:getRoomName() then
				if deviceGroup[j]:getkind() =="mics" then
					deviceGroup[j]:setX(micsx);deviceGroup[j]:setY(micsy)
					micsy = micsy + 20 + deviceGroup[j].contentHeight
				elseif deviceGroup[j]:getkind()=="control" then
					deviceGroup[j]:setX(controlx);deviceGroup[j]:setY(controly)
					controly = controly + 20 + deviceGroup[j].contentHeight
				elseif deviceGroup[j]:getkind()=="process" then
					deviceGroup[j]:setX(processx);deviceGroup[j]:setY(processy)
					processy = processy + 20 + deviceGroup[j].contentHeight
				elseif deviceGroup[j]:getkind()=="power" then
					deviceGroup[j]:setX(powerx);deviceGroup[j]:setY(powery)
					powery = powery + 20 + deviceGroup[j].contentHeight
				elseif deviceGroup[j]:getkind()=="monit" then
					deviceGroup[j]:setX(monitx);deviceGroup[j]:setY(monity)
					monity = monity +  deviceGroup[j].contentHeight
				end
			end	
		end

	end

				local dt = display.newCircle(15,biggestY()+80,2);dt:setFillColor(0)
				scrollView:insert(dt)
		micsy,controly,processy,powery,monity=_H/4-40,_H/4,_H/4-40,_H/4-40,_H/4-40

end


function hideSavedVenues( )
	loadGroup.isVisible=false	
end

function showSaveGroup( )
	saveGroup.isVisible=true
	saveBoxField.isVisible=true
	lockWorkGroup()

	cancelButton.isVisible=true
	cancelButton.x = _W/3*2+40
	cancelButton.y = _H/4 
end

function cancelSaveLoad( )
	unlockWorkGroup()
	saveGroup.isVisible=false
	saveBoxField.isVisible=false
	loadGroup.isVisible=false
	cancelButton.isVisible=false
	audioGroup.isVisible=false
end


function hideSaveGroup(  )
	saveGroup.isVisible=false
	saveBoxField.isVisible=false
	unlockWorkGroup()
end
----------------------------------------------------ruth audio functions


function checkConection( )
	local conected=false	
	for i=1,#ruthArray do
		if  ruthArray[i].Output==outDevice:getDescription()  and ruthArray[i].Input==inDevice:getDescription() and inDevice~=nil then
			print("Connected")
			conected=true
			break
		end
	end


	return conected
end


function alert( message )
	local alertbox,alertmessage
	local function cleanBox(  )
		alertmessage:removeSelf()
		alertbox:removeSelf()
	end

	alertbox = display.newRoundedRect(_W/2,_H/2,250,80,15);alertbox:setFillColor(0.12,0.4,0.7)
	alertmessage = display.newText(""..message,100,50,fontDefined,15)
	alertmessage.x=alertbox.x;alertmessage.y=alertbox.y
	transition.to(alertbox,{time=1500,onComplete=cleanBox })

end

function drawConections( )
		local midX = math.abs( (startX + endX) / 2)
		local midY = math.abs( (startY + endY) / 2)


		local conection = display.newLine(lineGroup,startX,startY,midX,midY ) ; conection:setStrokeColor(0,1,0);conection.strokeWidth = 4
		conection.room = currentRoom:getRoomName()
		conection.indev=inDevice.getDescription()
		conection.outdev=outDevice.getDescription()
		local conection2 = display.newLine(lineGroup,midX,midY,endX,endY ) ; conection2:setStrokeColor(1,1,0);conection2.strokeWidth = 4
		conection2.room = currentRoom:getRoomName()
		conection.indev=inDevice.getDescription()
		conection.outdev=outDevice.getDescription()
	

		inDevice:useIn()
		outDevice:useOut()
		inDevice:addInFactor()
		outDevice:addOutFactor()
end

function lookConectionsForDraw( ... )
	for i=1,#ruthArray do
			--	local outDev,inDev
			print( "Salida: ".. ruthArray[i].Output  .." Entrada: " .. ruthArray[i].Input .." Room: ".. ruthArray[i].RoomOut  .. " RoomIn ".. ruthArray[i].RoomIn )
				for j= 1,deviceGroup.numChildren do
					if(deviceGroup[j]:getDescription()==ruthArray[i].Output) then
						outDevice=deviceGroup[j]
					end
					if(deviceGroup[j]:getDescription()==ruthArray[i].Input) then
						inDevice=deviceGroup[j]
					end
				end
				--print(outDevice:getDescription() .. " - " .. inDevice:getDescription())
				startX= outDevice:getOutXEdge();startY= outDevice:getOutY()
				endX=inDevice:getInXEdge() ;endY=inDevice:getInY()
				drawConections()
	end	
end

function createRuth(  )
	if (inDevice:getInputs()>0 and outDevice:getOutputs()>0 )then
		ruthArray[conectionsCounter]= {Output=outDevice:getDescription() ,Input=inDevice:getDescription(),RoomOut=outDevice:getRoomName(),RoomIn=inDevice:getRoomName() }
		print( "Salida: ".. ruthArray[conectionsCounter].Output  .." Entrada: " .. ruthArray[conectionsCounter].Input .." Room: ".. ruthArray[conectionsCounter].RoomOut  .. " RoomIn ".. ruthArray[conectionsCounter].RoomIn )
		conectionsCounter=conectionsCounter+1

		drawConections()

		ruthButton.isVisible=false

	elseif (inDevice:getInputs()==0) then
		alert(inDevice:getDescription().. " has no ports avaliable" )

	elseif (outDevice:getInputs()==0) then
		alert(outDevice:getDescription().. " has no ports avaliable" )


	else 
		alert("No ports avaliable to plug ")
	end		

	inDevice:setColors(0,0,1,1)
	
	ruthButton.isVisible=false
	outDevice:setColors(0,0,1,1)
	

end

function disconectRuth( ... )
	for i=1,#ruthArray do
		if(ruthArray[i].Output==outDevice:getDescription() and ruthArray[i].Input==inDevice:getDescription()) then
			table.remove(ruthArray,i)
			break
		end
	end

	inDevice:setColors(0,0,1,1)
	
	outDevice:setColors(0,0,1,1)

	for i =1, deviceGroup.numChildren do
		deviceGroup[i]:resetIOpoints()
	end

	-- outDevice:addOut()
	-- inDevice:addIn()
	 conectionsCounter=conectionsCounter-1

	for i=lineGroup.numChildren,1,-1 do
		lineGroup[i]:removeSelf()

	end

	lookConectionsForDraw()

	unruthButton.isVisible=false


end



-----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
function loadVenuefromData( e )
	if e.phase == "ended" then

		if workGroup.numChildren>0 then
			clearScene()

			
		end 

		local roomsLoaded=database.loadVenue(defaultFileForLoad)
		local devicesLoaded = database.loadDevs(defaultFileForLoad)
		local conectionsLoaded = database.loadConections(defaultFileForLoad)
		for i=1,#roomsLoaded do
			local rooo = shapes.loadVenue(workGroup,roomsLoaded[i].tipo,roomsLoaded[i].width,roomsLoaded[i].height,roomsLoaded[i].posx,roomsLoaded[i].posy,roomsLoaded[i].rot,roomsLoaded[i].elements, roomsLoaded[i].desc, roomsLoaded[i].rName )		
		
		end
		for i=1, #devicesLoaded do
			local devv = devices.spawnDevice2(devicesLoaded[i].brand,devicesLoaded[i].tipo,devicesLoaded[i].posx,devicesLoaded[i].posy,devicesLoaded[i].rName,devicesLoaded[i].coment )
			devv.isVisible=false
			deviceGroup:insert(devv)
		end
		for i=1,#conectionsLoaded do
			ruthArray[conectionsCounter]={Output=conectionsLoaded[i].outDevice ,Input=conectionsLoaded[i].inDevice,RoomOut=conectionsLoaded[i].outRoom,RoomIn=conectionsLoaded[i].inRoom }
			conectionsCounter=conectionsCounter+1
			print(conectionsLoaded[i].outDevice)
		end


	end
	cancelButton.isVisible=false
	hideSavedVenues()
	unlockWorkGroup()
end
-----------------------------------------------deleteFunctionForButton
function deleteVenueFromDatabase( e)
	if(e.phase== "ended") then

		database.deleteProyect(defaultFileForLoad)
		alert("Deleting file "..defaultFileForLoad)
	end

end

-----------------------------------------------------------------------------------------------------------------------
--clean scene function


function clearScene(  )
	for i=workGroup.numChildren,1,-1 do
		workGroup[i]:removeSelf()
		print("limpiando workgroup")
		workGroup[i]=nil
	end
	for i=deviceGroup.numChildren,1,-1 do
		deviceGroup[i]:removeSelf()
		deviceGroup[i]=nil
	end
	for i=lineGroup.numChildren,1,-1 do
		lineGroup[i]:removeSelf()
		lineGroup[i]=nil
	end
	for i=#ruthArray,1,-1 do
		ruthArray[i].Output=nil
		ruthArray[i].Input=nil
		ruthArray[i]=nil
	end

	devices.resetCounters()

	nameVenueField.text = ""
	commentBox.text= "Select a room"
	currentRoom=nil
	inDevice=nil
	outDevice=nil
end


-----------------------------------------
function showRoomDevices()
	if currentRoom~=nil then
		if insideRoom==false then
			insideRoom=true
			lockWorkGroup()
			workGroup.isVisible=false
			lineGroup.isVisible=true
			conectionsGroup.isVisible=true			
			for i=1,deviceGroup.numChildren do
				print(deviceGroup[i].getRoomName() .." " ..currentRoom:getRoomName() )
				if deviceGroup[i].getRoomName() == currentRoom:getRoomName() then
					deviceGroup[i].isVisible=true
				else
					print("what the hell")
				end
			end

		else
			unlockWorkGroup()
			conectionsGroup.isVisible=false
			workGroup.isVisible=true
			--lineGroup.isVisible=false
			for i=1,deviceGroup.numChildren do
					deviceGroup[i].isVisible=false
			end
			-- for i=1,lineGroup.numChildren do
			-- 		lineGroup[i].isVisible=false
			-- end
			insideRoom=false
		end
	else
		print("select a room")
	end
end

function deleteDevice(  )
	print(conectionFlag)
	if conectionFlag==false then
		for i=#ruthArray,1,-1 do
			if (ruthArray[i].Input == outDevice:getDescription() or ruthArray[i].Output==outDevice:getDescription() ) then 
				table.remove(ruthArray,i)
				conectionsCounter=conectionsCounter-1
			end
		end
		for i=deviceGroup.numChildren,1,-1 do
			if deviceGroup[i]:getDescription() == outDevice:getDescription() then
				deviceGroup[i]:removeSelf()
				deviceGroup[i]=nil
				break
			end

		end
		outDevice=nil
		conectionFlag=true
	else	
		for i=#ruthArray,1,-1 do
			if (ruthArray[i].Output== inDevice:getDescription() or ruthArray[i].Input==inDevice:getDescription()) then 
				table.remove(ruthArray,i)
				conectionsCounter=conectionsCounter-1
			end
		end
		for i=deviceGroup.numChildren,1,-1 do
			if deviceGroup[i]:getDescription() == inDevice:getDescription() then
				deviceGroup[i]:removeSelf()
				deviceGroup[i]=nil
				break
			end

		end
	
		inDevice=nil
	conectionFlag=false
	ruthButton.isVisible=false
	unruthButton.isVisible=false

	end
	
	nameVenueField.text=""

	--revisando que ningun cuarto incluya el rack si ya no tiene dispositivos
	for i=1,workGroup.numChildren do
		local numOfDevices=0 
		for j=1, deviceGroup.numChildren do 
			if(workGroup[i]:getRoomName()==deviceGroup[j]:getRoomName() )then
				numOfDevices=numOfDevices+1
			end	
		end	
		if numOfDevices>0 then
			workGroup[i]:addDevice()
		else
			workGroup[i]:hideDevice()
		end	
	end


end

	


function removeRoom()


	for i=#ruthArray,1,-1 do
		if (ruthArray[i].RoomIn== currentRoom:getRoomName() or ruthArray[i].RoomOut==currentRoom:getRoomName() ) then 
			table.remove(ruthArray,i)
			conectionsCounter=conectionsCounter-1
		end
	end

	for i= deviceGroup.numChildren, 1,-1 do
		if deviceGroup[i]:getRoomName() == currentRoom:getRoomName() then
			deviceGroup[i]:removeSelf() 
			deviceGroup[i]=nil
		end	
	end

	for i=1,workGroup.numChildren do
		if(workGroup[i]:getRoomName()==currentRoom:getRoomName() )then
			alert("Room "..currentRoom:getRoomName() .. " deleted")
			workGroup[i]:removeSelf()
				commentBox.text= ""
				nameVenueField.text = "" 
			workGroup[i]=nil

			break
		end
	end
	currentRoom=nil
end

function deleteElement( )
	if insideRoom==true then
		deleteDevice()
	else	
		removeRoom()
	end

end

function showDevicesSorted(  )
	
if currentRoom~=nil then
		if insideRoom==false then
			insideRoom=true
			lockWorkGroup()
			workGroup.isVisible=false
			lineGroup.isVisible=true
			conectionsGroup.isVisible=true			
			sortDevices()

			for i=1,deviceGroup.numChildren do
					deviceGroup[i].isVisible=true
					deviceGroup[i]:resetIOpoints()
			end
			--borrar las lineas de conexiones para desfasarlas al nuevo orden 
		    for i=lineGroup.numChildren,1,-1 do
			 	lineGroup[i]:removeSelf() 
			end
			--redibujar las conexiones ya ordenadas
			lookConectionsForDraw()

			scrollView:setIsLocked( false)

			allowEdition=false

			roomRotationBox.isVisible=false
			roomWidthEditor.isVisible=false
			roomHeightEditor.isVisible=false
			roomDeleteButton:setLabel("deleteDevice")


			roomRotationText.isVisible=false
			roomWidthText.isVisible=false
			roomHeightText.isVisible=false

		end


	else
		print("select a room")
		alert("Select a room First")
	end


end



-----------------------------load image to create a venue sample
function loadImage( ... )
	alert("Search image in galery")
end



---------------------------------------------------guardar proyecto
function saveProyect( )
	if database.proyectExist(proyectName)~=0 then
		alert("Actualizando")
		database.deleteProyect(proyectName)
	else		
			 alert("nuevo")
	end
		 database.createFile(proyectName)

	for i =1,workGroup.numChildren do
		database.saveRoom(proyectName,workGroup[i]:getRoomType() ,workGroup[i]:getRoomWidth(),workGroup[i]:getRoomHeight(),workGroup[i]:getXPoint(),workGroup[i]:getYPoint(),workGroup[i]:getRoomRotation(),workGroup[i]:getRoomDescription(),workGroup[i]:getRoomName())
	end
	for i=1,deviceGroup.numChildren do
		database.saveDevice(proyectName,deviceGroup[i]:getBrand(),deviceGroup[i]:getDeviceId(),deviceGroup[i]:getX(),deviceGroup[i]:getY(),deviceGroup[i]:getRoomName(),deviceGroup[i]:getDescription(),deviceGroup[i]:getComent()  )				
	end

	for i=1,#ruthArray do 
		database.saveConection( proyectName,ruthArray[i].Output,ruthArray[i].Input,ruthArray[i].RoomOut,ruthArray[i].RoomIn )
	end

	if updater==1 then
		transition.to(group,{time=500,onComplete=preReport})
		updater=0
	end


	cancelButton.isVisible=false
	unlockWorkGroup()
	hideSaveGroup( )
end



----------cambio de escenas
function change()
	clearScene()
	composer.gotoScene( "menu",{
      effect = "fade",
      time = 50
  } )
end 

function preReport()
	hideSaveGroup()
	database.setDataProyect( proyectName )
	composer.gotoScene("report", {
      effect = "fade",
      time = 50
  })
end


function showReport(  )
	showSaveGroup()
	updater=1
end
----------mover grupo inferior para la edicion de texto
function moveLowGroup()	
	lowGroup.isVisible=false
	lowGroup.y=lowGroup.y-150
end

----------
 		function createRoom( self, event )
			local t = event.target
			local phase = event.phase
		
			if "began" == phase then
				
				imageRoom=display.newImageRect(self.type.."ShapedVenue.png",200,200)
				imageRoom.isVisible=false
				cancelFigure = display.newImageRect("cancel.png",75,75)
				cancelFigure.x=event.x
				cancelFigure.y=event.y
				display.getCurrentStage():setFocus( t )
				self.isFocus = true
				imageRoom.x=event.x
				imageRoom.y=event.y

			elseif self.isFocus then
				if "moved" == phase then
					if event.x >160 and event.x<_W-100 and event.y>200 and event.y< _H-250 then
						imageRoom.isVisible=true
						cancelFigure.isVisible=false
					else
						imageRoom.isVisible=false
							cancelFigure.isVisible=true
					end
					cancelFigure.x=event.x
					cancelFigure.y=event.y
					imageRoom.x=event.x
					imageRoom.y=event.y
--					t.x = event.x - t.x0
--					t.y = event.y - t.y0
				elseif "ended" == phase or "cancelled" == phase then
					display.getCurrentStage():setFocus( nil )
					self.isFocus = false
					
					if event.x >180 and event.x<_W-100 and event.y>200 and event.y< _H-250 then
						local room=shapes.loadVenue(workGroup,self.type,200,200,event.x,event.y,0,false," ", "room"..(workGroup.numChildren +1) )	

						print(workGroup.numChildren)
					else
						
					end
							imageRoom:removeSelf()
							cancelFigure:removeSelf()
				end
			end
			return true
		end


 		function createDevice( self, event )
			local t = event.target
			local phase = event.phase
		
			if "began" == phase then
				
				imageDevice=display.newImageRect("Devices/"..self.brand.."".. self.type..".png",200,200)
				imageDevice.isVisible=false
				cancelFigure = display.newImageRect("cancel.png",75,75)
				cancelFigure.x=event.x
				cancelFigure.y=event.y
				display.getCurrentStage():setFocus(t)
				self.isFocus = true
				imageDevice.x=event.x
				imageDevice.y=event.y

			elseif self.isFocus then
				if "moved" == phase then
					if event.x >160 and event.x<_W-10 and event.y>200 and event.y< _H-250 then
						imageDevice.isVisible=true
						cancelFigure.isVisible=false
					else
						imageDevice.isVisible=false
							cancelFigure.isVisible=true
					end
					cancelFigure.x=event.x
					cancelFigure.y=event.y
					imageDevice.x=event.x
					imageDevice.y=event.y
--					t.x = event.x - t.x0
--					t.y = event.y - t.y0
				elseif "ended" == phase or "cancelled" == phase then
					display.getCurrentStage():setFocus( nil )
					self.isFocus = false
					
					if event.x >160 and event.x<_W-10 and event.y>200 and event.y< _H-250 then
						if currentRoom~=nil then
							--local dev = devices.spawnDevice(self.brand,self.id,event.x,event.y,currentRoom:getRoomName() )
							local dev = devices.spawnDevice2(self.brand,self.id,event.x,event.y,currentRoom:getRoomName(),"" )
							
							
							deviceGroup:insert(dev)
							--scrollView:insert(dev)
							if insideRoom==false then
								dev.isVisible=false
							else
								dev.isVisible=true
							end
								print("added device, size = " .. deviceGroup.numChildren  )
							currentRoom:addDevice(dev)
							--print("Device added to ".. currentRoom:getRoomName()  )
						else
							print("Select a Room First")
							alert("Select a room first")
						end

					else
						
					end
							imageDevice:removeSelf()
							cancelFigure:removeSelf()
				end
			end
			return true
		end



function scene:create( event )
	local group = self.view
	grupoRecintos = display.newGroup()

	lowGroup = display.newGroup()
	grupoDispositivos = display.newGroup()
	yamahaGroup = display.newGroup()
	shureGroup = display.newGroup()
	AKGGroup = display.newGroup()
	crownGroup = display.newGroup()
	dbxGroup = display.newGroup()
	jblGroup = display.newGroup()
	workGroup = display.newGroup()
	loadGroup = display.newGroup()
	lineGroup = display.newGroup()
	conectionsGroup = display.newGroup()
	saveGroup = display.newGroup()
	deviceGroup = display.newGroup()
	audioGroup = display.newGroup()


	local backGround = display.newRect(0,0,_W,_H)
--	local backGround = display.newImageRect("grid.png",_W,_H)
	backGround.x=_W/2
	backGround.y=_H/2
	backGround:setFillColor(0.45)
	backGround.alpha=0.6


	local topPanel=display.newRect(0,0,_W,100)
	topPanel:setFillColor(0.82)
	topPanel.x=_W/2
	topPanel.anchorY=0

	local leftPanel = display.newRect(0,_H,80,_H-105)
	leftPanel.anchorY=1
	leftPanel.anchorX=0
	leftPanel:setFillColor(0.82)
	leftPanel.strokeWidth=3
	leftPanel:setStrokeColor(0)


	local lowPanel = display.newRoundedRect(150,_H,_W,150,15)
	lowPanel.anchorY=1
	lowPanel.x=_W/2
	lowPanel:setFillColor(0.82)
	lowPanel:setStrokeColor(0)
	lowPanel.strokeWidth=3

	imageFile=display.newRect(  _W/2 +40 ,_H/2 -25 ,_W-90,_H-260)
	imageFile.isVisible=false

	local botonRecintos = widget.newButton{
--		shape="rect",
--		label="add room",		
		labelColor={ default = {0.1}, over={0.5} },
		defaultFile="revenue.png",	overFile="revenue-Selected.png",
		width=80, height=90,
	--	strokeWidth=3,
  --      strokeColor = { default={0,0,0,1}, over={0,0,0,1} },
--	    fillColor = { default={0.75,0.82,0.82,1}, over={1,0.82,0.82,0.4} },
		onRelease = showVenues	-- event listener function
    }
    botonRecintos.x =  50
    botonRecintos.y =  _H*0.05

   	local botonDispositivos = widget.newButton{
		defaultFile="devices.png",	overFile="devices-Selected.png",
		width=80, height=90,
		strokeWidth=3,

		onRelease = showDevices	-- event listener function
    }
    botonDispositivos.x =  140
    botonDispositivos.y =  _H*0.05

	local botonAudio = widget.newButton{
		defaultFile="audioButton.png",	overFile="audioButton-over.png",
		width=80, height=90,
		strokeWidth=3,
		onRelease = showDevicesSorted	-- event listener function
    }
    botonAudio.x =  225
    botonAudio.y =  _H*0.05

	local botonCargar = widget.newButton{
		defaultFile="loadButton.png",	overFile="loadButton-over.png",
		width=80, height=90,
		strokeWidth=3,
		onRelease = showSavedvenues	-- event listener function
    }
    botonCargar.x =  310
    botonCargar.y =  _H*0.05

    local saveButton = widget.newButton{
		defaultFile="saveButton.png",	overFile="saveButton-over.png",
		width=80, height=90,
		strokeWidth=3,
		onRelease = showSaveGroup	-- event listener function
    }
    saveButton.x =  395;  saveButton.y =  _H*0.05

    local reportButton = widget.newButton{
		defaultFile="reportButton.png",	overFile="reportButton-over.png",
		width=80, height=90,
		strokeWidth=3,
		onRelease = showReport	-- event listener function
    }
    reportButton.x =  480;  reportButton.y =  _H*0.05

    imageButton = widget.newButton{
		defaultFile="imageButton.png",	overFile="imageButton-over.png",
		width=80, height=90,
		strokeWidth=3,
		onRelease = loadImage	-- event listener function
    }
    imageButton.x =  _W-125;  imageButton.y =  _H*0.05


    homeButton = widget.newButton{
		defaultFile="homeButton.png",	overFile="homeButton-over.png",
		width=80, height=90,
		strokeWidth=3,
		onRelease = change	-- event listener function
    }
    homeButton.x =  _W-45;  homeButton.y =  _H*0.05


    cancelButton = widget.newButton{
		defaultFile="cancelButton.png",	overFile="cancelButton-over.png",
		width=80, height=80,
		strokeWidth=3,
		onRelease = cancelSaveLoad	-- event listener function
    }
    cancelButton.x =  _W/3*2+40;    cancelButton.y =  _H/4; cancelButton.isVisible=false

    --scroll
	scrollView = widget.newScrollView
	{
		left = 40,
		top = 80,
		width = _W,
		height = _H-260,
		id = "onBottom",
		bottomPadding = 50,
	--	isBounceEnabled=false,
		hideBackground=true,
		horizontalScrollingDisabled = true,
		verticalScrollingDisabled = false,
		maskFile = "botones/scrollViewMask-350.png",
		listener = scrollListener
	}

	group:insert(backGround)
	group:insert(imageFile)
	group:insert(scrollView)
	group:insert(lowGroup)
	group:insert(topPanel)
	
	group:insert(leftPanel)
	group:insert(grupoRecintos)
	group:insert(grupoDispositivos)
	group:insert(yamahaGroup)
	group:insert(shureGroup)
	group:insert(AKGGroup)
	group:insert(crownGroup)
	group:insert(dbxGroup)
	group:insert(jblGroup)
	
	group:insert(botonDispositivos)
	group:insert(botonRecintos)
	group:insert(botonAudio)
	group:insert(botonCargar)
	group:insert(saveButton)
	group:insert(reportButton)
	group:insert(homeButton)
	group:insert(imageButton)



	local function textListener( event )
	    if ( event.phase == "began" ) then
	    	if allowEdition then

	    	end	
	        -- User begins editing "defaultBox"
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	        -- Output resulting text from "defaultBox"
	        print( event.target.text )
	        
	    elseif ( event.phase == "editing" ) then
	     	if allowEdition then 
	     	    if currentRoom~=nil then
			        currentRoom:setRoomDescription(event.target.text)
				end
			else 
				if conectionFlag==false then
					outDevice:setComent(event.target.text)
				elseif conectionFlag==true and inDevice~=nil then
					inDevice:setComent(event.target.text)
				end

			end	
	    end
	end
----------
	local function roomNamesListener( event )

	    if ( event.phase == "began" ) then
	        -- User begins editing "defaultBox"

	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	        
	        if allowEdition then
		        if currentRoom~=nil then

			       	for i=1,deviceGroup.numChildren do
							if deviceGroup[i].getRoomName() == currentRoom:getRoomName() then
								deviceGroup[i]:setRoomName(event.target.text)
							end
					end
				        currentRoom:setRoomName(event.target.text)
			    end
			end

	    elseif ( event.phase == "editing" ) then
	    	if allowEdition==true then
	    	print( event.target.text )
		        if currentRoom~=nil then

			       	for i=1,deviceGroup.numChildren do
							if deviceGroup[i].getRoomName() == currentRoom:getRoomName() then
								deviceGroup[i]:setRoomName(event.target.text)
							end
					end
			        currentRoom:setRoomName(event.target.text)
			    end

			end
	    end
	end
------------listener for the save field
	local function saveProyectNameListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	        -- Output resulting text from "defaultBox"

	        	print(proyectName)
	    elseif ( event.phase == "editing" ) then
	    		        	proyectName= event.target.text
	    end
	end
-------------------------------------listner for the rotation
	local function rotationListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	        -- Output resulting text from "defaultBox"
	    elseif ( event.phase == "editing" ) then
	    	
	    	if(event.target.text~=nil and string.len(event.target.text)>0)  then
		    	if(  tonumber( event.target.text)>=0 and  tonumber(event.target.text)<=360   )  then
		    		currentRoom:setRoomRotation(tonumber( event.target.text) )
		    	else
		    		roomRotationBox.text=tostring( currentRoom:getRoomRotation())
	    			alert("range 0-360" )	
	    		end
	    	end
	    end
	end

-------------------------------------------listener for the height of the room
	local function heightListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	        -- Output resulting text from "defaultBox"
	    elseif ( event.phase == "editing" ) then
	    	
	    	if(event.target.text~=nil and string.len(event.target.text)>0)  then
		    	if(  tonumber( event.target.text)>=50 and  tonumber(event.target.text)<=700   )  then
		    		currentRoom:setRoomHeight(tonumber( event.target.text) )
		    	else
		    		--roomHeightEditor.text=tostring( currentRoom:getRoomHeight())
	    			alert("range 50-700" )	
	    		end
	    	end
	    end
	end
----------------------------------------------------------listener for the wodth of the room
	local function widthListener( event )
	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	        -- Output resulting text from "defaultBox"
	    elseif ( event.phase == "editing" ) then
	    	
	    	if(event.target.text~=nil and string.len(event.target.text)>0)  then
		    	if(  tonumber( event.target.text)>=50 and  tonumber(event.target.text)<=700   )  then
		    		currentRoom:setRoomWidth(tonumber( event.target.text) )

		    	else
		    	--	roomWidthEditor.text="0"
		    		--roomWidthEditor.text=tostring( currentRoom:getRoomWidth())
	    			alert("range 50-700" )	
	    		end
	    	end
	    end
	end


-------------------------------------------------loadGroup settings/delete arrengment

local loadBox = display.newRect(loadGroup,_W/2,_H/2,_W/2,_H/2);loadBox:setFillColor(0.82)
local loadBoxTop = display.newRect(loadGroup,_W/2,_H/4,_W/2,20);loadBoxTop:setFillColor(0,0,1)

local selectedBox = display.newRect(loadGroup, _W*0.4,_H*0.7,150,40)
local selectedFileForLoad = display.newText(loadGroup,"default",80,30,fontDefined,16 )
selectedFileForLoad.x=_W*0.4; selectedFileForLoad.y=_H*0.7
selectedFileForLoad:setFillColor(0)

function updateSelectedTextForLoad(self,e )
	if e.phase=="ended" or e.phase == "cancelled" then
		selectedFileForLoad.text = self.text
		defaultFileForLoad = self.text
	end
end


loadGroup.isVisible=false

	loadFilesBotton = widget.newButton{
		defaultFile="button.png",	overFile="button-over.png",
		width=100, height=50,label="LOAD",
		labelColor={ default = {0.1}, over={0.5} },
		strokeWidth=3,
		onRelease = loadVenuefromData	-- event listener function
    }
   	loadFilesBotton.x =  _W*0.6
    loadFilesBotton.y =  _H*0.7

	deleteFilesBotton = widget.newButton{
		defaultFile="button.png",	overFile="button-over.png",
		labelColor={ default = {0.1}, over={0.5} },
		width=100, height=50,label="DELETE",
		strokeWidth=2,
		onRelease = deleteVenueFromDatabase	-- event listener function
    }
   	deleteFilesBotton.x =  _W*0.6
    deleteFilesBotton.y =  _H*0.45



loadGroup:insert(loadFilesBotton)
loadGroup:insert(deleteFilesBotton)

-------------------saveGroup section

local saveBox = display.newRect(saveGroup,_W/2,_H/2,_W/2,_H/2);saveBox:setFillColor(0.82)
local saveBoxTop = display.newRect(saveGroup,_W/2,_H/4,_W/2,20);saveBoxTop:setFillColor(0,0,1)
local saveTittle = display.newText(saveGroup,"Save Proyect",_W/2,_H/3,200,100,fontDefined,20);saveTittle:setFillColor(0,0,1)
saveBoxField = native.newTextField( _W/3 +10 , _H/2+170, 120, 50 )
saveBoxField.text= proyectName
saveBoxField.size= 12	
saveBoxField.isEditable= true
saveBoxField.isVisible=false
saveBoxField:addEventListener("userInput",saveProyectNameListener)
saveGroup:insert(saveBoxField)

	acceptSaveButton = widget.newButton{
		defaultFile="button.png",	overFile="button-over.png",
		width=80, height=90,label = "SAVE",
		labelColor={ default = {0.1}, over={0.5} },
		strokeWidth=3,
		onRelease = saveProyect	-- event listener function
    }
    acceptSaveButton.x = _W*0.6
    acceptSaveButton.y =  _H*0.7

saveGroup:insert(acceptSaveButton)

hideSaveGroup()
---section for the audio ruth

---------section for the venue group



	for i =1, #Venues do
		Shapes[i] = display.newImageRect(Venues[i].."ShapedVenue.png",80,80)
		Shapes[i].id=i
		Shapes[i].x = 35
		Shapes[i].y = (75)+ (i*100)
		Shapes[i].type=Venues[i]
		Shapes[i]:setFillColor(0)
		Shapes[i].touch=createRoom
		Shapes[i]:addEventListener("touch", Shapes[i])
		print(i)
		grupoRecintos:insert(Shapes[i])

	end

	for i=1,#yamahaNames do
		yamahaDevices[i]= display.newText(yamahaGroup,"-".. yamahaNames[i],80,30,fontDefined,15)
		yamahaDevices[i].x=35
		yamahaDevices[i].y = 175+(i*80)
		yamahaDevices[i].brand = "yamaha" 
		yamahaDevices[i].id = i
		yamahaDevices[i].type = yamahaNames[i]
		yamahaDevices[i]:setFillColor(0)
		yamahaDevices[i].touch = createDevice
		yamahaDevices[i]:addEventListener("touch",yamahaDevices[i])

	end	

	for i=1,#shureNames do
		shureDevices[i] = display.newText(shureGroup,"-".. shureNames[i],80,30,fontDefined,15)
		shureDevices[i].x = 35
		shureDevices[i].y = 175+(i*80)
		shureDevices[i].brand = "shure"
		shureDevices[i].type = shureNames[i]
		shureDevices[i].id = i
		shureDevices[i]:setFillColor(0)
		shureDevices[i].touch = createDevice
		shureDevices[i]:addEventListener("touch",shureDevices[i])
		
	end

	for i=1,#AKGNames do
		AKGDevices[i] = display.newText(AKGGroup,"-".. AKGNames[i],80,30,fontDefined,15)
		AKGDevices[i].x = 35
		AKGDevices[i].y = 175+(i*80)
		AKGDevices[i].brand = "akg"
		AKGDevices[i].type = AKGNames[i]
		AKGDevices[i].id = i
		AKGDevices[i]:setFillColor(0)
		AKGDevices[i].touch = createDevice
		AKGDevices[i]:addEventListener("touch",AKGDevices[i])
	end

	for i=1,#crownNames do
		crownDevices[i] = display.newText(crownGroup,"-".. crownNames[i],80,30,fontDefined,15)
		crownDevices[i].x = 35
		crownDevices[i].y = 175+(i*80)
		crownDevices[i].brand = "crown"
		crownDevices[i].type = crownNames[i]
		crownDevices[i].id = i
		crownDevices[i]:setFillColor(0)
		crownDevices[i].touch = createDevice
		crownDevices[i]:addEventListener("touch",crownDevices[i])
	end

	for i=1,#dbxNames do
		dbxDevices[i] = display.newText(dbxGroup,"-".. dbxNames[i],80,30,fontDefined,10)
		dbxDevices[i].x = 35
		dbxDevices[i].y = 175+(i*80)
		dbxDevices[i].brand = "dbx"
		dbxDevices[i].type = dbxNames[i]
		dbxDevices[i].id = i
		dbxDevices[i]:setFillColor(0)
		dbxDevices[i].touch = createDevice
		dbxDevices[i]:addEventListener("touch",dbxDevices[i])
	end

	for i=1,#jblNames do
		jblDevices[i] = display.newText(jblGroup,"-".. jblNames[i],80,30,fontDefined,15)
		jblDevices[i].x = 35
		jblDevices[i].y = 175+(i*80)
		jblDevices[i].brand = "jbl"
		jblDevices[i].type = jblNames[i]
		jblDevices[i].id = i
		jblDevices[i]:setFillColor(0)
		jblDevices[i].touch = createDevice
		jblDevices[i]:addEventListener("touch",jblDevices[i])
	end

	for i =1, #DevicesModels do
		Model[i] = display.newRect(grupoDispositivos, 0,0,80,60)
		Model[i].id = i
		Model[i]:setFillColor(0.82)
		Model[i].x = 35
		Model[i].y = 75 + (i*100)
		Model[i].textBox = display.newText(grupoDispositivos,">"..DevicesModels[i],80,30,fontDefined,14 )
		Model[i].textBox:setFillColor(0)
		Model[i].textBox.x = 35
		Model[i].textBox.y = 75 + (i*100)
		Model[i].touch=showDevicesByModel
		Model[i]:addEventListener("touch",Model[i])
		
		print(Model[i].id)
	end	

	backToModelsText = display.newText(group,"-Volver a \n marcas",70,50,fontDefined,14)
	backToModelsText.x=35
	backToModelsText.y=175 
	backToModelsText:setFillColor(0)
	backToModelsText.isVisible=false

	function backToModelsText:touch(e)
		print("sdfsdfsd")
		if e.phase=="ended" or e.phase== "cancelled" then
			grupoDispositivos.isVisible=true
			yamahaGroup.isVisible=false
			shureGroup.isVisible=false
			AKGGroup.isVisible=false
			crownGroup.isVisible=false
			dbxGroup.isVisible=false
			jblGroup.isVisible=false
			backToModelsText.isVisible=false	
		end
		return true 
	end

--	backToModelsText.touch=showDevicesAgain
	backToModelsText:addEventListener("touch",backToModelsText)
-------------------------------------------------


---------seccion del panel inferior
	nameVenueField = native.newTextField(_W/3, _H-110,100,50)
	nameVenueField.size=12
	nameVenueField.isVisible=false
	nameVenueField.isEditable=true
	nameVenueField:addEventListener("userInput",roomNamesListener)
	nameVenueStaticText = display.newText("Venue name: ",nameVenueField.x -100,nameVenueField.y,fontDefined,15)
	
	commentBox = native.newTextBox( _W*3/4, _H-80, 150, 100 )
	commentBox.text= "Select a room"
	commentBox.size= 12	
	commentBox.isEditable= true
	commentBox.isVisible=false
	commentBox:addEventListener("userInput",textListener)
	venueCommentText = display.newText("Room Comment:",commentBox.x-10,commentBox.y -55,"fontDefined",15)

	roomRotationBox= native.newTextField(_W/3,_H-60,100,50)
	roomRotationBox.inputType = "number"
	roomRotationBox.size=12
	roomRotationBox.isEditable=true
	roomRotationBox:addEventListener("userInput",rotationListener)
	roomRotationText = display.newText("Rotation",roomRotationBox.x-100,_H-60,fontDefined,15)

	roomWidthEditor=native.newTextField(_W/2+60,_H-100,50,50)
	roomWidthEditor.inputType="number"
	roomWidthEditor.size=12
	roomWidthEditor.isEditable=true
	roomWidthEditor.isVisible=false
	roomWidthEditor:addEventListener("userInput",widthListener)
	roomWidthText = display.newText("Room Width",roomWidthEditor.x-90,roomWidthEditor.y,fontDefined,15)

	roomHeightEditor=native.newTextField(_W/2+60,_H-50,50,50)
	roomHeightEditor.inputType="number"
	roomHeightEditor.size=12
	roomHeightEditor.isEditable=true
	roomHeightEditor.isVisible=false
	roomHeightEditor:addEventListener("userInput",heightListener)
	roomHeightText = display.newText("Room Long",roomHeightEditor.x-90,roomHeightEditor.y,fontDefined,15)
	

	lowGroup:insert(lowPanel)
	lowGroup:insert(commentBox)
	lowGroup:insert(venueCommentText)
	lowGroup:insert(nameVenueStaticText)
	lowGroup:insert(nameVenueField)
	lowGroup:insert(roomRotationText)
	lowGroup:insert(roomRotationBox)
	lowGroup:insert(roomWidthEditor)
	lowGroup:insert(roomHeightEditor)
	lowGroup:insert(roomHeightText)
	lowGroup:insert(roomWidthText)
	----------------------------------------------
	roomDeleteButton = widget.newButton{
	 	defaultFile="button.png",	overFile="button-over.png",
		labelColor={ default = {0.1}, over={0.5} },
	 	width=100, height=40,label = "deleteRoom",
	 	strokeWidth=3,
	 	onRelease = deleteElement	-- event listener function
     }

    roomDeleteButton.x = _W-50
    roomDeleteButton.y = _H-50

	ruthButton = widget.newButton{
		defaultFile="connectButton.png",	overFile="connectButton.png",
		width=40, height=40,
		strokeWidth=3,
		onRelease = createRuth	-- event listener function
    }
    ruthButton.x = _W/2
    ruthButton.y = _H-100
    ruthButton.isVisible=false

	unruthButton = widget.newButton{
		defaultFile="disconnectButton.png",	overFile="disconnectButton.png",
		width=40, height=40,
		strokeWidth=3,
		onRelease = disconectRuth	-- event listener function
    }
    unruthButton.x = _W/2
    unruthButton.y = _H-100
    unruthButton.isVisible=false


    lowGroup:insert(ruthButton)
    lowGroup:insert(unruthButton)
    lowGroup:insert(roomDeleteButton)
end

function scene:show( event )
	local group = self.view
	local phase=event.phase



	if phase == "will" then

		grupoDispositivos.isVisible=false
		yamahaGroup.isVisible=false
		shureGroup.isVisible=false
		AKGGroup.isVisible=false
		crownGroup.isVisible=false 
		dbxGroup.isVisible=false
		jblGroup.isVisible=false
	--	conectionsGroup.isVisible=false
	--	lineGroup.isVisible=false

			scrollView:setIsLocked( true)

		local data = database.getData()
		if data.load == 1 then
			showSavedvenues()
			database.setDataLoad(0)
		end
			nameVenueField.isVisible=false 
			commentBox.isVisible=false
			roomRotationBox.isVisible=false

	elseif phase =="did" then

			nameVenueField.isVisible=true
			commentBox.isVisible=true
			roomRotationBox.isVisible=true
			roomHeightEditor.isVisible=true
			roomWidthEditor.isVisible=true

		state=display.newGroup()

		function state:change( e )
			if e.state=="showInfo" then
				if currentRoom ~= nil then
					currentRoom:setRoomColor(0,0,0,1)	
				end
				nameVenueStaticText.text="Room name :"
				venueCommentText.text = "Room Comment"
				commentBox.text= ""..e.info
				nameVenueField.text = "" .. e.roomN

				currentRoom = e.rm
				roomRotationBox.text=tostring( currentRoom:getRoomRotation())
				roomWidthEditor.text =tostring(currentRoom:getRoomWidth())
				roomHeightEditor.text =tostring(currentRoom:getRoomHeight())

				currentRoom:setRoomColor(218/255,165/255,78/255,0.25)
				print("state informed")
			elseif e.state == "link" then
--				print(e.devIX .." Y: " ..e.devIY)
				if conectionFlag==true then
					conectionFlag=false

					outDevice=e.device
					outDevice:setColors(0,1,0,0.8)
					nameVenueStaticText.text="Device name :"
					venueCommentText.text = "Device Comment"
					commentBox.text= "" ..outDevice:getComent()
					nameVenueField.text = "" .. outDevice:getName()
						
					startX=e.devOX;startY=e.devOY
					ruthButton.isVisible=false
				else
					if(e.device~=outDevice) then
					inDevice = e.device
					inDevice:setColors(1,1,0,0.8)
					conectionFlag=true
					endX=e.devIX;endY=e.devIY
					nameVenueStaticText.text="Device name :"
					venueCommentText.text = "Device Comment"		
					nameVenueField.text=""..inDevice:getName()
					commentBox.text = ""..inDevice:getComent()

					if checkConection() then
						alert("Already connected")
						unruthButton.isVisible=true
						ruthButton.isVisible=false
					else
						unruthButton.isVisible=false
						ruthButton.isVisible=true
					end


					else

	
						alert("Same device selected")
					end
				end


			else 

				commentBox.text= "No room selected "
			end
		end

		shapes.state=state
		devices.state =state
		state:addEventListener("change",state)

	scrollView:insert(lineGroup)
	group:insert(conectionsGroup)
	group:insert(workGroup)
	scrollView:insert(deviceGroup)
	group:insert(audioGroup)
	group:insert(loadGroup)
	group:insert(saveGroup)
	group:insert(cancelButton)
	end
end


function scene:hide( event )
	local group = self.vi000ew
	local phase=event.phase



	if phase == "will" then

			nameVenueField.isVisible=false
			commentBox.isVisible=false
			roomRotationBox.isVisible=false
			roomWidthEditor.isVisible=false
			roomHeightEditor.isVisible=false
	elseif phse =="did" then



	end


end



function scene:destroy( event )
	local sceneGroup = self.view
	

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene

