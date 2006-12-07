CREATE TABLE genericworkgroups (
	id serial,
	name text NOT NULL,
	moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE genericworkgroups IS
	'Listado del grupo al que pertenecen las trabajos genericos:
	Productos de divulgaci�n
	Productos de extensi�n y difusi�n
	Publicaciones internas
	Productos de docencia
	Otro';


CREATE TABLE genericworktypes (
	id serial,
	name text NOT NULL,
	abbrev text NULL,
	genericworkgroup_id int4 NOT NULL 
	    REFERENCES genericworkgroups(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
        moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
        created_on timestamp DEFAULT CURRENT_TIMESTAMP,
        updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name,genericworkgroup_id)
);
COMMENT ON TABLE genericworktypes IS 
	'Tipos de trabajos gen�ricos que manejamos:

	Productos de divulgaci�n:
	Reportes t�cnicos p�blicos
	Art�culos In extenso
	Art�culos en memorias
	Art�culos o ensayos en revistas
	Divulgaci�n de la ciencia
	Nota de investigaci�n
	Rese�a
	...

	Productos de extensi�n y difusi�n:
	Colecciones (infantiles, impresos)
	....

	Publicaciones:
	Reportes t�cnicos
	Reporte interno
	Gaceta
	...

	Productos de docencia:
	Antolog�a
	Antolog�a critica
	Gu�a de estudio
	Notas de clase
	Cuadernos
	Manual de apoyo docente
	Catalogos
	...

	Otro:
	Traducci�n de art�culo
	 ...
       ';

CREATE TABLE genericworkstatuses (
	id serial,
	name text NOT NULL,
	moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE genericworkstatuses IS 
	'Estado de un trabajo gen�rico:
	Propuesto, enviado, aceptado, en prensa, publicado, ..';

CREATE TABLE genericworks ( 
    id SERIAL,
    title   text NOT NULL,
    authors text NOT NULL,
    genericworktype_id int4 NOT NULL     
            REFERENCES genericworktypes(id)
            ON UPDATE CASCADE 
            DEFERRABLE,
    genericworkstatus_id int4 NOT NULL     
            REFERENCES genericworkstatuses(id)
            ON UPDATE CASCADE 
            DEFERRABLE,
    institution_id integer NULL 
	    REFERENCES institutions(id)
	    ON UPDATE CASCADE
	    DEFERRABLE,
    publisher_id int4 NULL 
            	REFERENCES publishers(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
    reference text NULL,
    vol text NULL,
    pages text NULL,
    year int4 NOT NULL,
    month int4 NULL CHECK (month >= 1 AND month <= 12),
    isbn_issn text NULL,
    other text NULL,
    moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE genericworks IS 
	'Trabajos gen�ricos (publicaciones no contempladas en otros 
	apartados del sistema)';
COMMENT ON COLUMN genericworks.isbn_issn IS
	'Dependiendo del tipo de trabajo, puede recibir n�mero ISBN o ISSN';
	
CREATE TABLE user_genericworks (
   id SERIAL,
   genericwork_id int4 NOT NULL 
            REFERENCES genericworks(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   user_id integer 
            REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   userrole_id integer NOT NULL 
            REFERENCES userroles(id)
            ON UPDATE CASCADE
            DEFERRABLE,
   moduser_id int4 NULL               	    -- Use it to known who
            REFERENCES users(id)            -- has inserted, updated or deleted
            ON UPDATE CASCADE               -- data into or  from this table.
            DEFERRABLE,
   created_on timestamp DEFAULT CURRENT_TIMESTAMP,
   updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (genericwork_id, user_id, userrole_id)  -- Un usuario podr�a tener m�s de un rol
);
COMMENT ON TABLE user_genericworks IS 
	'Rol de cada uno de los usuarios involucrados en un trabajo gen�rico';


CREATE TABLE genericworkslog (
    id SERIAL, 
    genericwork_id integer NOT NULL 
            REFERENCES genericworks(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
            DEFERRABLE,
    old_genericworkstatus_id integer NOT NULL 
            REFERENCES genericworkstatuses(id)
            ON UPDATE CASCADE
            DEFERRABLE,
    changedate date NOT NULL default now()::date,
    moduser_id integer NULL      -- It will be used only to know who has
            REFERENCES users(id) -- inserted, updated or deleted  
            ON UPDATE CASCADE    -- data into or from this table.
            DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE genericworkslog IS
	'Estado actual (y bit�cora) de un trabajo gen�rico - Cu�ndo fue
	 enviado, cu�ndo fue aceptado, etc.';

------
-- Update usergenericworkslog if there was a status change
------
-- CREATE OR REPLACE FUNCTION usergenericworks_update() RETURNS TRIGGER 
-- SECURITY DEFINER AS '
-- DECLARE 
-- BEGIN
-- 	IF OLD.genericworkstatus_id = NEW.genericworkstatus_id THEN
-- 		RETURN NEW;
-- 	END IF;
-- 	INSERT INTO usergenericworkslog (usergenericworks_id, 
-- 		old_usergenericworkstatus_id, moduser_id) VALUES
-- 		(OLD.id, OLD.genericworkstatus_id, OLD.moduser_id);
--         RETURN NEW;
-- END;
-- ' LANGUAGE 'plpgsql';

-- CREATE TRIGGER usergenericworks_update BEFORE DELETE ON usergenericworks
-- 	FOR EACH ROW EXECUTE PROCEDURE usergenericworks_update();
