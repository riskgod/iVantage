class AddVarZipRawTable < ActiveRecord::Migration
def change
    create_table :var_zip_raw do |t|
    	t.integer :hvh_count
    	t.float :hvh_policies
    	t.integer :ivantage_pif
    	t.integer :agent_count
    	
      t.timestamps
    end
  end
end




