class PostsController < ApplicationController
  before_filter :require_user, only: [:new, :create, :edit, :destroy, :update]
  before_filter :post_owner_is_current, only: [ :destroy]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    comment = Comment.new
    comment.comment = params[:comment]
    comment.user_id = @current_user.id

    @article = Article.find(params[:article_id])

    @post = Post.new
    @post.article = @article;
    @post.comment = comment;

    if @post.save
      puts "saved"
    else
      puts "not saved"
    end

    @posts    = @article.posts.order('created_at DESC')

    respond_to do |format|
      format.html {redirect_to article_path(@article)}
      format.js
    end



  end

  def update

    @post = Post.find(params[:id])
    @article = Article.find(params[:article_id])

    if @current_user.likes?(@post.comment)
      @current_user.unlike!(@post.comment)
    else
      @current_user.like!(@post.comment)
    end

    respond_to do |format|
      format.html {redirect_to article_path(@article)}
      format.js
    end

  end

  def destroy

  end

  private
  def post_params
    params.permit(:text)
  end

  def post_owner_is_current
    post = Post.find(params[:id])
    if @post.comment.user_id != @current_user.id
      store_location
      flash[:notice] = "You must be owner of thread."
      redirect_to articles_path
      return false
    end
  end

end
