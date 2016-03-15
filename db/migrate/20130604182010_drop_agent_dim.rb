class DropAgentDim < ActiveRecord::Migration
  def up
  	drop_table :agent_dims
  end

  def down
  	create_table :agent_dims do |t|
  		t.integer :agent_id
  		t.string :agent_name
  		t.integer :tier_ivantage
  		t.integer :tier_allstate
  		t.string :tenure
  		t.integer :pif_hvh
  		t.integer :pif_auto
  		t.integer :pif_home
  		t.integer :pif_life
  		t.integer :rating
  		
  		t.timestamps
  	end
  end
end
