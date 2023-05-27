class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # "has_many"とは、直訳すると「たくさん持っている」という意味になります。
  # 1:N の「1」側にあたるモデルに、has_many を記載する必要がある
  has_many :post_images, dependent: :destroy
  # Userが削除された時に、そのUserが投稿したPostImageが全て削除される
  
  has_one_attached :profile_image
  # profile_imageという名前でActiveStorageでプロフィール画像を保存できるように設定
  
  def get_profile_image(width, height)
    # get_profile_image(引数を設定)←引数がないとwrong number of arguments (given 2, expected 0)のエラーになる
    unless profile_image.attached?
      # 画像が設定されない場合
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      # app/assets/imagesに格納されているsample-author1.jpgという画像をデフォルト画像としてActiveStorageに格納
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
       # 格納した画像を表示
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
    # 受け取った引数に設定した値に画像サイズを変換
  end
end
