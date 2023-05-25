class PostImage < ApplicationRecord
  #has_one_attached←画像を扱うためのimageカラムを追記
  has_one_attached :image
  # "belongs to〜"とは、直訳すると「〜に属する」という意味です。
  # 1:N の「N」側にあたるモデルに、belongs_to を記載する必要があります。
  belongs_to :user
  
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

end
