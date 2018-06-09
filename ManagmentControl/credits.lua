


-----------------------------------------------------------------------------------------
--
-- composer.lua
--
-----------------------------------------------------------------------------------------
local _W = display.contentWidth
local _H = display.contentHeight

local widget = require("widget")
local database = require("database")
local composer = require( "composer" )
local scene = composer.newScene()



local scrollView
local creds,volverAMenuBoton
local defailtFont = "arial"

  local options = {
      effect = "fade",
      time = 500
  }

function volverAMenu(  )
	composer.gotoScene("menu",options )
end 


function scene:create( event )
	local sceneGroup = self.view




	local function scrollListener( event )
		local phase = event.phase
		local direction = event.direction
		
		if "began" == phase then
			--print( "Began" )
		elseif "moved" == phase then
			--print( "Moved" )
		elseif "ended" == phase then
			--print( "Ended" )
		end
		
		if event.limitReached then
			if "up" == direction then
				print( "Reached Top Limit" )
		--			scrollView:scrollTo("top",{time=10})
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

  scrollView = widget.newScrollView
	{
		left = 0,
		top = 40,
		width = _W,
		height = _H*2,
		id = "onBottom",
		bottomPadding = 50,
	--	isBounceEnabled=false,
		horizontalScrollingDisabled = true,
		verticalScrollingDisabled = false,
		hideBackground=true,
--		maskFile = "botones/scrollViewMask-350.png",
		listener = scrollListener
	}
		sceneGroup:insert(scrollView)


		local txtoption = {
		text= "", 
		x= _W*0.5,
		y= 0,
		width= 500,
		height= 1100,
		font=defailtFont,
		fontSize=25,
		allign="left"

		}


	creds = display.newText(txtoption)
	creds:setFillColor(1,1,0)	
	creds.anchorY = 0


	scrollView:insert(creds)


	volverAMenuBoton = widget.newButton{
 	 	defaultFile="button.png",
	 	overFile="button-over.png",
	 	label="HOME",
		labelColor={ default = {0.1}, over={0.5} },
	 	width=80, height=80,
	 	onRelease = volverAMenu	
	}
	volverAMenuBoton.x=60;	 volverAMenuBoton.y= 60;volverAMenuBoton.alpha=0.7

	sceneGroup:insert(volverAMenuBoton)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	creds.text=database.getCreditsText()


	elseif phase == "did" then



		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.

	end	

end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
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
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene








