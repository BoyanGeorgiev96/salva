module TableHelper
  def table_list(collection, options = {} )
    header = options[:header]
    columns = options[:columns]
    
    list = []
    collection.each { |row|
      cell = []
      if columns.is_a?Array then
        columns.each { |attr| 
          if row.send(attr) != nil then
            if is_id?(attr) then
              (model, field) = set_belongs_to(attr)
              cell << row.send(model).send(field) if row.send(model) != nil
            else
              cell << row.send(attr) if row.send(attr) != nil
            end
          end
        } 
      else
        row.attributes().each { |key, value| 
          cell << value if key != 'id' and value != nil 
        } 
      end
      cell_content = cell.join(', ').to_s+'.'
      list.push({'id' => row.id, 'cell_content' => cell_content })
    }
    render(:partial => '/salva/list', 
           :locals => { :header => header, :list => list })
  end
  
  def table_show(collection, options = {})
    default_hidden = %w(id dbtime moduser_id user_id created_on updated_on) 
    hidden = options[:hidden]    
    hidden = [ hidden ] unless hidden.is_a?Array
    hidden.each { |attr| default_hidden << attr } if hidden != nil
    
    body = []
    collection.each { |column| 
      attr = column.name
      if !default_hidden.include?(attr) then
        if is_id?(attr) then
          (model, field) = set_belongs_to(attr)
          body << [ attr, @edit.send(model).send(field) ] unless
            @edit.send(model) == nil 
        else
          next if @edit.send(attr) == nil
          if @edit.column_for_attribute(attr).type.to_s == 'boolean' then
            body << [ attr, setbool_tag(attr,@edit.send(attr))] 
          else
            body << [ attr, @edit.send(attr) ] 
          end
        end
      end
    }
    render(:partial => '/salva/show', :locals => { :body => body})
  end
  
  def is_id?(name)
    if name =~/_id$/ then
      true
    end
  end
    
  def set_belongs_to(attr)
    belongs_to = [ attr.sub(/_id$/,''), 'name' ]
    case attr
    when /citizen_/
      belongs_to[1] = 'citizen'
    end
    belongs_to
  end

  def setbool_tag(attr,condition)
    case attr
    when /sex/
      condition ? 'Femenino' : 'Masculino'
    else
      condition ? 'S�' : 'No'
    end
  end
end
