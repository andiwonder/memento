class UpdateEvents < ActiveRecord::Migration
  def change
  	add_column :events, :event_type, :string
  	add_column :events, :location, :string
  	add_column :events, :unique_id, :string
  end
end
