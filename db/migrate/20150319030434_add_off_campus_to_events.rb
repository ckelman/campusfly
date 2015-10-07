class AddOffCampusToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :off_campus, :boolean
  end
end
