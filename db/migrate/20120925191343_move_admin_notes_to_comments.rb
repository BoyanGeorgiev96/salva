class MoveAdminNotesToComments < ActiveRecord::Migration[6.1]
  def self.up
    remove_index  :admin_notes, name: 'index_admin_notes_on_user_type_and_user_id'
    rename_table  :admin_notes, :active_admin_comments
    rename_column :active_admin_comments, :user_type, :author_type
    rename_column :active_admin_comments, :user_id, :author_id
    add_column    :active_admin_comments, :namespace, :string
    add_index     :active_admin_comments, [:namespace]
    add_index     :active_admin_comments, [:author_type, :author_id]

    # Update all the existing comments to the default namespace
    say "Updating any existing comments to the #{ActiveAdmin.application.default_namespace} namespace."
    execute "UPDATE active_admin_comments SET namespace='#{ActiveAdmin.application.default_namespace}'"
  end

  def self.down
    remove_index  :active_admin_comments, :column => [:author_type, :author_id]
    remove_index  :active_admin_comments, :column => [:namespace]
    remove_column :active_admin_comments, :namespace
    rename_column :active_admin_comments, :author_id, :user_id
    rename_column :active_admin_comments, :author_type, :user_type
    rename_table  :active_admin_comments, :admin_notes
    add_index     :admin_notes, [:user_type, :user_id]
  end
end
