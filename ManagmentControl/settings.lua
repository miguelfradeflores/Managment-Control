----------------------------------------------------------------------------------------
local composer = require ("composer")
local widget = require ("widget")
local database = require("database")
--Lista de idiomas
local idioma = {"Español", "English"}
--Lista de texto de selección de idioma  
local seleccion = {"Seleccione el idioma:", "Choose the language:", "Selectionnez votre langue:"}                                
--lista de botón de continuar
local botoncontinuar = {"Continuar", "Continue", "Continuer"}
local desp = 1
local _W = display.contentWidth
local _H = display.contentHeight


--Planeación de Pozos
--modoN = 0 
--datosL = 0
--datosC = 0 
--cursoN = 0
--Opciones

--Texto de Botones programa
tipotexto = native.systemFont
tamanotexto = 12
--variable local de texto de selección de idioma
local seleccion1 
--Arreglo de los idiomas, textos y codigo
local casillas = {}
--Función de ocultar idiomas
local function ocultaridiomas()
	for i = 1, #idioma do
		casillas[i].isVisible = false
		casillas[i].idioma.isVisible = false
	end
end
--Función selección de idiomas
local function idiomaelejido(self, event)
	if (event.phase == "ended") then
		ocultaridiomas()
		seleccion1.text = self.seleccion
		bt2:setLabel (self.texto)
		bt1:setLabel (self.botoncontinuar)
		idiomaN = self.numero
		database.setLanguage(self.texto)
	end
end
--Arreglo de crear idiomas
local function idiomas ( group)
	for i = 1, #idioma do
		--Rectangulo blanco
		casillas[i] = display.newRect(_W/2,(_H/2+85)+i*30,160,30)
		--texto idioma dentro del rectangulo
		casillas[i].idioma = display.newText(idioma[i],_W/2,(_H/2+85)+ i*30,native.systemfont, 18)
		casillas[i].idioma:setFillColor(0,0,0)
		--numero del idioma (1,2,3)
		casillas[i].numero = i
		--texto de idioma seleccionado
		casillas[i].texto = idioma[i]
		--texto de seleccion de idioma
		casillas[i].seleccion = seleccion[i]
		--texto del botón continuar
		casillas[i].botoncontinuar = botoncontinuar[i]
		casillas[i].isVisible = false
		casillas[i].idioma.isVisible = false
		casillas[i].touch = idiomaelejido
		casillas[i]:addEventListener("touch",casillas[i])
		group:insert(casillas[i])
		group:insert(casillas[i].idioma)
	end
end
--Función de mostrar idiomas
local function 	mostraridiomas()
	for i = 1, #idioma do
		casillas[i].isVisible = true
		casillas[i].idioma.isVisible = true
	end
end
--Función de desplegar y retraer idiomas
local function desplegaridiomas(event)
	if (event.phase == "ended") then 
		if desp == 1 then
			ocultaridiomas()
			desp = 0  
		else
			mostraridiomas()
			desp = 1
		end
	end
end
--Función de botones
local function continuar( event )
    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
     --   database.setLanguage()
    	composer.gotoScene( "menu", "slideLeft", 200 )
    end
end
--Función escena
local scene = composer.newScene()
--Función para crear nueva ventana de menu
function scene:create(event)
	local sceneGroup = self.view
	--Imagen de portada
	--local titulo = display.newImageRect("Imagenes/MT.png",120,60)
	--titulo.x = 160
	--titulo.y = 80
	--sceneGroup:insert(titulo)	
	local titulo = display.newText("Audio Proyect.",160, 80,Arial, 40)
	titulo:setFillColor(0.4,0.2,0.1)
	titulo.x=_W/2
	sceneGroup:insert(titulo)


	--Texto de selección
	seleccion1 = display.newText("Seleccione el idioma:", 160, 280, native.systemfont, 15)
	seleccion1:setFillColor (0.9)
	seleccion1.x=_W/2
	seleccion1.y=_H/2
	sceneGroup:insert(seleccion1)
	--Botón de Continuar
 	bt1 = widget.newButton
	{   label = "Continuar", 
		fontSize = 15,
		labelColor = {default = {1,1,1}, over = {0,0,0}},    
		onEvent = continuar,
    	emboss = false,    
    	shape="roundedRect",
    	width = 90,    
    	height = 30,
    	cornerRadius = 2,    
    	fillColor = {default = {0,0,0}, over = {1,1,1} },
    	strokeColor = {default = {1,1,1}, over = { 1, 1, 1} }, strokeWidth = 2}
	bt1.x = _W/3*2
	bt1.y = _H/4*3
	sceneGroup:insert(bt1)
	--Botón de idiomas
 	bt2 = widget.newButton
	{	label = "Español",	
		fontSize = 18, 
		labelColor = {default={0,0,0}, over={0,0,0}}, 
		onEvent = desplegaridiomas,	
		emboss = false,
		shape = "Rect",	
		width = 160, 
		height = 30,	
		corerRadius = 1,
		fillColor = { default={ 1, 1, 1 }, over={ 0.9,0.9,0.9} },}
	bt2.x = _W/2
	bt2.y = _H/2 +50
	sceneGroup:insert(bt2)
	--Añadir función de idiomas
	idiomas(sceneGroup)
end
--Función mostrar escena
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	if(phase == "will") then
	elseif (phase == "did") then
	end
end
--Función esconder escena
function scene:hide (event)
	local sceneGroup = self.view
	local phase = event.phase
	if (phase == "will")then
	elseif (phase == "did") then
	end
end
--Función de destruir escena
function scene:destroy (event)
		local seceneGroup = self.view
end
scene:addEventListener ("create", scene)
scene:addEventListener ("show", scene)
scene:addEventListener ("hide", scene)
scene:addEventListener ("destroy", scene)
return scene












