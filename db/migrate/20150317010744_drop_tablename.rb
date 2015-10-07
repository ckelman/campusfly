class DropTablename < ActiveRecord::Migration
  def change
  	drop_table :organizers
  end
end
