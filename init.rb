require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare do
  require_dependency 'googledocs_user_patch'
  require_dependency 'googledocs_my_controller_patch'
end

require_dependency 'google_docs_plugin/hooks'

Redmine::Plugin.register :redmine_google_docs_plugin do
  name 'Redmine Google Docs Plugin plugin'
  author 'Robert Gründler'
  description 'This is a google docs plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
