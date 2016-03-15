class AddCityToAgentDims < ActiveRecord::Migration
  def change
  	add_column :agent_dims, :agent_city, :string
  end
end
