class FavoritesController < ApplicationController

  def create
    @books =  Book.all#非同期機能の際に追記.books/indexで呼び出すために必要-->
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)#非同期機能で＠を追加
    favorite.save
    #redirect_to request.referer 非同期機能でリダイレクトを防ぐため削除
  end

  def destroy
    @books =  Book.all#非同期機能の際に追記.books/indexで呼び出すために必要-->
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)#非同期機能で＠を追加
    favorite.destroy
    #redirect_to request.referer 非同期機能でリダイレクトを防ぐため削除
  end
end
