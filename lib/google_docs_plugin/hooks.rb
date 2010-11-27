module GoogleDocsPlugin
  
  module Hooks
   
   class LayoutHook < Redmine::Hook::ViewListener
     
     
     def view_my_account(context={ })
       return context[:controller].send(:render_to_string, {
           :partial => 'shared/view_my_account_gdocs',
           :locals => {:user => context[:user], :account_email => context[:user].googledocs_preference(:account_email) }
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