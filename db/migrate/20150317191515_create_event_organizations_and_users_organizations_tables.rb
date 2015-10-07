class CreateEventOrganizationsAndUsersOrganizationsTables < ActiveRecord::Migration
  def change

    	create_table :events_organizations, id: false do |t|
	      t.belongs_to :organization, index: true
	      t.belongs_to :event, index: true
	    end

	    create_table :users_organizations, id: false do |t|
	      t.belongs_to :organization, index: true
	      t.belongs_to :user, index: true
	    end

  end
end
