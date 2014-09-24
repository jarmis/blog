class SynnipaevController < ApplicationController


  def index

    if  params[:user].is_a?(Hash)
      @date = Date.civil(params[:user]["birthday(1i)"].to_i, params[:user]["birthday(2i)"].to_i, params[:user]["birthday(3i)"].to_i)
        arvuta(@date)
      #end
    else
      @date = Date.today
    end




  end

  def create
    # @params params.require(:).permit(:title, :text)
    redirect_to 'synnipaev#index'
  end

  private
  def arvuta(date)
    tana = Date.today
    @vanus = ((tana - date)/365).to_i
    birthday = Date.civil(Date.today.year,date.month,date.day)
    if birthday < tana
      birthday = Date.civil((Date.today.year + 1),date.month,date.day)
    end
    @timeleft = (birthday - tana).to_i

  end

end
