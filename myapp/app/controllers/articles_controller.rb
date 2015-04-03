require 'uri'

class ArticlesController < ApplicationController
  impressionist :actions=>[:show, :index]
  before_filter :require_user, only: [:new, :create, :edit, :destroy, :update]
  before_filter :article_owner_is_current, only:[:destroy]

  def new
    @article = Article.new
  end

  def index
    puts params[:category]
    if Article::PROPERTY_OPTIONS.has_value?(params[:category])
      @articles = Article.where(:category => params[:category]).paginate(:page => params[:page], :per_page => 3)
    else
      @articles = Article.all.paginate(:page => params[:page], :per_page => 3)
    end
  end

  def edit
    if article_owner_is_current
      @article = Article.find(params[:id])
    else
      #error.add("Do not have Permissions to edit!")
    end
  end

  def show
    @article  = Article.find(params[:id])
    @posts    = @article.posts

    @posts    = @posts.order('created_at DESC')
    current_user
    @user = @current_user

  end

  def create
    comment = Comment.new
    comment.title = params[:title]
    comment.comment = params[:comment]
    comment.user_id = @current_user.id

    article = Article.new
    article.comment = comment
    article.category = Article::PROPERTY_OPTIONS[params[:category]]

    if article.save
      puts "saved"
      redirect_to articles_path(@article)
    else
      puts "not saved"
      redirect_to articles_path
    end

  end

  #I am using update to update the likes
  def update
    @article = Article.find(params[:id])

    if @current_user.likes?(@article.comment)
      @current_user.unlike!(@article.comment)
    else
      @current_user.like!(@article.comment)
    end

    puts "HI TEST"
    respond_to do |format|
      format.html {redirect_to article_path(article)}
      format.js
    end
  end



  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text, :category)
    end

    def article_owner_is_current
      @article = Article.find(params[:id])
      if @article.comment.user_id != @current_user.id
        store_location
        flash[:notice] = "You must be owner of thread to delete."
        redirect_to articles_path
        return false
      end
    end
end
