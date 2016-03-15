class CreateVarZipRaws < ActiveRecord::Migration
  def change
    create_table :var_zip_raws do |t|
      t.integer :HVH_count
      t.float :HVH_policies
      t.integer :ivantage_PIF
      t.integer :agent_count

      t.timestamps
    end
  end
end
