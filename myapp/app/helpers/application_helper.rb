module ApplicationHelper

  def user_name_of_commentable(object)
      comment = object.comment
      unless comment.nil?
        user = comment.user
        unless user.nil?
          user.first_name + " " + user.last_name
        end
      end

  end

  def comment_of_commentable(object)
      comment = object.comment
      unless comment.nil?
        comment.comment
      end

  end

  def title_of_commentable(object)
      comment = object.comment
      unless comment.nil?
        comment.title
      end

  end

  def number_of_likes_of_commentable(object)
      comment = object.comment
      unless comment.nil?
        comment.likers(User).count
      end

  end

  def like_commentable(object)
    if @current_user.likes?(object.comment)
      @current_user.unlike!(object.comment)
    else
      @current_user.like!(object.comment)
    end
  end

end
