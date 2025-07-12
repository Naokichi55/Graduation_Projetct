class ProfilesController < ApplicationController
	def new
		@profile = Profile.new
	end

 def create
	@profile = current_user.profiles.build(profile_params)
	if @profile.save
		redirect_to profile_path, status: :unprocessable_entity
	else
    flash.now[:danger] = "プロフィール作成に失敗しました"
    render :new, status: :unprocessable_entity
  end

  private
  def profile_params
	  params.require(:profile).permit(:racket_model, :history, :play_style, :level, :gender, :body)
  end
end