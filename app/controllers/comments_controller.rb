class CommentsController < ApplicationController
  def create
    @racket = Racket.find(params[:racket_id])
    @comment = current_user.comments.build(comment_params)
    @comment.user = current_user

#commentの内容が保存された時の動作
    if @comment.save
      icon_url = if @comment.user.profile&.icon.present? # アイコンのURLを取得(見え方をユーザーによって切り替えるため)
        Rails.application.routes.url_helpers.rails_blob_path(
          @comment.user.profile.icon.variant(resize_to_fill: [30, 30]),
          only_path: true
        )
      else
        ActionController::Base.helpers.asset_path('sample_profile.jpg')
      end

        CommentsChannel.broadcast_to(
        "racket_#{@racket.id}_comments",
        {
          action: 'create', #削除機能を実装するため、どのアクションか明示する必要がある。
          comment_id: @comment.id,
          user_id: @comment.user_id,
          user_name: @comment.user.name,
          body: @comment.body,
          icon_url: icon_url
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
     Rails.logger.info "Broadcasting destroy for comment #{@comment.id} on racket #{racket_id}"
     CommentsChannel.broadcast_to(
      "racket_#{racket_id}_comments",
      {
        action: 'destroy',
        comment_id: @comment.id
      }
     )
     head :ok
    else
    head :unprocessable_entity
    end
  end
  private

  def comment_params
    params.require(:comment).permit(:body).merge(racket_id: params[:racket_id])
  end
end
