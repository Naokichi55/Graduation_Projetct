class CommentsController < ApplicationController

  def create
    comment = current_user.comments.build(comment_params)

    if comment.save
      redirect_to racket_path(comment.racket), success: 'コメント投稿に成功しました'
    else
      redirect_to racket_path(comment.racket), danger: 'コメント投稿に失敗しました'
    end
  end
  private

  def comment_params
    params.require(:comment).permit(:body).merge(racket_id: params[:racket_id])
  end
end