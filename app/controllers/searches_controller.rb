class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]#params[:range]→検索モデル

    if @range == "User"#if文を使い、検索モデルUserorBookで条件分岐させる
      @users = User.looks(params[:search], params[:word])#params[:search]→検索方法
    else
      @books = Book.looks(params[:search], params[:word])#params[:word]→検索ワード
    end#lookメソッドを使い,検索内容を取得し,変数に代入.定義は各もモデルに記載
  end

end

#下記の方法でも可能(上記のインスタンス変数名だと意味不明なのでインスタンス変数変更
#def search
	#@model = params[:model]
	#@content = params[:content]
	#@method = params[:method]
	#if @model == 'user'
		#@records = User.search_for(@content, @method)
	#else
		#@records = Book.search_for(@content, @method)
	#end
	#end
#end
