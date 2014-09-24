class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    get_and_show_posts
  end

  def index_with_button
    get_and_show_posts
  end


  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'welcome/index'
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    if @micropost.destroy
      flash[:success] = "removed post"
      redirect_to current_user
    else
      flash[:success] = "didnt remove"
      redirect_to current_user
    end
  end

  private

  def get_and_show_posts
    if params[:search]
      @search = Micropost.search(params[:search]).order("created_at DESC").paginate(:per_page => 10, :page => params[:page])

    else
      @search = Micropost.all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])

    end
    respond_to do |format|
      format.html
      format.js
    end
  end


  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    if current_user.admin or !@micropost.nil?
    else
      flash[:success] = "Need admin rights"
      redirect_to root_url
    end
  end


end