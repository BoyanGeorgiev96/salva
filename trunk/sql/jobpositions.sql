-- De acuerdo al manual de categor�as y tabuladores de sueldos de la UNAM
-- se establecen las siguientes tablas

-- Ejemplo de puesto: Un Investigador Ordinario Asociado C de Tiempo Completo:
--     jobpositioncategory: Investigador Ordinario
--     jobpositionlevel: Asociado C TC
--     jobpositiontype: (el ID que corresponda a Investigaci�n)

CREATE TABLE jobpositiontype (  
	id SERIAL,		
	name text NOT NULL,   	
	PRIMARY KEY (id), 	
	UNIQUE (name)           
);
COMMENT ON TABLE jobpositiontype IS 
	'Tipos de personal';
	-- Las cuatro posibilidades que entran a esta tabla son:
	-- Personal acad�mico para docencia: Investigador y t�cnico acad�mico * usa niveles *
	-- Personal acad�mico para investigaci�n: Investigador y t�cnico acad�mico * usa niveles *
	-- Personal administrativo de base * usa ramas *	  
	-- Personal administrativo de confianza	* NO usa niveles NI ramas *  

CREATE TABLE jobpositionlevel (
	id SERIAL,		
	name text NOT NULL,     
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE jobpositionlevel IS 
	'Niveles (para acad�micos) o ramas (para administrativos) de 
	contrataci�n';
-- Nivel A, Nivel B, Nivel C, no usa
-- Rama administrativa, rama obrera, rama...

CREATE TABLE jobpositioncategory (
	id SERIAL,
	name text NOT NULL,
	jobpositiontype_id smallint NOT NULL 
                         REFERENCES jobpositiontype(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	jobpositionlevel_id smallint NOT NULL 
                         REFERENCES jobpositionlevel(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	administrative_id text NULL, 
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE jobpositioncategory IS 
	'Los puestos existentes en la UNAM, dependientes de jobpositiontype y
	jobpositionlevel';
-- Investigador ordinario, t�cnico acad�mico, ...
COMMENT ON COLUMN jobpositioncategory.administrative_id IS
	'ID administrativo de la adscripci�n en la universidad - Lo mantenemos
	�nicamente como descripci�n en texto';

CREATE TABLE contracttype (
	id SERIAL,
	name text NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE contracttype IS 
	'Tipos de contrataci�n ';
-- Definitivo, temporal, Art. 51, ...

CREATE TABLE userjobposition (
	id SERIAL, 
	uid int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
	jobpositioncategory_id smallint NULL 
                         REFERENCES jobpositioncategory(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	startmonth int4 NULL CHECK (startmonth<=12 AND startmonth>=1),
	startyear int4 NOT NULL,
	endmonth int4 NULL CHECK (endmonth<=12 AND endmonth>=1),
	endyear  int4 NULL,
	contracttype_id integer NULL
		REFERENCES contracttype(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	description text NULL,
	institution_id int4 NOT NULL 
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	PRIMARY KEY (id),
	CONSTRAINT valid_duration CHECK (endyear IS NULL OR
	       (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
COMMENT ON TABLE userjobposition IS 
	'Relaci�n entre un usuario y todos los datos que describen a su puesto
	(incluye periodos, para construir la historia laboral)';
COMMENT ON COLUMN userjobposition.jobpositioncategory_id IS
	'Puesto en que labor� en la UNAM - En caso de ser personal por 
	honorarios, queda nulo (no hay cat�logo de puestos por honorarios),
	manejando s�lo la descripci�n, y asociando a la instituci�n adecuada.';

CREATE TABLE stimulustype (
	id SERIAL,
	name text NOT NULL,
	descr text NULL,
	institution_id int4 NOT NULL
		REFERENCES institutions(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE stimulustype IS 
	'Tipos de est�mulos';
COMMENT ON COLUMN stimulustype.name IS 
	'Nombre corto/abreviaci�n del est�mulo';
COMMENT ON COLUMN stimulustype.descr IS 
	'Nombre completo del est�mulo';
COMMENT ON COLUMN stimulustype.institution_id IS 
	'Instituci�n que lo otorga';
-- {PAIPA, Programa de Apoyo a la Incorporaci�n de Personal Acad�mico, UNAM},
-- {PRIDE, Programa de Reconocimiento a la Investigaci�n y Desarrollo
-- Acad�mico, UNAM}, {SNI, Sistema Nacional de Investigadores, CONACyT}, ...

CREATE TABLE stimuluslevel (
	id SERIAL,
	name text NOT NULL,
	stimulustype_id int4 NOT NULL
		REFERENCES stimulustype(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (name, stimulustype_id)
);
COMMENT ON TABLE stimuluslevel IS 
	'Niveles de est�mulos para cada uno de los tipos';
	-- PAIPA: A, B, C, D
	-- PRIDE: A, B, C, D, E
	-- SNI: I, II, III
	-- SNC: ???

CREATE TABLE userstimulus (
	id SERIAL, 
	uid int4 NOT NULL 
            REFERENCES users(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
	stimuluslevel_id smallint NULL 
                         REFERENCES stimuluslevel(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	startmonth int4 NULL CHECK (startmonth<=12 AND startmonth>=1),
	startyear int4 NOT NULL,
	endmonth int4 NULL CHECK (endmonth<=12 AND endmonth>=1),
	endyear  int4 NULL,
	PRIMARY KEY (id),
	CONSTRAINT valid_duration CHECK (endyear IS NULL OR
	       (startyear * 12 + coalesce(startmonth,0)) > (endyear * 12 + coalesce(endmonth,0)))
);
COMMENT ON TABLE userstimulus IS 
	'Est�mulos con que ha contado un usuario, incluyendo nivel, con fecha
	de inicio/t�rmino';

-- NOTA
-- Encontrar un mecanismo para evitar m�s de un nivel de est�mulos del mismo
-- tipo (p.ej. PRIDE A y PRIDE B) en el mismo momento

CREATE TABLE stimulusstatus (
	id SERIAL, 
	name varchar(50) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE(name)
);
COMMENT ON TABLE stimulusstatus IS 
	'Estados de cada cambio de nivel de est�mulos';
-- solicitado, aprobado, rechazado, en proceso

CREATE TABLE stimuluslog (
    id SERIAL, 
    stimulus_id integer NOT NULL 
            REFERENCES userstimulus(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    old_stimulusstatus_id integer NOT NULL 
            REFERENCES stimulusstatus(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    changedate date NOT NULL default now()::date,
    moduser_id integer NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    dbtime timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE stimuluslog IS 
	'Fecha de cambio de estado de solicitudes de nivel est�mulos';

-- Name for the area a user works in - "Departamento de C�mputo", "Unidad
-- de blah", "Secretar�a Fulana", "Direcci�n"
CREATE TABLE adscription (
	id serial,
	name text NOT NULL,
	abbrev text NULL, 
	descr text NULL,
	institution_id int4 NOT NULL
		REFERENCES institutions(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	administrative_id text NULL, -- An ID for the adscription in the
			-- university - we only keep it as text, no
			-- referential integrity is attempted.
	PRIMARY KEY(id),
	UNIQUE(name),
	UNIQUE(abbrev)
);
COMMENT ON TABLE adscription IS 
	'Nombre de las adscripciones registradas';
COMMENT ON COLUMN adscription.administrative_id IS
	'ID administrativo de la adscripci�n en la universidad - Lo mantenemos
	�nicamente como descripci�n en texto';

-- We are stating here the work period, which is also in userjobposition - Why?
-- Because a user might retain his jobposition (category/level/...) but the
-- adscription he works at can be renamed or change.
CREATE TABLE useradscription (
	id SERIAL,
	userjobposition_id int4 NOT NULL 
                         REFERENCES userjobposition(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
	adscription_id int4 NOT NULL 
                         REFERENCES adscription(id)
                         ON UPDATE CASCADE
                         DEFERRABLE,
        name text NULL,
        descr text NULL,
	startmonth int4 NULL CHECK (startmonth<=12 AND startmonth>=1),
	startyear int4 NOT NULL,
	endmonth int4 NULL CHECK (endmonth<=12 AND endmonth>=1),
	endyear  int4 NULL,
	PRIMARY KEY (id)
);
COMMENT ON TABLE useradscription IS 
	'Adscripci�n a la que pertenece un usuario en determinado periodo';
COMMENT ON COLUMN useradscription.name IS
	'Describir el nombre de la participaci�n institucional: Jefe de departamento, Coordinador, etc';
COMMENT ON COLUMN useradscription.descr IS
	'Se usa para describir las funciones o actividades del puesto institucional';
COMMENT ON COLUMN useradscription.startyear IS
	'El periodo aparece tanto aqu� como en userjobposition ya que un 
	usuario puede cambiar de adscripci�n sin cambiar su categor�a';

------
-- Update stimuluslog if there was a status change
------
CREATE OR REPLACE FUNCTION stimulus_update() RETURNS TRIGGER 
SECURITY DEFINER AS '
DECLARE 
BEGIN
	IF OLD.stimulusstatus_id = NEW.stimulusstatus_id THEN
		RETURN NEW;
	END IF;
	INSERT INTO stimuluslog (stimulus_id, old_stimulusstatus_id, 
		moduser_id) 
		VALUES (OLD.id, OLD.stimulusstatus_id, OLD.moduser_id);
        RETURN NEW;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER stimulus_update BEFORE DELETE ON stimulus
	FOR EACH ROW EXECUTE PROCEDURE stimulus_update();
