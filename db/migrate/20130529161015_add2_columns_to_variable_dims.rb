class Add2ColumnsToVariableDims < ActiveRecord::Migration
  def up
  	add_column :variable_dims, :control_panel, :boolean
  	add_column :variable_dims, :default_rank, :integer
  end

  def down
  	remove_column :variable_dims, :control_panel
  	remove_column :variable_dims, :default_rank
  end
end
