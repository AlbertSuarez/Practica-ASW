class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?
  
  config.middleware.insert_before 0, "Rack::Cors" do
    allow do
      origins '*'
      resource '*', :headers => :any, :methods => [:get, :post, :options]
    end
  end

  protected

  def json_request?
    request.format.json?
  end
  include SessionsHelper

end
