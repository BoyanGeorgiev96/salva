------------------
--  Escolaridad --
------------------
CREATE TABLE degrees ( 
	id SERIAL NOT NULL,           
    	name text NOT NULL,
    	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE degrees IS
	'Lista de grados acad�micos';
-- T�cnico, licenciatura, maestr�a, doctorado...

CREATE TABLE credentials (
	id SERIAL,
	name text NULL,
	abbrev text NULL,
	moduser_id int4 NULL    -- Use it only to know who has
        	   REFERENCES users(id)    -- inserted, updated or deleted  
           	ON UPDATE CASCADE       -- data into or from this table.
            	DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE credentials IS
	'T�tulos o credenciales que obtiene una persona al titularse en determinada grado acad�mico';
-- Lic., Mat., Fis., Arq., Dr., M. en C., etc.

CREATE TABLE careers (
	id SERIAL,
        name text NOT NULL,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE careers IS
	'Listado de carreras';

CREATE TABLE institutioncareers (
	id SERIAL,
	career_id int4 NOT NULL 
            	REFERENCES careers(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
        abbrev text NULL,
	degree_id int4 NOT NULL 
            	REFERENCES degrees(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	institution_id int4 NOT NULL 
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
        url  text NULL,
        other text NULL,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
	UNIQUE (institution_id, career_id)
);
COMMENT ON TABLE institutioncareers IS
	'Carreras ligadas a las instituci�nes';

CREATE TABLE schoolings (
    id SERIAL,
    user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    institutioncareer_id int4 NOT NULL 
            REFERENCES institutioncareers(id)       
            ON UPDATE CASCADE
            DEFERRABLE,
    credential_id int4 NOT NULL 
            REFERENCES credentials(id)       
            ON UPDATE CASCADE
            DEFERRABLE,
    studentid text NULL,
    startyear int4 NOT NULL,
    endyear   int4 NULL,
    titleholder bool DEFAULT 'f' NOT NULL,
    credits int4 NULL
		CHECK (credits >= 0 AND credits <= 100),
    other text NULL,
    moduser_id int4 NULL    -- Use it only to know who has
           REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
    PRIMARY KEY (id),
    UNIQUE (user_id,  institutioncareer_id),
    CONSTRAINT choose_credits_or_year CHECK 
	(endyear IS NULL OR credits IS NULL OR credits = 100),
    CONSTRAINT valid_period CHECK (startyear < endyear)
);
COMMENT ON TABLE schoolings IS
	'Los diferentes pasos (grados) en la historia acad�mica de un usuario';
COMMENT ON COLUMN schoolings.endyear IS
	'A�o de egreso';
COMMENT ON COLUMN schoolings.studentid IS
	'Matr�cula';
COMMENT ON COLUMN schoolings.titleholder IS
	'�Es ya titulado? (endyear marca �nicamente egreso)';
COMMENT ON COLUMN schoolings.credits IS
	'Porcentaje de cr�ditos - No se reporta si ya egres� (endyear) ';

CREATE TABLE titlemodalities( 
	id SERIAL NOT NULL,
	name char(30) NOT NULL,     
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE titlemodalities IS
	'Modalidad de titulaci�n por medio de la cual alguien puede graduarse';
-- Tesis, Ceneval, tesina, reporte t�cnico, por promedio...


CREATE TABLE professionaltitles (
	id SERIAL,
        schooling_id integer NOT NULL 
             REFERENCES schoolings(id) 
             ON UPDATE CASCADE            
             DEFERRABLE,
        titlemodalities_id integer NOT NULL
             REFERENCES titlemodalities(id)
             ON UPDATE CASCADE                 
             DEFERRABLE,
	professionalid text NULL,
    	year int4 NULL,
	thesistitle text NULL,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (schooling_id)
);
COMMENT ON TABLE professionaltitles IS
	'El usuario est� ya titulado (de cada uno de los grados reportados en
	schooling)? Aqu� van los datos de la titulaci�n';
COMMENT ON COLUMN professionaltitles.professionalid IS
	'C�dula profesional';
COMMENT ON COLUMN professionaltitles.year IS
	'A�o de titulaci�n';
