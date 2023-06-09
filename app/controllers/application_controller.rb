class ApplicationController < ActionController::Base
  # before_actionメソッドは、このコントローラが動作する前に実行される
  
  before_action :authenticate_user!, except: [:top]
  # authenticate_userメソッドはログイン認証が済んでいない状態でトップページ以外の画面にアクセスしても、ログイン画面へリダイレクトするようになる
  # exceptは指定したアクションをbefore_actionの対象から外します
  # ログイン認証が済んでいる場合には全てのページにアクセスすることができる
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行されます。

  # サインイン後の遷移先を設定
  def after_sign_in_path_for(resource)
    # Deviseが用意しているメソッドで、サインイン後にどこに遷移するかを設定しているメソッドです。
    post_images_path
    # 投稿画像の一覧画面ページへ遷移するように設定
  end
  
  # サインアウト後の遷移先を設定
  def after_sign_out_path_for(resource)
    # Deviseが用意しているメソッドで、サインアウト後にどこに遷移するかを設定するメソッドです。
    about_path
    # Aboutページへ遷移するように設定
  end
  
  protected
  # protectedは呼び出された他のコントローラからも参照することができます
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
