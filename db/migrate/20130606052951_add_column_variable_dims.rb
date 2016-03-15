class AddColumnVariableDims < ActiveRecord::Migration
  def change
  	add_column :variable_dims, :default_checked, :boolean
  end
end
