# 1:Nの関連付け(アソシエーション)をモデルに実装(N側)
class PostImage < ApplicationRecord
  #has_one_attached←画像を扱うためのimageカラムを追記
  has_one_attached :image
  # "belongs to〜"とは、直訳すると「〜に属する」という意味です。
  belongs_to :user
  # 1:N の「N」側にあたるモデルに、belongs_to を記載する必要があります。
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # PostImageが削除された時に、そのPostImageが持ってるPostComment,Favoriteが全て削除される
  
  validates :shop_name, presence: true
  validates :image, presence: true
  # バリデーション(入力チェックの機能)を追加
  # validates:対象項目, presence:存在確認
  
  def get_image
    unless image.attached?
      # 画像が設定されない場合
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      # app/assets/imagesに格納されているno_image.jpgという画像をデフォルト画像としてActiveStorageに格納
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      # 格納した画像を表示
    end
    image
  end

  def favorited_by?(user)
    # 引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べます。
    favorites.exists?(user_id: user.id)
    # 存在していればtrue、存在していなければfalseを返す
  end
end
