class CreateTopSegmentsByZips < ActiveRecord::Migration
  def change
    create_table :top_segments_by_zips do |t|
    	t.integer :id
    	t.string :zip
    	t.string :first
    	t.string :second
    	t.string :third
    	t.string :fourth
    	t.string :fifth

      t.timestamps
    end
  end
end
