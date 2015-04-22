# encoding: utf-8
ActiveAdmin.register Stimulustype do
  #menu :parent => I18n.t("active_admin.catalogs")
  menu :parent => 'Catálogos'

  index do 
    column :id
    column :name
    default_actions
  end

  filter :name
  filter :institution

  form do |f|
    f.inputs do
       f.input :name, :as => :string
       f.input :descr, :as => :string
       f.input :institution, :as => :select, :collection => Institution.for_schoolarships
    end
    f.buttons
  end
end
