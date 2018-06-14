module(..., package.seeall)

local _W = display.contentWidth
local _H = display.contentHeight
local sqlite3 = require ("sqlite3")

--Path to store the db file
local pathsql="sounddb.sqlite"
local path = system.pathForFile(pathsql, system.DocumentsDirectory)

--tables
local table = "language"
local table1 = "files"
local table2 = "rooms"
local table3 = "devices"
local table4 = "conections"

function createDatabase( )
	--Open the DB to create tables
	 db = sqlite3.open( path ) 
	--TABLES TO STORE THE DATA
	local languageTable = "CREATE TABLE IF NOT EXISTS " .. table .. " (idLanguage integer(2) PRIMARY KEY, language VARCHAR(15),defined integer(2) );"
 	local fileTable = "CREATE TABLE IF NOT EXISTS " .. table1.. " (idFile integer(2) PRIMARY KEY, fileName VARCHAR(50)  );"
 	local roomTable = "CREATE TABLE IF NOT EXISTS " .. table2 .. "(idRoom integer(2) PRIMARY KEY, fileName VARCHAR(50),type VARCHAR(5),roomWidth integer(5),roomHeight integer(5), roomX integer(5),roomY integer(5),roomRotation integer(3), roomElements integer(2),descripcion VARCHAR(500), roomName VARCHAR(30) );"
 	local devicesTable = "CREATE TABLE IF NOT EXISTS " .. table3.. " (idDevice integer(3) PRIMARY KEY,fileName VARCHAR(50),brand VARCHAR(20), deviceType integer(3),deviceX integer(4), deviceY integer(4),   roomName VARCHAR(50), deviceDesc VARCHAR (50),deviceComent VARCHAR(50) );"
 	local conectionsTable = "CREATE TABLE IF NOT EXISTS " .. table4 .. " (idConection integer(20) PRIMARY KEY, fileName VARCHAR(50), device1 VARCHAR(20),device2 VARCHAR(20),roomName1 VARCHAR(15),roomName2 VARCHAR );"

 	--Fill some values into the tables
 	local defaultLenguage = "INSERT INTO ".. table .. " VALUES (1,'English',0);"

 	local definedVenueQuery = "INSERT INTO " .. table1.." 	VALUES (1, 'BasicVenue');"
 	local definedVenueQuery2 = "INSERT INTO " .. table1.." VALUES (2, 'BasicVenue2');"

 	local defaultRoom1 = "INSERT INTO "..table2 .. " VALUES (1,'BasicVenue','l',200,200,340,569,0,0,'El segundo escenario incluye un cuarto para almacenar las consolos de monitoreo','Stage1' );"
  	local defaultRoom1b = "INSERT INTO "..table2 .. " VALUES (2,'BasicVenue','t',200,200,340,400,0,0,'El escenario debe contar con un total de 30 conexiones para los parlantes, las guitarras y otros','Stage2' );"
 	local defaultRoom1c = "INSERT INTO "..table2 .. " VALUES (3,'BasicVenue','sq',200,200,406,508,0,0,'Este sector debera incluir una extension lo suficientemente larga como de 5 metros para las guitarras y bajos','Stage Front' );"
	local defaultRoom1d = "INSERT INTO "..table2 .. " VALUES (3,'BasicVenue','hc',200,200,512,504,0,0,'Dimensiones de 10M de Radio','Pista1 ' );"

	local defaultRoom2b = "INSERT INTO "..table2 .. " VALUES (4,'BasicVenue2','t',200,200,341,259,0,1,'Este cuarto cuenta con 3 toma corrientes','Estudio' );"
 	local defaultRoom2c = "INSERT INTO "..table2 .. " VALUES (5,'BasicVenue2','sq',300,200,512,314,45,0,'Este cuarto cuenta con 3 toma corrientes','Cocina' );"

 	local defaultDevice = "INSERT INTO "..table3 .." VALUES(1,'BasicVenue','yamaha',1,300,300,'Stage1','Consola_1','Consola Principal' ); "
 	local defaultDevice2 = "INSERT INTO "..table3 .." VALUES(2,'BasicVenue','shure',1,400,300,'Stage1','Microfono_1','Usar extension ' ); "

 	local defaultConection = "INSERT INTO "..table4.." VALUES(1, 'BasicVenue','SM58_1','01V96i_1','Stage1','Stage1' );"

--  	insert into empleados (CI,Ciudad,Fecha_Nacimiento,Fecha_Ingreso,Genero,Primer_Apellido,Primer_Nombre,Segundo_Apellido,Segundo_Nombre) values (4345321,'La Paz','1994-05-04','2018-06-06','M','Pastor','Sebastian','Ploskonka',null);
-- insert into empleados (CI,Ciudad,Fecha_Nacimiento,Fecha_Ingreso,Genero,Primer_Apellido,Primer_Nombre,Segundo_Apellido,Segundo_Nombre) values (4345321,'La Paz','1994-05-04','2018-06-06','M','Pastor','Sebastian','Ploskonka',null);
-- insert into empleados (CI,Ciudad,Fecha_Nacimiento,Fecha_Ingreso,Genero,Primer_Apellido,Primer_Nombre,Segundo_Apellido,Segundo_Nombre) values (4345321,'La Paz','1994-05-04','2018-06-06','M','Pastor','Sebastian','Ploskonka',null);
-- insert into empleados (CI,Ciudad,Fecha_Nacimiento,Fecha_Ingreso,Genero,Primer_Apellido,Primer_Nombre,Segundo_Apellido,Segundo_Nombre) values (4345321,'La Paz','1994-05-04','2018-06-06','M','Pastor','Sebastian','Ploskonka',null);
-- insert into empleados (CI,Ciudad,Fecha_Nacimiento,Fecha_Ingreso,Genero,Primer_Apellido,Primer_Nombre,Segundo_Apellido,Segundo_Nombre) values (4345321,'La Paz','1994-05-04','2018-06-06','M','Pastor','Sebastian','Ploskonka',null);
-- insert into empleados (CI,Ciudad,Fecha_Nacimiento,Fecha_Ingreso,Genero,Primer_Apellido,Primer_Nombre,Segundo_Apellido,Segundo_Nombre) values (4345321,'La Paz','1994-05-04','2018-06-06','M','Pastor','Sebastian','Ploskonka',null);
-- insert into empleados (CI,Ciudad,Fecha_Nacimiento,Fecha_Ingreso,Genero,Primer_Apellido,Primer_Nombre,Segundo_Apellido,Segundo_Nombre) values (4345321,'La Paz','1994-05-04','2018-06-06','M','Pastor','Sebastian','Ploskonka',null);




---inserting tables to database and excuting them
  	db:exec( languageTable )
  	db:exec( fileTable)
  	db:exec(roomTable)
  	db:exec(devicesTable)
  	db:exec(conectionsTable)

----executing default language query
  	db:exec( defaultLenguage)
----executing default venues
  	db:exec(definedVenueQuery)
  	db:exec(definedVenueQuery2)
---- executing default rooms for the venues
	db:exec(defaultRoom1)
	db:exec(defaultRoom1b)
	db:exec(defaultRoom1c)
	db:exec(defaultRoom1d)

	db:exec(defaultRoom2b)
	db:exec(defaultRoom2c)

	db:exec(defaultDevice)
	db:exec(defaultDevice2)

	db:exec(defaultConection)

  	db:close()
end

createDatabase()

function checkForSavedLanguage( )
	local value = 0
	db = sqlite3.open( path ) 

	local sqv=	"SELECT * FROM " .. table .. " WHERE idLanguage = 1;"
	for row in db:nrows(sqv) do
		value=row.defined

	end
	db:close()
	return value
end

function setLanguage( idioma)
	
	db = sqlite3.open( path ) 
	
	local updateLanguageQuery ="UPDATE " .. table .. " SET defined = 1,language ='"..idioma.."' WHERE idLanguage = 1;"  

	db:exec( updateLanguageQuery )
	
	db:close()	

end


-- function createFileName( fileName )
-- 	local idDefaultVal = 1
-- 	db = sqlite3.open( path ) 
-- 	local lookIdQuery = "SELECT * FROM ".. table1 .. ";"
-- 	for row in db:nrows(lookIdQuery) do
-- 		print(row.idFile)
-- 	end
-- 	db:close()
-- 	return idDefaultVal
-- end

function loadVenue( name )
	
	local roomList={}
	local k=1
		db = sqlite3.open( path ) 
		print(type(name))
		local sqv = "SELECT * FROM " .. table2.. " WHERE fileName = '".. name .."';"
			for row in db:nrows(sqv) do
				print("get" .. row.descripcion)
				local flag=false
				if row.roomElements == 1 then flag=true end
				roomList[k]={id = row.idRoom,tipo=row.type,posx=row.roomX, posy=row.roomY,width=row.roomWidth,height=row.roomHeight,rot = row.roomRotation, elements=flag, desc=row.descripcion,rName=row.roomName }
				k=k+1
				end
		db:close()
		return roomList
end

function loadDevs( name )
	
	local devList={}
	local k=1
		db = sqlite3.open( path ) 
		print(type(name))
		local sqv = "SELECT * FROM " .. table3.. " WHERE fileName = '".. name .."';"
			for row in db:nrows(sqv) do
		--	 (idDevice ,fileName , deviceType ,deviceX , deviceY ,   roomName ,deviceDesc );"
				devList[k]={id = row.idDevice,brand=row.brand, tipo=row.deviceType ,posx=row.deviceX, posy=row.deviceY,desc=row.deviceDesc,rName=row.roomName,coment = row.deviceComent }
				k=k+1
			end
		db:close()
		return devList
end

function loadConections( name )
	local conList={}
	local k=1
	db= sqlite3.open(path)

	local sql = "SELECT * FROM " .. table4 .. " WHERE fileName = '"..name.."';"
		for row in db:nrows(sql) do
			conList[k] = {id = row.idConection,outDevice=row.device1,inDevice=row.device2,outRoom=row.roomName1,inRoom=row.roomName2}
			k=k+1
		end
	db:close()

	return conList

end

function proyectExist( name )
	local val=0
	db = sqlite3.open(path)
	local query = "Select * FROM "..table1.. " WHERE fileName = '"..name.."';"
	for row in db:nrows(query) do
			val=val+1
	end

	db:close()
	return val
end


function avaliableFileId(  )
	local fileKey=1
	local valid=false
	db=sqlite3.open(path)
		repeat
			local num=0
			local queryId = "SELECT * FROM "..table1.. " WHERE idFile="..fileKey..";"
			for row in db:nrows(queryId) do
				num=num+1
			end
			if (num==0)then
				valid=true
			else
				fileKey=fileKey+1
			end

		until(valid==true)
	
	db:close()

	return fileKey
end



function avaliableRoomId(  )
	local fileKey=1
	local valid=false
	db=sqlite3.open(path)
		repeat
			local num=0
			local queryId = "SELECT * FROM "..table2.. " WHERE idRoom="..fileKey..";"
			for row in db:nrows(queryId) do
				num=num+1
			end
			if (num==0)then
				valid=true
			else
				fileKey=fileKey+1
			end

		until(valid==true)
	
	db:close()

	return fileKey
end



function avaliableDeviceId(  )
	local fileKey=1
	local valid=false
	db=sqlite3.open(path)
		repeat
			local num=0
			local queryId = "SELECT * FROM "..table3.. " WHERE idDevice="..fileKey..";"
			for row in db:nrows(queryId) do
				num=num+1
			end
			if (num==0)then
				valid=true
			else
				fileKey=fileKey+1
			end

		until(valid==true)
	
	db:close()

	return fileKey
end


function loadVenueNames( )
	local venueNames={}
	db = sqlite3.open(path)
	local queryForNames = "SELECT * FROM " .. table1 ..";"
		local iterator =1
		for row in db:nrows(queryForNames) do
			venueNames[iterator] = row.fileName
			iterator=iterator+1
		end


	db:close()
	return venueNames
end


function getId( )
	local fileId=1
	db = sqlite3.open(path)
	local lookIdQuery = "SELECT * FROM ".. table1 .. ";"
	for row in db:nrows(lookIdQuery) do
		print(row.idFile)
		fileId=fileId+1
	end
	db:close()
	return fileId	
end

function createFile( fileName )

	local newFileId= avaliableFileId()

	db = sqlite3.open(path)
 	local newFile = "INSERT INTO " .. table1.." 	VALUES ("..newFileId.."	, '".. fileName.."');"
 	db:exec(newFile)

 	db:close()
end

function getRoomId( )
	local rId=1
	db = sqlite3.open(path)
	local lookIdQuery = "SELECT * FROM ".. table2 .. ";"
	for row in db:nrows(lookIdQuery) do
		print(row.idRoom)
		rId=rId+1
	end
	db:close()
	return rId	
end



function saveRoom( proyName,shape,wi,he,xx,yy,rot,des,rName )
	
	local roomId = avaliableRoomId()
	db = sqlite3.open(path)
	local newRoom = "INSERT INTO "..table2 .. " VALUES ("..roomId..",'"..proyName.."','"..shape.."',"..wi..","..he..","..xx..","..yy..","..rot..",0,'"..des.."','"..rName.."' );"
	db:exec(newRoom)
	db:close()
end

--"(idDevice  ,fileName , deviceType ,deviceX , deviceY ,roomName, deviceDesc  );"

function getDeviceId(  )
	local dId=1
	db = sqlite3.open(path)
	local lookIdQuery = "SELECT * FROM ".. table3 .. ";"
	for row in db:nrows(lookIdQuery) do
		print(row.idDevice)
		dId=dId+1
	end
	db:close()
	return dId		
end

function getConectionId(  )
	local fileKey=1
	local valid=false
	db=sqlite3.open(path)
		repeat
			local num=0
			local queryId = "SELECT * FROM "..table4.. " WHERE idConection="..fileKey..";"
			for row in db:nrows(queryId) do
				num=num+1
			end
			if (num==0)then
				valid=true
			else
				fileKey=fileKey+1
			end

		until(valid==true)
	
	db:close()

	return fileKey
end




function saveDevice( proyName,brand,type,posx,posy,room,desc,coment )
	local deviceId = avaliableDeviceId()
	db = sqlite3.open(path)
	local newDevice = "INSERT INTO "..table3 .. " VALUES ("..deviceId..",'"..proyName.."','"..brand.."'," ..type..","..posx..","..posy..",'"..room.."','"..desc.."','"..coment.."');"
	db:exec(newDevice)
	db:close()
end

function saveConection( proyName,dev1,dev2,room1,room2 )
	local cId = getConectionId()
	db = sqlite3.open(path)
	local newConection = "INSERT INTO "..table4 .. " VALUES ("..cId..",'"..proyName.."','"..dev1.."','" ..dev2.."','"..room1.."','"..room2.."');"
	db:exec(newConection)
	db:close()
end


local mydata = {}

mydata.load=0
mydata.proyect="BasicVenue"

function getData(  )
	return mydata
end

function setDataLoad( value )
	mydata.load = value
end

function setDataProyect( proy )
	mydata.proyect = proy
end


function deleteProyect( proy )
	
	db=sqlite3.open(path)	

	local sqlC = "DELETE FROM " ..table4 .. " WHERE fileName ='"..proy.."';"
	local sqlD = "DELETE FROM " ..table3 .. " WHERE fileName ='"..proy.."';"
	local sqlR = "DELETE FROM " ..table2 .. " WHERE fileName ='"..proy.."';"
	local sqlF = "DELETE FROM " ..table1 .. " WHERE fileName ='"..proy.."';"

	for row in db:nrows(sqlC) do
		print("cleaning")
	end
	for row in db:nrows(sqlD) do
		print("cleaning")
	end
	for row in db:nrows(sqlR) do
		print("cleaning")
	end
	for row in db:nrows(sqlF) do
		print("cleaning")
	end





	db:close()

end



function getLanguage(  )
	db=sqlite3.open(path)	
	local idioma = 0
	local lookIdQuery = "SELECT * FROM ".. table .. ";"
	for row in db:nrows(lookIdQuery) do
		if row.language=="English" then
			idioma=1
		else
			idioma=2
		end	
	end

	db:close()

	return idioma
end


function getMenuBotonNames( idioma )
	if idioma==1 then
		return "New Venue"
	else
		return "Nuevo recinto"	
	end
end

function getMenuBotonNames2( idioma )
	if idioma==1 then
		return "Load Venue"
	else
		return "Cargar recinto"	
	end
end
function getMenuBotonNames3( idioma )
	if idioma==1 then
		return "Credits"
	else
		return "Creditos"	
	end
end
function getMenuBotonNames4( idioma )
	if idioma==1 then
		return "Settings"
	else
		return "Ajustes"	
	end
end

function getDeviceInRoport(  )
	local idioma = getLanguage()
	if idioma==1 then
		return "Devices in Room"
	else
		return "Dispositivos almacenados"	
	end
end


function getCreditsText(  )
	local idioma = getLanguage()
	if idioma==1 then
		return [[	ALL RIGHTS RESERVED TO:
		MARTIN MARCELO LOZA GUTIERREZ
		]]
	else
		return [[	DERECHOS RESERVADOS POR:
		MARTIN MARCELO LOZA GUTIERREZ
		]]	
	end
end










