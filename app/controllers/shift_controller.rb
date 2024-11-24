class ShiftController < ApplicationController
  def index
    @chat = Chat.all
    @user = User.pluck(:name)
    next_month = Date.today.next_month
    start_of_month = next_month.beginning_of_month
    end_of_month = next_month.end_of_month
    @date_range = (start_of_month..end_of_month).to_a
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