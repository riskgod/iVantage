class DropRawTables < ActiveRecord::Migration
  def change
  	drop_table :var_zip_raw
  	drop_table :var_zip_raws
  end
end
