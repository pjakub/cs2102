require 'uri'

class ArticlesController < ApplicationController
  impressionist :actions=>[:show, :index]
  before_filter :require_user, only: [:new, :create, :edit, :destroy]
  before_filter :article_owner_is_current, only: [:edit, :destroy]

  def new
    @article = Article.new
  end

  def index
    puts params[:category]
    if Article::PROPERTY_OPTIONS.has_value?(params[:category])
      @articles = Article.where(:category => params[:category])
    else
      @articles = Article.all
    end
  end

  def edit
    if article_owner_is_current
      @article = Article.find(params[:id])
    else
      error.add("Do not have Permissions to edit!")
    end
  end

  def show
    @article  = Article.find(params[:id])
    @posts    = @article.posts

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

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
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
