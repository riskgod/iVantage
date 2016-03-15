class CreateSegmentDims < ActiveRecord::Migration
  def change
    create_table :segment_dims do |t|
    	t.integer :id
    	t.integer :segment_id
    	t.string :segment_name
    	t.string :hh_age_range
    	t.string :hh_income
    	t.string :hh_race_ethnicity
    	t.string :urbanicity
    	t.string :hh_education
    	t.string :hh_employment
    	t.float :hh_avg_count
    	t.integer :has_newcar_loan
    	t.integer :has_firsthome_mortgage
    	t.integer :value_401k
    	t.integer :savings_balance

      t.timestamps
    end
  end
end
