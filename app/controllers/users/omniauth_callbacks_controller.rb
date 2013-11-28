class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  before_filter :check_authentication

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    session[:devise_fb_token] = request.env['omniauth.auth']['credentials'].token
    if @user.persisted?
      sign_in @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      redirect_to home_index_path
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end

  private

  def check_authentication
    if user_signed_in?
      redirect_to home_index_path
      flash[:notice] = "Allready SignIn"
    end
  end
  
end