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
    if @post_image.save
    # バリデーションの結果を、コントローラで検出
    # データが保存された場合はsaveメソッドがtrue
      redirect_to post_images_path
      # redirect_toによりリダイレクト
    else
      # 保存できなかった場合はsaveメソッドがfalse
      render :new
      # renderによりpost_images/new.html.erbが表示され投稿ページを再表示
    end
  end

  def index
    @post_images = PostImage.page(params[:page])
    # 1ページ分の決められた数のデータだけを、新しい順に取得するように変更
    # pageメソッドは、kaminariをインストールしたことで使用可能になったメソッド
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
    # コメントを投稿するためのインスタンス変数を定義
  end
  
  def destroy
    post_image = PostImage.find(params[:id]) # 削除するPostImageレコードを取得
    post_image.destroy # post_image.削除
    redirect_to '/post_images' #PostImageの一覧ページへのパス
  end

    # 投稿データのストロングパラメータ
  private

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end

end
