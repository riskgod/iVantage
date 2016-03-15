class ModifyAgentDimsTotalPifTotalPremium < ActiveRecord::Migration
  def change
  	rename_column :agent_dims, :total_premium, :total_pif_ivantage
  	add_column :agent_dims, :total_premium, :integer
  end
end
