class AddZipToRaw < ActiveRecord::Migration
  def change
  	add_column :var_zip_raws, :zip, :string
  end
end
