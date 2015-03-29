require 'uri'

class ArticlesController < ApplicationController
  before_filter :require_user, only: [:new, :create, :edit, :destroy]
  before_filter :article_owner_is_current, only: [:edit, :destroy]

  def new
    @article = Article.new
  end

  def index
    puts Article.all.count
    category = Rack::Utils.parse_query URI(request.original_url).query
    puts category
      if category['category'] == "business"
        puts "hello business"
        @articles = Article.where(:category => 'business')
      elsif category['category'] == "news"
        @articles = Article.where(:category => 'news')
      elsif category['category'] == "technology"
        @articles = Article.where(:category => 'technology')
      else
        @articles = Article.all
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
    @article = Article.find(params[:id])
  end

  def create
    puts article_params
    @article = @current_user.articles.build(article_params)
    if @article.save
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
      if @article.user_id != @current_user.id
        store_location
        flash[:notice] = "You must be owner of thread to delete."
        redirect_to articles_path
        return false
      end
    end
end
