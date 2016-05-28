class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    
    if session[:url]
      url = session[:url] + '&token=' + user.oauth_token + '&userid=' + user.id + '&username=' + user.name
      session[:url] = nil
      redirect_to url
    else
      redirect_to root_path
    end
  end
  
  def redirecciona
    session[:url] = params[:url]
    redirect_to '/auth/google_oauth2'
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
