class CreateVariableDims < ActiveRecord::Migration
  def change
    create_table :variable_dims do |t|
	  t.integer  :var_id
	  t.string   :var_name
	  t.string   :var_category
	  t.integer  :var_parent
	  t.datetime :created_at
	  t.datetime :updated_at
	  t.boolean  :control_panel
	  t.integer  :default_rank
    end
  end
end
