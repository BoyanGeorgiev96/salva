CREATE TABLE institutiontypes (
	id SERIAL,
	name text NOT NULL,  
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE institutiontypes IS
	'Tipos de instituci�n';
-- P�blica, privada, ONG, otra

CREATE TABLE institutiontitles (
	id SERIAL,
	name text NOT NULL,  
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE institutiontitles IS
	'T�tulo (tipo, primer elemento del nombre) de una instituci�n';
-- Universidad, Escuela, Facultad, Instituto, Departamento, Unidad, Secretar�a, Centro...

CREATE TABLE institutions (  
        id SERIAL,
        name text NOT NULL,
        url  text NULL,
        abbrev text NULL,
	parent_id integer NULL
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	ON DELETE CASCADE           
            	DEFERRABLE,
	institutiontype_id int4 NOT NULL
            	REFERENCES institutiontypes(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	institutiontitle_id int4 NOT NULL
            	REFERENCES institutiontitles(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	address text NULL,
	country_id int4 NOT NULL 
            	REFERENCES countries(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
        state_id int4 NULL
		REFERENCES states(id)
		ON UPDATE CASCADE
		DEFERRABLE,
        city_id int4 NULL
		REFERENCES cities(id)
		ON UPDATE CASCADE
		DEFERRABLE,
	zipcode text NULL,
	phone text NULL,
	fax text NULL,
	administrative_key text NULL,
        other text NULL,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
	UNIQUE(name, country_id, state_id) 
); 
COMMENT ON TABLE institutions IS
	'Instituciones';
COMMENT ON COLUMN institutions.parent_id IS
	'Instituci�n padre, para expresar jerarqu�as (p.ej. UNAM es la 
	instituci�n padre de IIEc)';
COMMENT ON COLUMN institutions.administrative_key IS
	'Si la instituci�n tiene alguna clave en su instituci�n padre, la 
	indicamos aqu�. Lo guardamos s�lo como texto, no buscamos la integridad
	referencial';

CREATE TABLE sectors (
        id SERIAL,
        name text NOT NULL, 
	moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
	UNIQUE(name) 
);
COMMENT ON TABLE sectors IS
	'Una instituci�n pertences a cierto sectores - �cu�les? (tan
	gen�rico como sea posible)';
-- Educaci�n, investigaci�n, salud, energ�ticos, etc.

CREATE TABLE institution_sectors (
	id SERIAL,
	institution_id int4 NOT NULL 
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	ON DELETE CASCADE           
            	DEFERRABLE,
	sector_id int4 NOT NULL 
            	REFERENCES sectors(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
	UNIQUE (institution_id, sector_id)
);
COMMENT ON TABLE institution_sectors IS
	'Relaci�n entre cada una de las instituciones y los sectores a los que pertenece';

