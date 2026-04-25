class LikesController < ApplicationController
 def create 
	@link = current_user.likes,build(racket_id: params[:racket_id])
	@likes.save
	redirect_back(fallback_location: root_path)
 end

  def destroy
		@like = current_user.likes.find_by(racket: params[:racket_id])
		@like.destroy!
		redirect_back(fallback_location: root_path)
  end

end
