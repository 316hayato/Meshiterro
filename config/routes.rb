Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'homes/about' => 'homes#about', as: 'about'
  # onlyオプションを使用することで、生成するルーティングを限定することができます。
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
  # この場合、only の後に配列で記述されている"new","index","show","create,"destroy"のアクション以外は、ルーティングが行われません。
    resources :post_comments, only: [:create, :destroy]
    # コメントは、投稿画像に対してコメントされるため、:post_commentsは、:post_imagesに結びつく(親子関係)
    # 親のresourcesで指定したコントローラ名に、子のresourcesで指定したコントローラ名が続くURLが生成(/post_images/:post_image_id/post_comments(.:format))
    # このような親子関係を、「ネストする」と言う
  end
  resources :users, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
