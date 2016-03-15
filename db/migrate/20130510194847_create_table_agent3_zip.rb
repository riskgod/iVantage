class CreateTableAgent3Zip < ActiveRecord::Migration
  def up
  	create_table :agent_3zips do |t|
  		t.integer :agent_id
  		t.string :zip

  		t.timestamps
  	end
  end

  def down
  	drop_table :agent_3zips
  end
end
