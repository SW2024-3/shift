class ShiftController < ApplicationController
  def index
    @chat = Chat.all
    @user = User.pluck(:name)
    @users = User.all
    next_month = Date.today.next_month
    start_of_month = next_month.beginning_of_month
    end_of_month = next_month.end_of_month
    @date_range = (start_of_month..end_of_month).to_a
    @shift = Shiftabc.where(tdate: start_of_month.beginning_of_day..end_of_month.end_of_day).group_by { |shift| [shift.user_id, shift.tdate.to_date] }
  end
  
  def new
    @shift = Shiftabc.new
  end
  
   
  def create
    b = Baito.new(add: params[:baito][:add], come: params[:baito][:come])
    b.user = User.find_by(uname: current_user.uname)
    b.save
    redirect_to shift_index_path
  end
  
  def destroy
    Shiftabc.find(params[:id]).destroy
    redirect_to shift_path
  end
end