class AuthsubsController < ApplicationController
  unloadable
  
  def listdocs    
    
    
    token = User.current.authsubtoken
    
    if token.nil? || token.empty?
      return render :partial => 'notconnected'
    end
    
    client = GData::Client::DocList.new
    client.authsub_token = token
    
    @docs = {}
    feed = client.get('http://docs.google.com/feeds/documents/private/full?title=' + URI.escape(params[:q])).to_xml
    
    feed.elements.each('entry') do |entry|
      entry.elements.each('link') do |link|      
        if link.attribute('rel').value == 'alternate'
          @docs[link.attribute('href').value] = entry.elements['title'].text
          break
        end
      end
    end
    
    render :partial => 'listdocs'
  end  
  
  
  def disconnect
    
    user = User.current
    user.authsubtoken = nil
    
    if user.save
      flash[:notice] =  l(:gdocs_disconnect_success)
    else       
      flash[:error] = l(:gdocs_disconnect_failure)
    end
    
    redirect_to :controller => 'my', :action => 'account'
    
  end
  
  def finish
    
    begin

      client = GData::Client::DocList.new
      client.authsub_token = params[:token] # extract the single-use token from the URL query params
      session[:token] = client.auth_handler.upgrade()
      client.authsub_token = session[:token] if session[:token]    

      user = User.current
      user.authsubtoken = session[:token]
      user.save    

      flash[:notice] = "Google Account connected successfully."    
      
    rescue GData::Client::AuthorizationError => e

      flash[:error] = "An authorization error occurred while connecting your Google Account."    
      
    end
    
    redirect_to :controller => 'my', :action => 'account'
    
  end
end
