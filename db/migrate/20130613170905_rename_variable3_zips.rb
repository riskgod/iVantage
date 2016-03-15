class RenameVariable3Zips < ActiveRecord::Migration
  def change
  	rename_table :variable3_zips, :variable_3zips_5zips
  end


end
