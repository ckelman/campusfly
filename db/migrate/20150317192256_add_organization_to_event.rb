class AddOrganizationToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :organization, index: true
  end
end
