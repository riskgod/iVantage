class ChangeVariables3ZipColumnTypes < ActiveRecord::Migration
  def up
  	change_table :variable_3zips do |t|
  		t.change :varid_117, :numeric
  		t.change :varid_118, :numeric
  		t.change :varid_119, :numeric
  		t.change :varid_120, :numeric
  		t.change :varid_121, :numeric
  		t.change :varid_122, :numeric
  		t.change :varid_123, :numeric
  		t.change :varid_124, :numeric
  		t.change :varid_125, :numeric
  		t.change :varid_126, :numeric
  		t.change :varid_127, :numeric
  		t.change :varid_128, :numeric
  		t.change :varid_129, :numeric
  		t.change :varid_130, :numeric
  		t.change :varid_131, :numeric
  		t.change :varid_132, :numeric
  		t.change :varid_133, :numeric
  		t.change :varid_134, :numeric
  		t.change :varid_135, :numeric
  		t.change :varid_136, :numeric
  		t.change :varid_137, :numeric
  		t.change :varid_138, :numeric
  		t.change :varid_139, :numeric
  		t.change :varid_140, :numeric
  		t.change :varid_141, :numeric
  		t.change :varid_142, :numeric
  		t.change :varid_143, :numeric
  		t.change :varid_144, :numeric
  		t.change :varid_145, :numeric
  		t.change :varid_146, :numeric
  		t.change :varid_147, :numeric
  	end
  end

  def down
  	change_table :variable_3zips do |t|
  		t.change :varid_117, :integer
  		t.change :varid_118, :integer
  		t.change :varid_119, :integer
  		t.change :varid_120, :integer
  		t.change :varid_121, :integer
  		t.change :varid_122, :integer
  		t.change :varid_123, :integer
  		t.change :varid_124, :integer
  		t.change :varid_125, :integer
  		t.change :varid_126, :integer
  		t.change :varid_127, :integer
  		t.change :varid_128, :integer
  		t.change :varid_129, :integer
  		t.change :varid_130, :integer
  		t.change :varid_131, :integer
  		t.change :varid_132, :integer
  		t.change :varid_133, :integer
  		t.change :varid_134, :integer
  		t.change :varid_135, :integer
  		t.change :varid_136, :integer
  		t.change :varid_137, :integer
  		t.change :varid_138, :integer
  		t.change :varid_139, :integer
  		t.change :varid_140, :integer
  		t.change :varid_141, :integer
  		t.change :varid_142, :integer
  		t.change :varid_143, :integer
  		t.change :varid_144, :integer
  		t.change :varid_145, :integer
  		t.change :varid_146, :integer
  		t.change :varid_147, :integer
  	end
  end
end
