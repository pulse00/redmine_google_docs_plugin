require_dependency 'custom_fields_helper'

module GoogleDocsCustomFieldsHelperPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :custom_field_tag, :google_docs
    end
  end
  
  module InstanceMethods
    
    # adds the gdocs_input css class to make the autocompletion javascript work
    def custom_field_tag_with_google_docs(name, custom_value)	
      
      case custom_value.custom_field.field_format
        
        when 'googledoc'                  
          custom_field = custom_value.custom_field
          field_name = "#{name}[custom_field_values][#{custom_field.id}]"
          field_id = "#{name}_custom_field_values_#{custom_field.id}"                    
          return text_field_tag(field_name, custom_value.value, {:id => field_id, :class => 'gdocs_input'})
        else          
          return custom_field_tag_without_google_docs(name, custom_value)        
      end
    end
  end
end

CustomFieldsHelper.send(:include, GoogleDocsCustomFieldsHelperPatch)