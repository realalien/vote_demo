class CreateRoleForDeclarativeAuthorization < ActiveRecord::Migration
def self.up
     drop_table :roles if table_exists? :roles
     create_table "roles" do |t|
       t.column :title, :string
       t.references :user
     end
   end

   def self.down
     drop_table "roles"
   end
	
end
