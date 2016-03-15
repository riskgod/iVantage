class AddThreeColumnsToAgentDims < ActiveRecord::Migration
  def change
  	add_column :agent_dims, :multiline, :float
  	add_column :agent_dims, :retention, :float
  	add_column :agent_dims, :total_premium, :integer
  end
end
