class WelcomeController < ApplicationController
  def index
    @posts = Like.select('*, COUNT(1) AS total').group(:micropost_id).order('COUNT(1) DESC').first(10) if current_user.nil?

    # SELECT *, COUNT(*) FROM likes GROUP BY micropost_id ORDER BY COUNT(*) DESC
    # @poststop = Like.find(micropost_id)
    @micropost = current_user.microposts.build if signed_in?
    if signed_in?
      @feed_items = current_user.feed.with_ratings.last_created
      @feed_items = @feed_items.includes(:user)
      @feed_items = @feed_items.select("COUNT(CASE WHEN likes.user_id=#{current_user.id} THEN likes.id ELSE NULL END) > 0 AS has_liked").paginate(page: params[:page])
    end


  end

  def help
    flash[:success] = t('hello')
  end

end
