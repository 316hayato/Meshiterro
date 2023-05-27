class FavoritesController < ApplicationController
  
  def create
    post_image = PostImage.find(params[:post_image_id])
    # 対象の投稿
    favorite = current_user.favorites.new(post_image_id: post_image.id)
    # 対象の投稿にログインしてるユーザーが新しく「いいね」をつける
    favorite.save
    # 「いいね」を付けたら保存
    redirect_to post_image_path(post_image)
    # 保存された後は、post_imagesのshowページへリダイレクト
  end

  def destroy
    post_image = PostImage.find(params[:post_image_id])
    # 対象の投稿
    favorite = current_user.favorites.find_by(post_image_id: post_image.id)
    # ログインしてるユーザーが「いいね」している対象の投稿を見つける
    favorite.destroy
    # 「いいね」を削除
    redirect_to post_image_path(post_image)
    # 削除した後は、post_imagesのshowページへリダイレクト
  end
  
end
