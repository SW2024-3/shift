class ShiftController < ApplicationController
  def index
    @chats = Chat.all
  end
end
