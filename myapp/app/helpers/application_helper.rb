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

  def upvotes_of_commentable(object)
      comment = object.comment
      unless comment.nil?
        comment.upvotes
      end

  end

end
