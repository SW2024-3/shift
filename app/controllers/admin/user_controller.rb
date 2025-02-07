class Admin::UserController < ApplicationController
  def index
    @users = User.all
     @user = User.pluck(:name)
    next_month = Date.today.next_month
    start_of_month = next_month.beginning_of_month
    end_of_month = next_month.end_of_month
    @date_range = (start_of_month..end_of_month).to_a
    #@shift = Baito.where(tdate: @date_range).group_by { |shift| [shift.user_id, shift.tdate] }
    @shift = CopyShift.where(tdate: start_of_month.beginning_of_day..end_of_month.end_of_day).group_by { |shift| [shift.user_id, shift.tdate.to_date] }
    @youbi=%w[日 月 火 水 木 金 土 日]
  end
  
  def show
      @users = User.all
  end
  def edit
      @user = User.find(params[:id])
  end
  
  def shift_edit
    @shift = CopyShift.find(params[:id])
  end
  
  def update
    @shift = CopyShift.find(params[:id])
    if @shift.update(shift_params)
      redirect_to admin_user_index_path, notice: '情報が更新されました'
    else
      render :shift_edit, status: 422
    end
  end
  
  def update
    @shift = CopyShift.find(params[:id])
    if @shift.update(shift_params)
      redirect_to admin_user_index_path, notice: "シフトが更新されました"
    else
      render :shift_edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    date = Date.parse(params[:id])
    copy_shift = CopyShift.find_by(tdate: date.beginning_of_day..date.end_of_day)
    copy_shift.destroy
    redirect_to admin_user_index_path, notice: '削除しました'
  end

  def update_copy
    last_copied_time = CopyShift.maximum(:tcopy) || Time.at(0)
    new_shifts = Shiftabc.where("created_at > ?", last_copied_time)
  
    insert_data = new_shifts.map do |shift|
      {
        tdate: shift.tdate,     
        shift: shift.shift,
        user_id: shift.user_id,
        tcopy: Time.now
      }
    end
  
    if insert_data.any?
      CopyShift.insert_all(insert_data)
      new_shifts.each do |shift|
        copy_shift = CopyShift.find_by(tdate: shift.tdate, shift: shift.shift, user_id: shift.user_id)
        copy_shift.update(tcopy: Time.now) if copy_shift
      end
      redirect_to admin_user_index_path, notice: "新しいデータを複製しました。"
    else
      redirect_to admin_user_index_path, alert: "複製する新しいデータがありません。"
    end
  end
  
  def share
    target_year = params[:year].to_i
    target_month = params[:month].to_i
    target_date = Date.new(target_year, target_month, 1)
    next_month = Date.today.next_month
    start_of_month = next_month.beginning_of_month
    end_of_month = next_month.end_of_month
    
    @users = User.all
    @date_range = (start_of_month..end_of_month).to_a
    @shifts = Shiftabc.where(tdate: start_of_month.beginning_of_day..end_of_month.end_of_day) # 全ユーザーのシフトを取得
    @month = target_date.strftime('%Y年%m月')
    @youbi = %w[日 月 火 水 木 金 土 日]
  end
  
  private
  def shift_params
    params.require(:copy_shift).permit(:shift)
  end

end
