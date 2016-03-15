class UpdateAgentDimsLatestPifData < ActiveRecord::Migration
  def change
  	rename_column :agent_dims, :pif_auto, :pif_allstate_auto
  	rename_column :agent_dims, :pif_home, :pif_allstate_home
  	rename_column :agent_dims, :pif_other_pc, :pif_allstate_otherpc
  	rename_column :agent_dims, :pif_total_ppc, :pif_allstate_financial
  	rename_column :agent_dims, :pif_total_af, :pif_allstate_total
  	rename_column :agent_dims, :total_pif_ivantage, :pif_ivantage_home
  	rename_column :agent_dims, :total_premium, :pif_ivantage_hvh
  	add_column :agent_dims, :pif_ivantage_other, :integer
  	add_column :agent_dims, :pif_ivantage_total, :integer
  	add_column :agent_dims, :premium_ivantage_total, :integer
  end
end
