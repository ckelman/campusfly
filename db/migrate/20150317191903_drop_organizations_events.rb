class DropOrganizationsEvents < ActiveRecord::Migration
  def change
  	drop_table :events_organizations
  end
end
