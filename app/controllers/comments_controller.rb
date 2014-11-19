class CommentsController < ApplicationController
  def create
    @comment = Comment.create(allowed_params)
    if @comment.save
      redirect_to dashboard_path(current_user)
    end
  end

  private

  def allowed_params
    params.require(:comment).permit(:text).merge!(user_id: params[:user_id], rant_id: params[:rant_id])
  end
end