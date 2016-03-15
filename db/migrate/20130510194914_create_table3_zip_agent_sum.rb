class CreateTable3ZipAgentSum < ActiveRecord::Migration
  def up
  	create_table :zip3_agent_sums do |t|
  		t.string :zip
  		t.text :agent

  		t.timestamps
  	end
  end

  def down
  	drop_table :zip3_agent_sums
  end
end
