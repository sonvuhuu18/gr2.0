class SubjectsController < ApplicationController
  load_and_authorize_resource

  before_action :check_status, only: :update

  def show
    session[:conversations] ||= []
    @users = User.other_users current_user.id
    @conversations = Conversation.includes(:receiver, :messages).find(session[:conversations])
  end

  private

  def check_status
    redirect_to :back unless params[:status] == Settings.finish
  end

end
