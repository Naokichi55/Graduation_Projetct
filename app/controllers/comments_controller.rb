class CommentsController < ApplicationController
  def create
    @racket = Racket.find(params[:racket_id])
    @comment = current_user.comments.build(comment_params)
    @comment.user = current_user

#commentの内容が保存された時の動作
    if @comment.save
      CommentsChannel.broadcast_to(
        "racket_#{@racket.id}_comments",
        {
          action: 'create', #削除機能を実装するため、どのアクションか明示する必要がある。
          comment: render_to_string(
          partial: 'comments/comment',
          locals: { comment: @comment }
          )
        }
      )
      # コメント投稿機能ではturboを使用しないためturboに関する記述を削除。
    else
      # コメント投稿機能ではturboを使用しないためエラー時の処理を変更。
      head :unprocessable_entity
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    racket_id = @comment.racket_id

    if @comment.destroy
     Rails.logger.info "Broadcasting destroy for comment #{@comment.id} on racket #{racket.id}"
     CommentsChannel.broadcast_to(
      "racket_#{racket.id}_comments",
      {
        action: 'destroy',
        comment_id: @comment.id
      }
     )
     head :ok
    else
    head :unprocessable_entity
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(racket_id: params[:racket_id])
  end
end
