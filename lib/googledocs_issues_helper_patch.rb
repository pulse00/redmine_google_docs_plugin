require_dependency 'issues_helper'

module GoogleDocsIssuesHelperPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :render_custom_fields_rows, :google_docs
    end
  end
  
  module InstanceMethods
    
    # adds the gdocs_input css class to make the autocompletion javascript work
    def render_custom_fields_rows_with_google_docs(issue)	
      
      logger.debug "################################  aha "


      logger.debug issue.custom_field_values.size
      logger.debug "################################  ahaasdfa "




      return if issue.custom_field_values.empty?
      ordered_values = []
      half = (issue.custom_field_values.size / 2.0).ceil
      half.times do |i|
        ordered_values << issue.custom_field_values[i]
        ordered_values << issue.custom_field_values[i + half]
      end
      s = "<tr>\n"
      n = 0
      ordered_values.compact.each do |value|
        s << "</tr>\n<tr>\n" if n > 0 && (n % 2) == 0
        if value.custom_field.field_format == 'googledoc'
          s << "\t<th>#{ h(value.custom_field.name) }:</th><td>#{ simple_format_without_paragraph(show_value(value)) }</td>\n"
        else 
          s << "\t<th>#{ h(value.custom_field.name) }:</th><td>#{ simple_format_without_paragraph(h(show_value(value))) }</td>\n"
        end
        n += 1
      end
      s << "</tr>\n"
      s
    end
  end
end

IssuesHelper.send(:include, GoogleDocsIssuesHelperPatch)