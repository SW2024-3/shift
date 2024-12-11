class ShiftController < ApplicationController
  def index
    @chat = Chat.all
    @user = User.pluck(:name)
    @users = User.all
    next_month = Date.today.next_month
    start_of_month = Date.today.next_month.beginning_of_month
    end_of_month = Date.today.next_month.end_of_month
    @date_range = (start_of_month..end_of_month).to_a
    user = User.find_by(uname: session[:login_uname])
    @shift = Shiftabc.where(user_id: user.id, tdate: start_of_month.beginning_of_day..end_of_month.end_of_day)

    @total = Shiftabc.where(user_id: current_user.id, tdate: start_of_month..end_of_month)
    @total_days = @total.count
    @total_hours = @total.sum(:shift) * 5 
    jikyu=current_user.money || 0
    @total_price = @total_hours * jikyu
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