class ChatsController < ApplicationController
  def new
    @chat = Chat.new
  end
  
  def create
    c = Chat.new(add: params[:chat][:add], come: params[:chat][:come])
    c.user = User.find_by(uname: current_user.uname)
    c.save
    redirect_to shift_index_path
  end
  
  def destroy
    Chat.find(params[:id]).destroy
    redirect_to chat_path
  end
end
