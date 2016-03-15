class AddZipColumnsToAgentDim < ActiveRecord::Migration
  def change
  	add_column :agent_dims, :BusZip5, :integer
  	add_column :agent_dims, :BusZip3, :integer
  end
end
