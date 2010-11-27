require_dependency 'user'

module GoogleDocsPlugin
  module UserPatch
    def self.included(base) # :nodoc:
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
    end
  
    module ClassMethods
    end
  
    module InstanceMethods
  
        def googledocs_preference(attr, set_to = nil)
          prefixed = "googledocs_#{attr}".intern
          v = self.pref[prefixed]
          v = nil if v == ''


          case attr
            when :account_email
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
