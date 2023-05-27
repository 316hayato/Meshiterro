class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :post_image
  # 1:N の「N」側にあたるモデルに、belongs_to を記載する必要がある
end
