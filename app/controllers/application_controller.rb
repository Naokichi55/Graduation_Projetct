class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :configure_permitted_parameters, if: :devise_controller?#ユーザー登録時に名前を登録できるように追記
  allow_browser versions: :modern

  def configure_permitted_parameters #ユーザー登録時に名前を登録できるように定義
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
  end

  private

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end  

