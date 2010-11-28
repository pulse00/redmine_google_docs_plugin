module GoogleDocsPlugin
  
  module Hooks
   
   class LayoutHook < Redmine::Hook::ViewListener
     
     def view_my_account(context={ })       
       port = context[:request].port       
       if port == 443       
         port = ''          
       else
         port = ':' + port.to_s
       end
       
       if context[:request].ssl?
         protocol = 'https'
        else
          protocol = 'http'
        end
       
       next_url = url_for({
         :controller => 'authsubs', 
         :action => 'finish', 
         :only_path => false, 
         :host => context[:request].host + port,
         :protocol => protocol
        })        
       
       return context[:controller].send(:render_to_string, {
           :partial => 'shared/view_my_account_gdocs',
           :locals => {
             :user => context[:user], 
             :account_email => context[:user].googledocs_preference(:account_email),
             :app_domain => context[:user].googledocs_preference(:app_domain),
             :authsub_link => context[:user].authsub_link(next_url)
           }
         })
     end
     
     
     def view_issues_form_details_bottom(context={ })
     
       return context[:controller].send(:render_to_string, {
         :partial => "hooks/view_issues_form_details_bottom",
         :locals => context
         })
     
     end
    end 
  end
end