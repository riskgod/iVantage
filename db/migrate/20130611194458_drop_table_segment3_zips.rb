class DropTableSegment3Zips < ActiveRecord::Migration
  def up
  	drop_table :segment_3zips
  end

  def down
	create_table :segment_3zips do |t|
  		t.string :zip
		t.integer :seg_1
		t.integer :seg_2
		t.integer :seg_3
		t.integer :seg_4
		t.integer :seg_5
		t.integer :seg_6
		t.integer :seg_7
		t.integer :seg_8
		t.integer :seg_9
		t.integer :seg_10
		t.integer :seg_11
		t.integer :seg_12
		t.integer :seg_13
		t.integer :seg_14
		t.integer :seg_15
		t.integer :seg_16
		t.integer :seg_17
		t.integer :seg_18
		t.integer :seg_19
		t.integer :seg_20
		t.integer :seg_21
		t.integer :seg_22
		t.integer :seg_23
		t.integer :seg_24
		t.integer :seg_25
		t.integer :seg_26
		t.integer :seg_27
		t.integer :seg_28
		t.integer :seg_29
		t.integer :seg_30
		t.integer :seg_31
		t.integer :seg_32
		t.integer :seg_33
		t.integer :seg_34
		t.integer :seg_35
		t.integer :seg_36
		t.integer :seg_37
		t.integer :seg_38
		t.integer :seg_39
		t.integer :seg_40
		t.integer :seg_41
		t.integer :seg_42
		t.integer :seg_43
		t.integer :seg_44
		t.integer :seg_45
		t.integer :seg_46
		t.integer :seg_47
		t.integer :seg_48
		t.integer :seg_49
		t.integer :seg_50
		t.integer :seg_51
		t.integer :seg_52
		t.integer :seg_53
		t.integer :seg_54
		t.integer :seg_55
		t.integer :seg_56
		t.integer :seg_57
		t.integer :seg_58

  		t.timestamps
  	end
  end
end
