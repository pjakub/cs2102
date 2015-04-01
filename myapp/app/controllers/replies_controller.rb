class RepliesController < ApplicationController

  before_filter :require_user, only: [:new, :create, :edit, :destroy, :update]
  before_filter :reply_owner_is_current, only: [:destroy]

  def new
    @reply = Reply.new
  end

  def show
    @reply = Reply.find(params[:id])
  end

  def create
    puts params

    comment = Comment.new
    comment.comment = params[:comment]
    comment.user_id = @current_user.id

    @article = Article.find(params[:article_id])
    @post    = Post.find(params[:post_id])

    @reply = Reply.new
    @reply.article = @article
    @reply.post    = @post
    @reply.comment = comment

    if @reply.save
      puts "saved"
    else
      puts "not saved"
    end

    respond_to do |format|
      format.html {redirect_to article_path(@article)}
      format.js
    end

  end

  def update
    @article = Article.find(params[:article_id])
    @reply = Reply.find(params[:id])

    if @current_user.likes?(@reply.comment)
      @current_user.unlike!(@reply.comment)
    else
      @current_user.like!(@reply.comment)
    end

    respond_to do |format|
      format.html {redirect_to article_path(@article)}
      format.js
    end
  end

  private
  def reply_owner_is_current
    reply = Reply.find(params[:id])
    if reply.comment.user_id != @current_user.id
      store_location
      flash[:notice] = "You must be owner of thread."
      redirect_to articles_path
      return false
    end
  end

end
