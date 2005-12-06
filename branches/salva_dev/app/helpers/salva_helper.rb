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
      'dateofbirth' => 'Fecha de nacimiento',
      'birth_country_id' => 'Pa�s donde naci�',
      'birthcity' => 'Ciudad',
      'birth_state_id' => 'Estado',
      'maritalstatu_id' => 'Estado civil',
      'photo' => 'Fotograf�a',
      'other' => 'Otra informaci�n o comentarios adicionales',
      # addresses
      'addresstype_id' => 'Tipo de direcci�n',
      'country_id' => 'Pa�s',
      'postaddress' => 'Direcci�n',
      'state_id' => 'Estado',
      'city' => 'Ciudad',
      'zipcode' => 'C�digo postal',
      'phone' => 'Tel�fono(s)',
      'fax' => 'Fax',
      'movil' => 'Celular o radio',
    }
    
    column[name] ? column[name] : name
  end
  
end
