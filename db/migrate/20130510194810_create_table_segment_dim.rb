class CreateTableSegmentDim < ActiveRecord::Migration
  def up
  	create_table :segment_dims do |t|
  		t.integer :segment_id
  		t.string :segment_name
  		t.string :age
  		t.integer :income_index
  		t.string :tenure
  		t.string :ethnicity
  		t.string :urbanicity

  		t.timestamps
  	end
  end

  def down
  	drop_table :segment_dims
  end
end
