class ChangeSegmentdimsIncomeindexDatatype < ActiveRecord::Migration
  def up
  	change_table :segment_dims do |t|
  		t.change :income_index, :text
  	end
  end

  def down
  	change_table :segment_dims do |t|
  		t.change :income_index, :integer
  	end
  end
end
