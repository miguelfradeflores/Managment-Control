-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------
-- Your code here


local database = require("database")
local widget= require("widget")
local composer = require( "composer" )
local scene = composer.newScene()

local _W = display.contentWidth
local _H = display.contentHeight

  local options = {
      effect = "fade",
      time = 500
  }


function change(  )
	composer.gotoScene( "design",options )
end 

function changeToCreds(  )
	composer.gotoScene( "credits",options )
end 

function changeToReport(  )
	database.setDataLoad(1)
	composer.gotoScene( "design",options )
end 

function changeToSettings(  )
	
	composer.gotoScene( "settings",options )
end 





---widgets
local goToDesignButton,goToCredsButton,goToReportButton,goToSettingsButton

function scene:create( event )
	local group = self.view

	local backGround = display.newImageRect("fondo2.jpg",_W,_H)
	backGround.x=_W/2
	backGround.y=_H/2

	goToDesignButton = widget.newButton{
		label="New venue",		
		labelColor={ default = {0.1}, over={0.5} },
		defaultFile="button.png",	overFile="button-over.png",
		width=150, height=90,

		onRelease = change	-- event listener function
    }
    goToDesignButton.x =  _W*0.33
    goToDesignButton.y =  _H*0.26 ;goToDesignButton.isVisible=true

	goToCredsButton = widget.newButton{
		label="Credits",		
		labelColor={ default = {0.1}, over={0.5} },
		defaultFile="button.png",	overFile="button-over.png",
		width=150, height=90,


		onRelease = changeToCreds	
    }
    goToCredsButton.x =  _W*0.33
    goToCredsButton.y =  _H*0.86 

	goToSettingsButton = widget.newButton{
		label="Settings",		
		labelColor={ default = {0.1}, over={0.5} },
		defaultFile="button.png",	overFile="button-over.png",
		width=150, height=90,


		onRelease = changeToSettings	
    }
    goToSettingsButton.x =  _W*0.67
    goToSettingsButton.y =  _H*0.86 


	goToReportButton = widget.newButton{
		label="Load venue",		
		labelColor={ default = {0.1}, over={0.5} },
		defaultFile="button.png",	overFile="button-over.png",
		width=150, height=90,


		onRelease = changeToReport	
    }
    goToReportButton.x =  _W*0.67
    goToReportButton.y =  _H*0.26 



	group:insert(backGround)
	group:insert(goToDesignButton)
	group:insert(goToCredsButton)
	group:insert(goToReportButton)
	group:insert(goToSettingsButton)

end

function scene:show( event )
	local group = self.view
	local phase=event.phase

	if phase == "will" then
		local idioma = database.getLanguage()
		goToDesignButton:setLabel( database.getMenuBotonNames(idioma))
		goToReportButton:setLabel(database.getMenuBotonNames2(idioma))
		goToCredsButton:setLabel(database.getMenuBotonNames3(idioma))
		goToSettingsButton:setLabel(database.getMenuBotonNames4(idioma))
	elseif phse =="did" then

	end


end


function scene:hide( event )
	local group = self.view
	local phase=event.phase

	if phase == "will" then


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

