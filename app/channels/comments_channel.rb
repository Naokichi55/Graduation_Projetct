class CommentsChannel < ApplicationCable::Channel
# 読み込むチャンネルを記載
  def subscribed
    stream_for "racket_#{params[:racket_id]}_comments" #stream_fromからstream_forに変更。
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
