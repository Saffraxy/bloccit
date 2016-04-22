class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create

    if params[:topic_id]
      @grab = Topic.find(params[:topic_id])
    elsif params[:post_id]
      @grab = Post.find(params[:post_id])
    end
    Rails.logger.info ">>>> grab: #{@grab.inspect}"
      @comment = @grab.comments.new(comment_params)
      @comment.user = current_user

      Rails.logger.info ">>> comment: #{@comment.inspect}"
      Rails.logger.info ">>>> comment valid? #{@comment.valid?}"

      if @comment.save

        if @grab.is_a?(Post)
          flash[:notice] = "Comment saved successfully."
          redirect_to [@grab.topic, @grab]
        elsif @grab.is_a?(Topic)
          flash[:notice] = "Comment saved successfully."
          redirect_to [@grab]
        else
          flash[:notice] = "Grab didn't know what it was"
          redirect_to root_path
        end
      else
        flash[:alert] = "There was a problem saving this comment"
        redirect_to :back
      end
    end
#      elsif params[:post_id]
#        flash[:alert] = "Comment failed to save."
#        redirect_to [@grab.topic, @grab]
#      elsif params[:topic_id]
#        flash[:alert] = "Comment failed to save."
#        redirect_to [@grab]
#      end
#    end

  def destroy
    if params[:topic_id]
      @grab = Topic.find(params[:topic_id])
    elsif params[:post_id]
      @grab = Post.find(params[:post_id])
    end

    comment = @grab.comments.find(params[:id])

    if comment.destroy
        flash[:notice] = "Comment was deleted."
        redirect_to :back
    else
        flash[:alert] = "Comment couldn't be deleted. Try again."
        redirect_to :back
    end
  end

private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end
end
