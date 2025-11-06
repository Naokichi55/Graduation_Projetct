class CommentsController < ApplicationController
  def create
    @racket = Racket.find(params[:racket_id])
    @comment = current_user.comments.build(comment_params)
    @comment.user = current_user

#commentの内容が保存された時の動作
    if @comment.save
      ActionCable.server.broadcast(
        "racket_#{@racket.id}_comments",
        {
          comment: render_to_string(
            partial: 'comments/comment',
            locals: { comment: @comment }
          )
        }
      )
      respond_to do |format| #リクエストされる処理を分けるメソッド
        format.turbo_stream do #turbo_streamのリクエストが来た際の処理
          render turbo_stream: [
          turbo_stream.prepend("table-comment", partial: "comments/comment", locals: { comment: @comment}),
          turbo_stream.replace("comment-form", partial: "comments/form", locals: { comment: Comment.new, racket: @racket})
            ]
          end
        format.html { redirect_to @racket}
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("comment-form", partial: "comments/form", locals: { comment: @comment, racket: @racket })
        end
      end
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy!
    redirect_to racket_path(comment.racket), success: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(racket_id: params[:racket_id])
  end
end
