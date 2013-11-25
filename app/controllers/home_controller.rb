class HomeController < ApplicationController
  def index
  	if current_user.present?
      @reviews = Review.all
      fetch_posts_activity_details(current_user.uid)
    else
      logger.debug "--------------------not login----------------------"
    end  
  end	

  def fetch_posts_activity_details(uid)
  	
    @graph = Koala::Facebook::API.new(oauth_access_token)
    @profile = @graph.get_object("me")
    @profile_pic = @graph.get_picture(@profile['id'])
    #@friends = @graph.get_connections("me", "friends")
    @friends_profile = @graph.get_connections(uid, "friends", fields: "name,birthday,gender,location,picture.type(small)", limit: 5)

    logger.debug { "-----#{@profile}-----#{@friends_profile}-----" }

  end

  def oauth_access_token
    'CAACEdEose0cBANdPjhNEfkoaXoiNrUBBCkC8hjw6OUhLAuuHFKBlJj7W19kUlr6ZAZALAmjFlMiPLnot4xxDa6lPVgdz2aFZAMM0xWOTIH9FJSZCYV5O8CfuYRQvrfouooHVNZCXC8EjrVc1UZBNDlElBFbaZAIQW1KirFZAvCpooJGuwLOazPeDbBk8LlHZCWuOurhkkrHMofwZDZD'
  end	

end