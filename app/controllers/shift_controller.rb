class ShiftController < ApplicationController
  def index
    @chat = Chat.all
  end
  
  def new
    @shift = Baito.new
  end
  
   
  def create
    b = Baito.new(add: params[:baito][:add], come: params[:baito][:come])
    b.user = User.find_by(uname: current_user.uname)
    b.save
    redirect_to shift_index_path
  end
  
  def destroy
    Baito.find(params[:id]).destroy
    redirect_to shift_path
  end
end