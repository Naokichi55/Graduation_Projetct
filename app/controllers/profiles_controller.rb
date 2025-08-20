class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[edit new show]
	before_action :new_profile, only: %i[new]

	def new
		@profile = Profile.new
	end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path(@profile), success: t('profiles.create.success')
    else
      flash.now[:danger] = t('profiles.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def show
		@profile = Profile.find(params[:id])
  end

  def update
		@profile = Profile.find(params[:id])
		if @profile.update(profile_params)
			redirect_to profile_path(@profile), success: t('profiles.update.success')
		else
      flash.now[:danger] = t('profiles.update.failure')
			render :new, status: :unprocessable_entity
		end
  end

  def edit
		@profile = Profile.find(params[:id])
  end

  private
  def profile_params
    params.require(:profile).permit(:racket_model, :history, :play_style, :level, :generation, :gender, :body, :icon)
  end

  def new_profile
		if current_user.profile.present?
			redirect_to rackets_path
		else
      render :new
    end
  end

end
