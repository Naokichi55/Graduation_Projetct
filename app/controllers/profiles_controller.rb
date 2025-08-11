class ProfilesController < ApplicationController
	def new
		@profile = Profile.new
	end

  def create
	  @profile = current_user.build_profile(profile_params)
	  if @profile.save
		  redirect_to profile_path(@profile)
	  else
      flash.now[:danger] = "プロフィール作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
		@profile = Profile.find(params[:id])
  end

  def update
		@profile = current_user.profile
		if @profile.update(profile_params)
			redirect_to profile_path(@profile), success: "プロフィール情報の更新に成功しました"
		else
      flash.now[:danger] = "プロフィールの投稿に失敗しました"
			render :new, status: :unprocessable_entity
		end
  end

  def edit
		@profile = current_user.profile
  end

  private
  def profile_params
	  params.require(:profile).permit(:racket_model, :history, :play_style, :level, :generation, :gender, :body)
  end
end
