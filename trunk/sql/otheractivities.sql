----------------------
-- Other Activities --
----------------------

-- Actividades de divulgaci�n
-- Actividades de extensi�n
-- Actividades de difusi�n
-- Servicios de apoyo
-- Asesor�as y consultor�as
-- Actividades de docencia
-- Actividades de vinculaci�n
-- Actividades artisticas
-- Otras actividades
CREATE TABLE otheractivitygroups (
	id serial,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE otheractivitygroups IS
	'Listado del grupo al que pertenecen las otras actividades';

CREATE TABLE otheractivitytypes (
	id serial,
	name text NOT NULL,
	abbrev text NULL,
	otheractivitygroup_id int4 NOT NULL   
	    REFERENCES otheractivitygroups(id) 
            ON UPDATE CASCADE 
            DEFERRABLE,
	moduser_id int4 NOT NULL    	     -- Use it only to know who has
	    REFERENCES users(id)             -- inserted, updated or deleted  
            ON UPDATE CASCADE                -- data into or from this table.
            DEFERRABLE,
	dbuser text DEFAULT CURRENT_USER,
	dbtimestamp timestamp DEFAULT now(),
	PRIMARY KEY (id),
	UNIQUE (name),
	UNIQUE (abbrev)
);
COMMENT ON TABLE otheractivitytypes IS
	'Listado de otros tipos de actividades';
-- Actividades de divulgaci�n:
-- Charlas 
-- Debates
-- Jornadas
-- Sesiones
-- Organizaci�n de actividades de divulgaci�n
-- ...
--
-- Actividades de difusi�n:
--  Programas de radio
--  Entrevistas
--  Participaci�n en programas de radio y TV
--  ...
--
-- Actividades de extensi�n:
--  Exhibiciones
--  Presentaciones
--  Excursiones (museos, centros o institutos de investigaci�n, facultades)
--  Visitas guiadas
--  ...
--
-- Servicios de apoyo:
--  Actividades de servicio en su �rea
--  Asesor�as profesionales
--  ...
--
-- Asesor�as y consultor�as
--  A estudiantes
--  A profesores
--  A proyectos de investigaci�n
--  ...
--
-- Actividades de docencia:
--  Servicios de apoyo 
--  Programas de estudios
--  Evaluaci�n de aprendizaje
--  Otras actividades docentes no inclu�das
--
-- Actividades de vinculaci�n
-- Convenios
-- ...
-- 
-- Actividades artisticas
-- ?
--  ....

CREATE TABLE otheractivities( 
    id SERIAL,
    uid int4 NOT NULL            -- Use it only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    otheractivitytypes_id int4 NOT NULL     
            REFERENCES otheractivitytypes(id)
            ON UPDATE CASCADE 
            DEFERRABLE,
    title   text NOT NULL,
    other text  NULL,
    institution_id integer NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    dbuser text DEFAULT CURRENT_USER,
    dbtimestamp timestamp DEFAULT now(),
    PRIMARY KEY (id)
);
COMMENT ON TABLE otheractivities IS
	'Otras actividades acad�micas en las que participan los usuarios';

CREATE TABLE userotheractivities (
   id SERIAL,
   otheractivities_id int4 NOT NULL 
            REFERENCES otheractivities(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   uid int4 NOT NULL 
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   userrole_id int4 NOT NULL 
            REFERENCES userrole(id)
            ON UPDATE CASCADE
            DEFERRABLE,   
   startyear int4 NOT NULL,
   startmonth int4 NULL CHECK (startmonth >= 1 AND startmonth <= 12),
   endyear int4  NULL,
   endmonth int4 NULL CHECK (endmonth >= 1 AND endmonth <= 12),
   dbuser text DEFAULT CURRENT_USER,
   dbtimestamp timestamp DEFAULT now(),
   PRIMARY KEY (id),
   CONSTRAINT valid_duration CHECK (endyear IS NULL OR
	       (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
COMMENT ON TABLE userotheractivities IS
	'Relaci�n entre usuarios y otras actividades acad�micas';
