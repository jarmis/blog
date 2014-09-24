class LikesController < ApplicationController
  before_action :signed_in_user

  def create
    @micropost = Micropost.find(params[:like][:micropost_id])
    current_user.likes.create!(micropost_id: @micropost.id, hinne: params[:like][:hinne])
    redirect_to root_path
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_to root_path
  end

end