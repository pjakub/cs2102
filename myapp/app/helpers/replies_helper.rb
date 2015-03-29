module RepliesHelper
  def user_name_of_reply(reply)
    comment = reply.comment
    unless comment.nil?
      user = comment.user
      unless user.nil?
        user.first_name + " " + user.last_name
      end
    end
  end

  def reply_comment(reply)
    comment = reply.comment
    unless comment.nil?
      comment.comment
    end
  end
end
