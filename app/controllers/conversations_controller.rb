class ConversationsController < ApplicationController
  load_and_authorize_resource

  def index
    session[:conversations] ||= []
    @users = User.other_users current_user.id
    @conversations = Conversation.includes(:receiver, :messages).find(session[:conversations])
  end

  def create
    @conversation = Conversation.between(current_user.id, conversation_params[:receiver_id]).first
    unless @conversation.present?
      @conversation = current_user.conversations.create conversation_params
    end
    add_to_conversations unless conversated?
    respond_to do |format|
      format.js
    end
  end

  def close
    session[:conversations].delete(@conversation.id)
    respond_to do |format|
      format.js
    end
  end

  private
  def conversation_params
    params.require(:conversation).permit :receiver_id
  end

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include? @conversation.id
  end
end
