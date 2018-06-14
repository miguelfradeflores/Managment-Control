module(..., package.seeall)

local _W = display.contentWidth
local _H = display.contentHeight
local sqlite3 = require ("sqlite3")

--Path to store the db file
local pathsql="recursos.sqlite"
local path = system.pathForFile(pathsql, system.DocumentsDirectory)

local empleados = "empleados"
local atributos = "atributos"
local plantillas = "plantillas"
local detalle_plantillas = "detalle_plantillas"
local evaluaciones = "evaluaciones"
local detalle_evaluaciones = "detalle_evaluaciones"
local resultados="resultados"
local lenguaje = "lenguaje"

function createDatabase( )
	--Open the DB to create tables
	 db = sqlite3.open( path ) 
	 -- creacion de tablas
	 local query1 = "create table if not exists " .. empleados.." ( ID_Empleado VARCHAR(25) PRIMARY KEY AUTOINCREMENT,Genero VARCHAR(9),     );"
	 local query2 = "create table if not exists " .. atributos.." ( ID_Atributo integer PRIMARY key AUTOINCREMENT, Nombre VARCHAR(25) not null,Descripcion VARCHAR(70)  );"
	 local query3 = "create table if not exists " .. plantillas.."( ); "
	 local query4 = "create table if not exists " .. detalle_plantillas.."() "
	 local query5 = "create table if not exists " .. evaluaciones.."(ID_Evaluacion int PRIMARY key AUTOINCREMENT, Descripcion VARCHAR(70)  );"
	 local query6 = "create table if not exists " .. detalle_evaluaciones.."() "
	 local query7 = "create table if not exists " .. lenguaje.." (IDLanguage int PRIMARY KEY , language VARCHAR(15),defined integer(2) );"
	 -- modificacion de tablas

	 -- datos para insertar
 	 local sql1 = "insert into "..atributos.." ( Nombre,Descripcion) values('Rendimiento', 'Capacidad de respuesta a las tareas dadas' );"
 	 local sql2 = "insert into ".. atributos.. " ( Nombre,Descripcion) values ('Puntualidad','Ponderacion en base a la respuesta de llegada al horario definido');"


	 --inserciones de tablas
	 db:execute(query2)
	 db:execute(query7)

	 --inserciones de datos
	 db:execute(sql1)
	 db:execute(sql2)



	 db:close()
end

	createDatabase()

function listarAtributos(  )
	db = sqlite3.open( path ) 
	local sql = "SELECT * FROM" ..atributos..";"
	for row in db:nrows(sql) do
		print("".. row.Nombre .. " " .. row.Descripcion)
	end	

	db:close( )
	return true;
end

function agregarAtributos( nom,des )
	db:sqlite3.open()
	local sql = "insert into " .. atributos .. " (Nombre,Descripcion) values("..nom..","..des ..");"
	db:execute( sql )
	db:close( )
	return true;
end

function agregarPersona( params )
	db:sqlite3.open()
	local sql = "insert into ".. empleados .."(  )"
	db:execute( sql )
	db:close( )
	return true;
end


function guardarResultados( params )
	db:sqlite3.open()

	local evalId = obteerEvalID(params.condition)

	local sql = ""
	
end

function obteerEvalID( param )
	db:sqlite3.open()
	local res =1
	local sql = "select * from  " .. evaluaciones .. " where " .. params ";"
	for row in db:nrows(sql) do
		res = row.ID_Evaluacion
	end
	db:close()
	return res
end

function crearPlantilla( params, args )
	db:sqlite3.open()

	local sql = "insert into  ".. plantillas .. " () values(   );"
	local PlantillaID = 1
	for i=1,#args,1 do
		local query = "insert into "..detalle_plantillas .. "(   ) values ("..PlantillaID.." ,"..args[i].AtributoID ..","..args[i].algo .." );" 
	end	

	db:execute(sql)
	db:close()	
end