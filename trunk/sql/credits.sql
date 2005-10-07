CREATE TABLE usercredits (
   id SERIAL,
   uid integer 
       REFERENCES users(id)            
       ON UPDATE CASCADE               
           DEFERRABLE,
   internalusergive_id integer 
             REFERENCES users(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   externalusergive_id integer 
            REFERENCES externalusers(id)            
            ON UPDATE CASCADE               
            DEFERRABLE,
   usergive_is_internal bool,
   other text NULL,
   year  int4 NOT NULL,
   month  smallint NULL,
   PRIMARY KEY (id),
   -- Sanity checks: If this is a full system user, require the user
   -- to be filled in. Likewise for an external one.
   CHECK (usergive_is_internal = 't' OR
	(internalusergive_id IS NOT NULL AND externalusergive_id IS NULL)),
   CHECK (usergive_is_internal = 'f' OR
	(externalusergive_id IS NOT NULL AND internalusergive_id IS NULL))
);
COMMENT ON TABLE usercredits IS 
	'Agradecimientos, cr�ditos y reconocimientos por apoyo t�cnico';
COMMENT ON COLUMN usercredits.usergive_is_internal IS
	'Quien otorga el agradecimiento es usuario interno o externo? 
	Exige (NOT NULL) el tipo de usuario adecuado: externalusergive_id o
	internalusergive_id';

CREATE TABLE usercreditsarticles (
	id SERIAL,
	usercredits_id int4 NOT NULL
            REFERENCES usercredits(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	articles_id int4 NOT NULL
            REFERENCES articles(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (usercredits_id, articles_id)
);
COMMENT ON TABLE usercreditsarticles IS
	'Art�culos producto del trabajo que se est� agradeciendo';

CREATE TABLE usercreditsbooks (
	id SERIAL,
	usercredits_id int4 NOT NULL
            REFERENCES usercredits(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	books_id int4 NOT NULL
            REFERENCES articles(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (usercredits_id, books_id)
);
COMMENT ON TABLE usercreditsbooks IS
	'Libros producto del trabajo que se est� agradeciendo';

CREATE TABLE usercreditschaptersbooks (
	id SERIAL,
	usercredits_id int4 NOT NULL
            REFERENCES usercredits(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	chaptersbooks_id int4 NOT NULL
            REFERENCES chaptersbooks(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (usercredits_id, chaptersbooks_id)
);
COMMENT ON TABLE usercreditschaptersbooks IS
	'Cap�tulos en libro producto del trabajo que se est� agradeciendo';

CREATE TABLE usercreditsconferencetalks (
	id SERIAL,
	usercredits_id int4 NOT NULL
            REFERENCES usercredits(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	conferencetalks_id int4 NOT NULL
            REFERENCES articles(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (usercredits_id, conferencetalks_id)
);
COMMENT ON TABLE usercreditsconferencetalks IS
	'Conferencias producto del trabajo que se est� agradeciendo';

CREATE TABLE usercreditsgenericworks (
	id SERIAL,
	usercredits_id int4 NOT NULL
            REFERENCES usercredits(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	genericworks_id int4 NOT NULL
            REFERENCES articles(id)
            ON UPDATE CASCADE               
            DEFERRABLE,
	PRIMARY KEY (id),
	UNIQUE (usercredits_id, genericworks_id)
);
COMMENT ON TABLE usercreditsgenericworks IS
	'Trabajos gen�ricos producto del trabajo que se est� agradeciendo';
