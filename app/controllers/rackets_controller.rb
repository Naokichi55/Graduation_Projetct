class RacketsController < ApplicationController
  def index
    @rackets = Racket.includes(:user)  # ラケット一覧を取得
  end

  def new
    @racket = Racket.new
  end

  def create
    @racket = current_user.rackets.build(racket_params)
    if @racket.save
      redirect_to rackets_path, success: "ラケットの投稿に成功しました"
    else
      flash.now[:danger] = "ラケットの投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  # 詳細ページへのアクション
  def show
    @racket = Racket.find(params[:id])
  end

  # 投稿したラケット情報を更新するためのアクション
  def update
    @racket = Racket.find(params[:id])
    if @racket.update(racket_params)
      redirect_to racket_path(@racket), success: "ラケット情報の更新に成功しました"
    else
      flash.now[:danger] = " ラケットの投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  # ラケット編集ページへのアクション
  def edit
    @racket = current_user.rackets.find(params[:id])
  end

  # ラケットの投稿削除アクション
  def destroy
    racket = current_user.rackets.find(params[:id])
    racket.destroy!
    redirect_to rackets_path, success: '投稿したマイラケ情報を削除しました。'
  end


  private
  def racket_params
    params.require(:racket).permit(:product_name, :maker_name, :face_size, :main_string, :cross_string, :main_string_tension, :cross_string_tension,  :weight_position, :grip_size, :grip_tape, :body,images:[])
  end
end
