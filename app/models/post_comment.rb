# 1:Nの関連付け(アソシエーション)をモデルに実装(N側)
class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_image
  # 1:N の「N」側にあたるモデルに、belongs_to を記載する必要があります。
end
