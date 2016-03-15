class ModifyAgentDims < ActiveRecord::Migration
  def up
  	remove_column :agent_dims, :pif_hvh
  	remove_column :agent_dims, :pif_life
  	remove_column :agent_dims, :rating
  	remove_column :agent_dims, :created_at
  	remove_column :agent_dims, :updated_at
  	remove_column :agent_dims, :BusZip5
  	remove_column :agent_dims, :BusZip3
  end

  def down
  	add_column :agent_dims, :BusZip3, :integer
  	add_column :agent_dims, :BusZip3, :integer
  	add_column :agent_dims, :BusZip3, :integer
  	add_column :agent_dims, :BusZip3, :timestamp
  	add_column :agent_dims, :BusZip3, :timestamp
  	add_column :agent_dims, :BusZip3, :string
  	add_column :agent_dims, :BusZip3, :string
  end
end
