class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  # 投稿データの保存
  def create
    @post_image = PostImage.new(post_image_params)
    # @post_image は、PostImage.new によって生成された、PostImage の空のモデル
    @post_image.user_id = current_user.id
    # "[モデル名].[カラム名]" @post_image.user_id : 投稿したユーザを識別する ID
    # current_user は、コードに記述するだけで、ログイン中のユーザーの情報を取得できる便利な記述( devise のヘルパーメソッド)
    @post_image.save
    redirect_to post_images_path
  end
  
  def index
    @post_images = PostImage.all
  end
  
  def show
  end

    # 投稿データのストロングパラメータ
  private

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end

end
