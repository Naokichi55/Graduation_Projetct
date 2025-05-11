class CommentsController < ApplicationController

def create
	comment = current_user.comments.build(comment_params)

	if comment.save
		redirect_to racket.path(comment.racket), success: 'コメント投稿に成功しました'
	else
    redirect_to racket_path(comment.racket), danger: 'コメント投稿に失敗しました'
	end

  def comment_params
    prams.require(:comment).permit(:body).merge(racket_i: params[:racket_id])
  end
end