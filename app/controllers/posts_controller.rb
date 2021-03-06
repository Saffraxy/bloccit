class PostsController < ApplicationController

  before_action :require_sign_in, except: :show
  before_action :authorize_user, except: [:show, :new, :create]
# we find the post that corresponds to the id in the params that was passed to show
##  and assign it to @post. Unlike in the index method, in the show method, we populate
##  an instance variable with a single post, rather than a collection of posts.
  def show
    @post = Post.find(params[:id])
  end

# we create an instance variable, @post, then assign it an empty post returned by Post.new.
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
# we call Post.new to create a new instance of Post.
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user
# Redirecting to @post will direct the user to the posts show view.

    if @post.save
      @post.labels = Label.update_labels(params[:post][:labels])
# we assign a value to flash[:notice]. The flash hash provides a way to pass temporary values between actions.
#  Any value placed in flash will be available in the next action and then deleted.
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      @post.labels = Label.update_labels(params[:post][:labels])
      flash[:notice] = "Post was updated"
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving your post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
# we call destroy on @post and set flash messages to user accordingly.
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user
    post = Post.find(params[:id])
    unless current_user == post.user || current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to [post.topic, post]
    end
  end
end
