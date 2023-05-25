class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # "has_many"とは、直訳すると「たくさん持っている」という意味になります。
  # 1:N の「1」側にあたるモデルに、has_many を記載する必要がある
  has_many :post_images, dependent: :destroy
  # Userが削除された時に、そのUserが投稿したPostImageが全て削除される
end
