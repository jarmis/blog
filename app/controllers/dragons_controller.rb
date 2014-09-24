class DragonsController < ApplicationController

  def index
    @dragons = Dragon.all
  end

  def new
  end

  def create
    @dragon = Dragon.new(params.require(:dragon).permit(:name))
    @dragon.asleep = DateTime.now
    @dragon.stuffinbelly = 10
    @dragon.stuffinintestine = 0
    @dragon.sleep = false
    if @dragon.save
      redirect_to @dragon
    else
      render 'new'
    end
  end

  def destroy
    @dragon = Dragon.find(params[:id])
    @dragon.destroy

    redirect_to dragons_path
  end

  def show
    @dragon = Dragon.find(params[:id])

      if (DateTime.now.to_i - @dragon.asleep.to_i) > 60
        @dragon.update(:sleep => false)
      end
      @sleep = if @dragon.sleep
                 'Yes' else 'No' end
      @hungry = if @dragon.stuffinbelly <= 2
                  'I\'m hungry'
                else
                  ''
                end
      @poopy = if @dragon.stuffinintestine >= 8
                 'potty dance...'
               else
                 ''
               end
  end

  def feed
    @dragon = Dragon.find(params[:dragon_id])
    @dragon.update(:stuffinbelly => 10)
    passageoftime
    redirect_to @dragon
  end

  def walk
    @dragon = Dragon.find(params[:dragon_id])
    @dragon.update(:stuffinintestine => 0)
    passageoftime
    redirect_to @dragon
  end

  def puttobed
    @dragon = Dragon.find(params[:dragon_id])
    @dragon.update(:sleep => true, :asleep => DateTime.now)
    3.times do
      if @dragon.sleep
        unless passageoftime
          redirect_to(dragons_path)
          return
        end
      end
    end
    redirect_to @dragon
  end

  def toss
  end

  def rock
  end

  protected

  def passageoftime
    if @dragon.stuffinbelly > 0
      belly = @dragon.stuffinbelly - 1
      poopy = @dragon.stuffinintestine + 1
      @dragon.update(:stuffinbelly => belly, :stuffinintestine => poopy)

    else
      @dragon.destroy
      return false

      # @dragon.update(:sleep => false)
      # redirect_to dragon_path(@dragon), method: :delete
      # return

    end

    if @dragon.stuffinbelly <= 2 or @dragon.stuffinintestine >= 8
      @dragon.update(:sleep => false)
    end
    true
  end


end
