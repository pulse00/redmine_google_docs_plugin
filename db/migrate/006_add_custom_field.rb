class AddCustomField < ActiveRecord::Migration
  def self.up    
    field = IssueCustomField.new(
                :field_format => 'googledoc',
                :name => 'Google Doc', 
                :is_for_all => 1, 
                :searchable => 1, 
                :is_filter => 1
                )
                
    field.save
  end

  def self.down
  end
end
