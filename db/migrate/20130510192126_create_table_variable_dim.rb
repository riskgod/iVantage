class CreateTableVariableDim < ActiveRecord::Migration
  def up
  	create_table :variable_dims do |t|
  		t.integer :var_id
  		t.string :var_name
  		t.string :var_category
  		t.integer :var_parent

  		t.timestamps
  	end
  end

  def down
  	drop_table :variable_dims
  end
end
