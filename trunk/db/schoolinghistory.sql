------------------
--  Escolaridad --
------------------
CREATE TABLE gotdegreetype( 
	id SERIAL NOT NULL,
	name char(30) NOT NULL,     
	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE gotdegreetype IS
	'Modalidad de titulaci�n por medio de la cual alguien puede graduarse';
-- Tesis, Ceneval, tesina, reporte t�cnico, por promedio...

CREATE TABLE academicdegrees ( 
	id SERIAL NOT NULL,           
    	name text NOT NULL,
    	PRIMARY KEY (id),
	UNIQUE (name)
);
COMMENT ON TABLE academicdegrees IS
	'Lista de grados acad�micos';
-- T�cnico, licenciatura, maestr�a, doctorado...

CREATE TABLE subtitles (
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
COMMENT ON TABLE subtitles IS
	'T�tulo que obtiene una persona al titularse de determinada carrera';
-- Lic., Mat., Fis., Arq., Dr., M. en C., etc.

CREATE TABLE academiccareers (
	id SERIAL,
        name text NOT NULL,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
	UNIQUE (name)
);
COMMENT ON TABLE academiccareers IS
	'Listado de carreras';

CREATE TABLE institutionsacadcareers (
	id SERIAL,
        url  text NULL,
        abbrev text NULL,
        other text NULL,
	institution_id int4 NOT NULL 
            	REFERENCES institutions(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	academiccareer_id int4 NOT NULL 
            	REFERENCES academiccareers(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
	academicdegree_id int4 NOT NULL 
            	REFERENCES academicdegrees(id) 
            	ON UPDATE CASCADE           
            	DEFERRABLE,
        moduser_id int4 NULL    -- Use it only to know who has
            REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
        PRIMARY KEY(id),
	UNIQUE (institution_id, academiccareer_id)
);
COMMENT ON TABLE institutionsacadcareers IS
	'Instituci�n a la que pertenece cada una de las carreras de 
	academiccareers';

CREATE TABLE schooling (
    id SERIAL,
    user_id int4 NOT NULL 
            REFERENCES users(id)      
            ON UPDATE CASCADE
            ON DELETE CASCADE   
            DEFERRABLE,
    institutionacadcareer_id int4 NOT NULL 
            REFERENCES institutionsacadcareers(id)       
            ON UPDATE CASCADE
            DEFERRABLE,
    subtitle_id int4 NOT NULL 
            REFERENCES subtitles(id)       
            ON UPDATE CASCADE
            DEFERRABLE,
    startyear int4 NOT NULL,
    endyear   int4 NULL,
    studentid text NULL,
    titleholder bool DEFAULT 'f' NOT NULL,
    other text NULL,
    credits int4 NULL
		CHECK (credits >= 0 AND credits <= 100),
    moduser_id int4 NULL    -- Use it only to know who has
           REFERENCES users(id)    -- inserted, updated or deleted  
            ON UPDATE CASCADE       -- data into or from this table.
            DEFERRABLE,
    PRIMARY KEY (id),
    UNIQUE (user_id,  institutionacadcareer_id),
    CONSTRAINT choose_credits_or_year CHECK 
	(endyear IS NULL OR credits IS NULL OR credits = 100),
    CONSTRAINT valid_period CHECK (startyear < endyear)
);
COMMENT ON TABLE schooling IS
	'Los diferentes pasos (grados) en la historia acad�mica de un usuario';
COMMENT ON COLUMN schooling.endyear IS
	'A�o de egreso';
COMMENT ON COLUMN schooling.studentid IS
	'Matr�cula';
COMMENT ON COLUMN schooling.titleholder IS
	'�Es ya titulado? (endyear marca �nicamente egreso)';
COMMENT ON COLUMN schooling.credits IS
	'Porcentaje de cr�ditos - No se reporta si ya egres� (endyear) ';

CREATE TABLE titlesholding (
	id SERIAL,
        schoolinghistory_id integer NOT NULL 
             REFERENCES schooling(id) 
             ON UPDATE CASCADE            
             DEFERRABLE,
        gotdegreetype_id integer NOT NULL
             REFERENCES gotdegreetype(id)
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
	UNIQUE (schoolinghistory_id)
);
COMMENT ON TABLE titlesholding IS
	'El usuario est� ya titulado (de cada uno de los grados reportados en
	schooling)? Aqu� van los datos de la titulaci�n';
COMMENT ON COLUMN titlesholding.professionalid IS
	'C�dula profesional';
COMMENT ON COLUMN titlesholding.year IS
	'A�o de titulaci�n';
