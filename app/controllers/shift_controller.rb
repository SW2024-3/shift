class ShiftController < ApplicationController
  def index
    @chat = Chat.all
    @user = User.pluck(:name)
    @users = User.all
    next_month = Date.today.next_month
    start_of_month = Date.today.next_month.beginning_of_month
    end_of_month = Date.today.next_month.end_of_month
    @date_range = (start_of_month..end_of_month).to_a
    @shifts = Shiftabc.where(tdate: start_of_month.beginning_of_day..end_of_month.end_of_day)
    
    user = User.find_by(uname: session[:login_uname])
    @shift = Shiftabc.where(user_id: user.id, tdate: start_of_month.beginning_of_day..end_of_month.end_of_day)

    @total = Shiftabc.where(user_id: current_user.id, tdate: start_of_month..end_of_month)
    @total_days = @total.count
    @total_hours = @total.where.not(shift: nil).count*5
    jikyu=current_user.money || 0
    @total_price = @total_hours * jikyu
    @youbi=%w[日 月 火 水 木 金 土 日]
  end
  
  def new
    @shift = Shiftabc.new
    @selected_date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
  
   
  def create
    @shift = Shiftabc.new(shift_params)
    @shift.user_id = current_user.id  # セッション中のユーザーを関連付け
  
    if @shift.save
      redirect_to shift_index_path
    else
      @selected_date = @shift.tdate || Date.today
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    Shiftabc.find(params[:id]).destroy
    redirect_to shift_path
  end
  
  private

  def shift_params
    params.require(:shiftabc).permit(:tdate, :shift)
  end
end