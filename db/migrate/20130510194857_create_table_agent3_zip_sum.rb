class CreateTableAgent3ZipSum < ActiveRecord::Migration
  def up
  	create_table :agent_3zip_sums do |t|
  		t.integer :agent_id
  		t.string :text

  		t.timestamps
  	end
  end

  def down
  	drop_table :agent_3zip_sums
  end
end
