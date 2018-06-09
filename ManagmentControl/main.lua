-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

system.activate( "multitouch" )

display.setStatusBar( display.HiddenStatusBar )
idioma = 1

local extension=".ogg"
local composer = require "composer"
local database = require("database")
  local options = {
      effect = "zoomInOut",
      time = 800
  }

local panel = display.newRect(display.contentWidth/2,display.contentHeight/2,200,300)
panel:setFillColor(0.62)
panel.isVsible=false

local text = display.newText("Elija el idioma",panel.x,panel.y-50,"arial",25)

local function change(  )	
	panel.isVsible=false
	panel:removeEventListener("touch",panel)
	panel:removeSelf()
	text:removeSelf()
	composer.gotoScene( "menu",options )
end 

local function defineLanguage(  )	
	panel.isVsible=false
	panel:removeEventListener("touch",panel)
	panel:removeSelf()
	text:removeSelf()
	composer.gotoScene( "settings",options )
end 


function panel:touch( e )
	if 	e.phase=="began" then
	elseif e.phase=="moved" then
	elseif e.phase == "ended" or e.phase == "cancelled" then
		database.setLanguage()
		change()

	end
	return true
end

panel:addEventListener("touch",panel)

local function selectLanguage(  )
	panel.isVsible=true
end



if database.checkForSavedLanguage() == 0 then
	defineLanguage()
else
	change()
end
