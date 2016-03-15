class DropTesttableIfexists < ActiveRecord::Migration
  def up
  	drop_table :test if self.table_exists?("test")
  end

  def down
  end
end
