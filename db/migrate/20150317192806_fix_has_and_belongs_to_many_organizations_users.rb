class FixHasAndBelongsToManyOrganizationsUsers < ActiveRecord::Migration
  def change
	drop_table :users_organizations
	
  	create_table :organizations_users, id: false do |t|
	      t.belongs_to :organization, index: true
	      t.belongs_to :user, index: true
	    end
  end
end
