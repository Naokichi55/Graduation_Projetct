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
      redirect_to rackets_path, success: t('defaults.flash_message.created', item: Racket.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_created', item: Racket.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  private
  def racket_params
    params.require(:racket).permit(:product_name, :maker_name, :face_size, :main_string, :cross_string, :main_string_tension, :cross_string_tension,  :weight_position, :grip_size, :grip_tape, :body)
  end
end
