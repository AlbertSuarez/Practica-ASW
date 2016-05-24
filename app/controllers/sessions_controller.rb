class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    
    respond_to do |format|
      if user
        format.html {redirect_to root_path}
        format.json { render :json => user.oauth_token }
      end
    end
    
  end
  
  def error
    respond_to do |format|
        format.html {redirect_to root_path}
        format.json {render json => { :error => 'Error on authentication' } }
    end
  end
  

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
