class CommentsController < ApplicationController
  def create
    comment = Comment.create(post_id: comment_params[:post_id], user_id: current_user.id, text: comment_params[:text])
    redirect_to "/posts/#{comment.post_id}"
  end

  private
  def comment_params
    params.permit(:text, :post_id)
  end
end
