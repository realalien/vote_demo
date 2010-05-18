class StillUsingRoleRequirement < ActiveRecord::Migration
  def self.up
    drop_table :roles if table_exists? :roles
    drop_table :roles_users if table_exists? :roles_users
    create_table "roles" do |t|
      t.string :name
    end
    
    # generate the join table
    create_table "roles_users", :id => false do |t|
      t.integer "role_id", "user_id"
    end
    add_index "roles_users", "role_id"
    add_index "roles_users", "user_id"
  end

  def self.down
    drop_table "roles"
    drop_table "roles_users"
  end

end
