class HomeController < ApplicationController
  def index
  	if current_user.present?
      @reviews = Review.all
      begin
        fetch_friends_details(current_user.uid)
      rescue Exception => exc
        logger.error "Message for the log file #{exc.message}"
        flash[:alert] = "User log out, because #{exc.message}"
        destroy_user_session_path
      end  
    else
      logger.debug "--------------------not login----------------------"
    end  
  end	
  
  private
  def fetch_friends_details(uid)
    @graph = Koala::Facebook::API.new(oauth_access_token)
    @profile = @graph.get_object("me")
    @profile_pic = @graph.get_picture("me")
    #@friends = @graph.get_connections("me", "friends")
    @friends_profile = @graph.get_connections(uid, "friends",
      fields: "name,birthday,gender,location,picture.type(small)",
      limit: 5
    )

    logger.debug "---friends...#{@friends_profile}-----"
    logger.debug "---oauth_access_token ...#{oauth_access_token}------"
    logger.debug "---profile...#{@profile}-----"
  end

  def oauth_access_token
    session[:devise_fb_token]
  end	

  # def oauth_access_token_new
  #   @oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'],
  #     ENV['FACEBOOK_SECRET'])
  #   @oauth.get_app_access_token
  # end

end