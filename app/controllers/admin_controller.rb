class AdminController < ApplicationController
  before_action :admin_user

  def index
    @notadmins = User.where(admin: 'f')
  end

  def make_admin
    @auser = User.find(params[:user][:id])
    if @auser.update(admin: 't')
      flash[:success] = t('admins.admin_added')
      redirect_to admin_index_path
    else
      flash[:success] = 'update ei käivitunud'
      redirect_to admin_index_path
    end


  end

  def remove_admin
    @auser = User.find(params[:id])
    if @auser.update(admin: 'f')
      flash[:success] = t('admins.admin_removed')
      redirect_to admin_index_path
    else
      flash[:success] = 'update ei käivitunud'
      redirect_to admin_index_path
    end


  end
end
