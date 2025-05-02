class RacketsController < ApplicationController
  def index
    @rackets = Racket.includes(:user)  #ラケット一覧を取得
  end
end
