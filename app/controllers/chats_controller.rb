class ChatsController < ApplicationController
  def index
    @chat = Chat.all
  end
  
  def show
    @chat = Chat.all
  end
  
  def new
    @chat = Chat.new
  end
  
  def create
    c = Chat.new(add: params[:chat][:add], come: params[:chat][:come])
    c.user = User.find_by(uname: current_user.uname)
    c.save
    redirect_to chats_path
  end
  
  def destroy
    Chat.find(params[:id]).destroy
    redirect_to chat_path
  end
end
