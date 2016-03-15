class CreateTimeseries < ActiveRecord::Migration
  def change
    create_table :timeseries do |t|
  	  t.string :zip
  	  t.integer :totalPIF_2012Q1
  	  t.integer :totalPIF_2012Q2
  	  t.integer :totalPIF_2012Q3
  	  t.integer :totalPIF_2012Q4
  	  t.integer :totalPIF_2013Q1

  	  t.integer :PCPIF_2012Q1
  	  t.integer :PCPIF_2012Q2
  	  t.integer :PCPIF_2012Q3
  	  t.integer :PCPIF_2012Q4
  	  t.integer :PCPIF_2013Q1

  	  t.integer :AFPIF_2012Q1
  	  t.integer :AFPIF_2012Q2
  	  t.integer :AFPIF_2012Q3
  	  t.integer :AFPIF_2012Q4
  	  t.integer :AFPIF_2013Q1
  		
  	  t.integer :percentMultiLine_2012Q1
  	  t.integer :percentMultiLine_2012Q2
  	  t.integer :percentMultiLine_2012Q3
  	  t.integer :percentMultiLine_2012Q4
  	  t.integer :percentMultiLine_2013Q1

  	  t.integer :percentRetention_2012Q1
  	  t.integer :percentRetention_2012Q2
  	  t.integer :percentRetention_2012Q3
  	  t.integer :percentRetention_2012Q4
  	  t.integer :percentRetention_2013Q1

      t.timestamps
    end
  end
end
