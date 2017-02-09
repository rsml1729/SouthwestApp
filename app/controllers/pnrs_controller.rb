class PnrsController < ApplicationController

  def index
    redirect_to :action => 'new'
  end
  
  def new
    @pnr = Pnr.new
  end
  
  def create
    @pnr = Pnr.new(pnr_params)
    
    if Pnr.exists?(:rcrd_loc => @pnr.rcrd_loc) || @pnr.save
      redirect_to(:action => 'show', :rcrd_loc => @pnr.rcrd_loc)
    else
      render 'new'
    end

  end
  
  def show
    @pnr = Pnr.find(params[:rcrd_loc])
    @segments = @pnr.segments
  end
  
  def destroy
    Pnr.find(params[:rcrd_loc]).destroy
    flash[:info] = "Reservation removed"
    redirect_to root_path
  end
  
  private
  def pnr_params
    params.require(:pnr).permit(:rcrd_loc, :first_name, :last_name, :email, :a_list)
  end
end
