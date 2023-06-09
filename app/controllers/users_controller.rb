class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  # is_matching_login_userメゾットをedit,updateのアクションのときに実行使用
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
    redirect_to user_path(@user.id)
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    # ユーザーIDを取得し格納
    unless user.id == current_user.id
    # ログインユーザーが取得したIDのユーザーか
      redirect_to post_images_path
      # 違う場合は投稿一覧画面へ
    end
  end
end
