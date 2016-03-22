class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

#19, we find the post that corresponds to the id in the params that was passed to show
##  and assign it to @post. Unlike in the index method, in the show method, we populate
##  an instance variable with a single post, rather than a collection of posts.
  def show
    @post = Post.find(params[:id])
  end

#7, we create an instance variable, @post, then assign it an empty post returned by Post.new.
  def new
    @post = Post.new
  end

  def create
#9, we call Post.new to create a new instance of Post.
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
#10 Redirecting to @post will direct the user to the posts show view.
    if @post.save
#11, we assign a value to flash[:notice]. The flash hash provides a way to pass temporary values between actions.
#  Any value placed in flash will be available in the next action and then deleted.
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
  end
end
