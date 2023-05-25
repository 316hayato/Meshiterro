Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  # onlyオプションを使用することで、生成するルーティングを限定することができます。
  resources :post_images, only: [:new, :create, :index, :show]
  # この場合、only の後に配列で記述されている"new","index","show"のアクション以外は、ルーティングが行われません。
  get 'homes/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
