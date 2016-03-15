class AddTableVarZipRaw < ActiveRecord::Migration
  def change
	create_table :var_raw_zips do |t|
    	t.integer :id
    	t.string :zip
    	t.integer :hvh_count
    	t.float :hvh_policies
    	t.integer :ivantage_pif
    	t.integer :agent_count

      t.timestamps
    end
  end
end
