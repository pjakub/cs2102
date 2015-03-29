class PostsController < ApplicationController
  before_filter :require_user, only: [:new, :create, :edit, :destroy]
  before_filter :post_owner_is_current, only: [:edit, :destroy]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    puts params

    comment = Comment.new
    comment.comment = params[:comment]
    comment.user_id = @current_user.id

    article = Article.find(params[:article_id])

    post = Post.new
    post.article = article;
    post.comment = comment;

    if post.save
      puts "saved"
    else
      puts "not saved"
    end
    redirect_to article_path(article)

  end

  def update

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
