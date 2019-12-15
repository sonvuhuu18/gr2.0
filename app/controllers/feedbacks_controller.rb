class FeedbacksController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def create
    @feedback = current_user.feedbacks.build feedback_params
    @feedback.save
    respond_to do |format|
      format.html {redirect_to feedbacks_path}
      format.js
    end
  end

  def edit
  end

  def update
    if @feedback.update_attributes feedback_params
      flash[:success] = t "OK"
      respond_to do |format|
        format.html {redirect_to @feedback}
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html {redirect_to feedbacks_path}
      format.js
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit :title, :content
  end

 end
