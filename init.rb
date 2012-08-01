require 'redmine'

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'issue'
  require_dependency 'googledocs_user_patch'
  require_dependency 'googledocs_my_controller_patch'
  require_dependency 'googledocs_custom_fields_helper_patch'
  require_dependency 'googledocs_issues_helper_patch'  
  
  Issue::SAFE_ATTRIBUTES << "authsubtoken" if Issue.const_defined? "SAFE_ATTRIBUTES"
  
end

#config.gem 'gdata', :lib => 'gdata'

require_dependency 'google_docs_plugin/hooks'


Redmine::Plugin.register :redmine_google_docs_plugin do
  name 'Redmine Google Docs Plugin plugin'
  author 'Robert Gründler'
  description 'This is a google docs plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/pulse00/redmine_google_docs_plugin'
  author_url 'https://github.com/pulse00'
end

class GoogleDocCustomFieldFormat < Redmine::CustomFieldFormat
  include ApplicationHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper

  def format_as_googledoc(value)
    textilizable (value)
  end

end

Redmine::CustomFieldFormat.map do |fields|
  fields.register GoogleDocCustomFieldFormat.new('googledoc', :label => 'googledoc', :order => 8)
end