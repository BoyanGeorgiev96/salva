module SalvaHelper 

  def get_cfg(key)
    labels = { 
      'institution_name' => 'Instituto de F�sica - UNAM',
      'institution_url' => 'http://www.fisica.unam.mx',
      'institution_administrative_key' => '-clave presupuestal-'
    }

    labels[key] if labels[key]
  end
  
  def salva_column(key)
    labels = { 
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
      'other' => 'Otra informaci�n o comentarios adicionales'
    }
    
    labels[key] if labels[key]
  end
  
end
