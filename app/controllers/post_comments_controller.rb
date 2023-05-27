class PostCommentsController < ApplicationController
  def create
    post_image = PostImage.find(params[:post_image_id])
    # routes.rbにてpost_commentsのURLを作成することでparams[:post_image_id]を用いてPostImageのidが取得できる
    comment = current_user.post_comments.new(post_comment_params)
    # 新しいコメントの定義(対象ユーザーとコメントID)
    # 下記2行の記述と内容と同じ
    # comment = PostComment.new(post_comment_params) ← 新しいコメントのID
    # comment.user_id = current_user.id ← 新しいコメントをするユーザー(comment.user_id)がログイン中のユーザー(current_user.id)である
    comment.post_image_id = post_image.id
    comment.save
    redirect_to post_image_path(post_image)
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    # コメントを削除
    redirect_to post_image_path(params[:post_image_id])
    # 投稿内容詳細画面へ移動
  end
  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
