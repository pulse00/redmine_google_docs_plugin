require_dependency 'my_controller'

module GoogleDocsPlugin
  module MyControllerPatch
    def self.included(base) # :nodoc:
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development
          after_filter :save_googledocs_preferences, :only => [:account]
        end
    end
  
    module ClassMethods
    end
  
    module InstanceMethods
      def save_googledocs_preferences
        if request.post? && flash[:notice] == l(:notice_account_updated)
          email = (params[:googledocs] ? params[:googledocs][:account_email] : '').to_s
          domain = (params[:googledocs] ? params[:googledocs][:app_domain] : '').to_s          
          
          if email == '' || email.match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
            User.current.googledocs_preference(:account_email, email)
          else
            flash[:error] = "Invalid email address #{email}"
          end
          
          User.current.googledocs_preference(:app_domain, domain)
          
        end
      end
    end
  end
end

MyController.send(:include, GoogleDocsPlugin::MyControllerPatch) unless MyController.included_modules.include? GoogleDocsPlugin::MyControllerPatch
