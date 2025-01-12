class RemoveTriggerUserStatusUpdateOnUsers < ActiveRecord::Migration[6.1]
  def up
    execute "DROP TRIGGER IF EXISTS userstatus_update ON users"
  end

  def down
    execute "CREATE TRIGGER userstatus_update BEFORE UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE userstatus_update()"
  end
end
