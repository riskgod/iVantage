class AddColumnsToAgentDims < ActiveRecord::Migration
  def change
  	add_column :agent_dims, :pif_other_pc, :integer
  	add_column :agent_dims, :pif_total_ppc, :integer
  	add_column :agent_dims, :pif_total_af, :integer
  	add_column :agent_dims, :busZip5, :string
  	add_column :agent_dims, :busZip3, :string
  	add_column :agent_dims, :created_at, :datetime
  	add_column :agent_dims, :updated_at, :datetime
  end
end
