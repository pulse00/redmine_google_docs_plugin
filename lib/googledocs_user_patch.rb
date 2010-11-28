require_dependency 'user'
include ActionController::UrlWriter

module GoogleDocsPlugin
  module UserPatch
    def self.included(base) # :nodoc:
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
    end
  
    module ClassMethods
    end
  
    module InstanceMethods
  
  
        def authsub_link(next_url)
        
          client = GData::Client::DocList.new
          secure = false  # set secure = true for signed AuthSub requests
          sess = true
          domain = googledocs_preference(:app_domain)  # force users to login to a Google Apps hosted domain
          return authsub_link = client.authsub_url(next_url, secure, sess, domain)
          
        end
        
        
        def googledocs_preference(attr, set_to = nil)
          prefixed = "googledocs_#{attr}".intern
          v = self.pref[prefixed]
          v = nil if v == ''


          case attr
            when :account_email, :app_domain
              if !v && (!set_to)
                set_to = ''
              end
          
            else
              raise "Unsupported attribute '#{attr}'"
          end

          if set_to
            v = set_to
            self.pref[prefixed] = v
            self.pref.save!            
          end

          return v
        end

    end
  end
end

User.send(:include, GoogleDocsPlugin::UserPatch) unless User.included_modules.include? GoogleDocsPlugin::UserPatch
