class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
    # 特定のユーザ（@user）に関連付けられた投稿ページ（.post_images.page）を取得し、@post_imagesに渡す という処理を行うことができます。
    # byebug
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path  
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
