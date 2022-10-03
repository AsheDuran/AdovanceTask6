class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])#book_ 入れた
    #@book_comment = BookComment.new#非同期機能の際に追記したけどいらんかった
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    #redirect_to request.referer
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy#id_にはbook_は追記しない
   # redirect_to request.referer
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
