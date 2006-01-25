module SalvaHelper 
  
  def get_cfg(name)
    cfg = { 
      'institution_name' => 'Instituto de F�sica - UNAM',
      'institution_url' => 'http://www.fisica.unam.mx',
      'institution_administrative_key' => '-clave presupuestal-'
    }
    cfg[name] ? cfg[name] : name
  end
  
  def salva_column(name)
    column = { 
      # users
      'login' => 'Usuario',
      'passwd' => 'Contrase�a',
      'userstatus_id' => 'Estado del usuario',
      'email' => 'Correo electr�nico',
      'pkcs7' => 'Certificado para firma digital',
      # personals
      'firstname' => 'Nombre',
      'lastname1' => 'Apellido paterno',
      'lastname2' => 'Apellido materno',
      'sex' => 'Sexo',
      'dateofbirth' => 'Fecha',
      'birth_country_id' => 'Pa�s',
      'birthcity' => 'Ciudad',
      'birth_state_id' => 'Estado',
      'maritalstatus_id' => 'Estado civil',
      'photo' => 'Fotograf�a',
      'other' => 'Informaci�n adicional',
      # addresses
      'addresstype_id' => 'Tipo de direcci�n',
      'postaddress' => 'Direcci�n',
      'country_id' => 'Pa�s',
      'state_id' => 'Estado',
      'city' => 'Ciudad',
      'zipcode' => 'C�digo postal',
      'phone' => 'Tel�fono(s)',
      'fax' => 'Fax',
      'movil' => 'Celular o radio',
      'is_postaddress' => 'Direcci�n postal',
      #books
      'title' => 'T�tulo',
      'authors' => 'Autor(es)',
      'coauthors' => 'Coautor(es)',
      'booklink' => 'P�gina web',
      'country_id' => 'Pa�s',
      'booktype' => 'Tipo de libro',
      'volume_id' => 'Volum�n',
      'orig_language_id' => 'Idioma original',
      'trans_language_id' => 'Traducci�n',
      'numcites' => 'N�mero de citas',
      
    }
    
    column[name] ? column[name] : name
  end

  # Title icon
  def title_icon
    "#{@controller.controller_class_name}_32x32.png"
  end
  
  # Title
  def title
    titles = { 
      'PersonalController' => 'Datos personales',
      'AddressesController' => 'Domicilio(s)',
      'BookController' => 'Libros',
      'ArticlesController' => 'Articles',
    }
   titles[@controller.controller_class_name] ? titles[@controller.controller_class_name] : @controller.controller_class_name
  end
end
