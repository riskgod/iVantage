class ChangeAgentDimColumnTypes < ActiveRecord::Migration
  def up
  	change_table :agent_dims do |t|
  	  t.change :tier_allstate, :string
  	  t.change :tier_ivantage, :string
  	  t.change :BusZip5, :string
  	  t.change :BusZip3, :string
  	end
  end

  def down
  	change_table :agent_dims do |t|
  	  t.change :tier_allstate, :integer
  	  t.change :tier_ivantage, :integer
  	  t.change :BusZip5, :integer
  	  t.change :BusZip3, :integer
  	end
  end
end
