class AuthsubsController < ApplicationController
  unloadable
  
  def listdocs    
    client = GData::Client::DocList.new
    client.authsub_token = User.current.authsubtoken
    @feed = client.get('http://docs.google.com/feeds/documents/private/full?title=' + params[:q]).to_xml
    render :partial => 'listdocs'
  end  
  
  def finish
    
    client = GData::Client::DocList.new
    client.authsub_token = params[:token] # extract the single-use token from the URL query params
    session[:token] = client.auth_handler.upgrade()
    client.authsub_token = session[:token] if session[:token]    
    
    user = User.current
    user.authsubtoken = session[:token]
    user.save    
    
    flash[:notice] = "Google Account connected successfully!"    
    redirect_to :controller => 'my', :action => 'account'
    
  end
end