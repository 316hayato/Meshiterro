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
  
  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
    # 引数に設定した値に画像サイズを変更
  end
end
