require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare do
  require_dependency 'issue'
  require_dependency 'googledocs_user_patch'
  require_dependency 'googledocs_my_controller_patch'
  
  Issue::SAFE_ATTRIBUTES << "Authsubtoken" if Issue.const_defined? "SAFE_ATTRIBUTES"
end

config.gem 'gdata', :lib => 'gdata'

require_dependency 'google_docs_plugin/hooks'


Redmine::Plugin.register :redmine_google_docs_plugin do
  name 'Redmine Google Docs Plugin plugin'
  author 'Robert Gründler'
  description 'This is a google docs plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end

class GoogleDocCustomFieldFormat < Redmine::CustomFieldFormat
  include ApplicationHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper

  def format_as_url(value)
    textilizable (value)
  end

  def escape_html?
    false
  end

 
end

Redmine::CustomFieldFormat.map do |fields|
  fields.register GoogleDocCustomFieldFormat.new('googledoc', :label => :label_googledoc, :order => 8)
end
