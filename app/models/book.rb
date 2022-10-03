class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 検索方法分岐・・・送られてきたsearchによって条件分岐させる
  def self.looks(search, word)
    if search == "perfect_match"#完全一致
      @book = Book.where("title LIKE?","#{word}")#titleは検索対象であるbooksテーブル内のカラム名
    elsif search == "forward_match"#前方一致
      @book = Book.where("title LIKE?","#{word}%")#whereメソッドをを使いデータベースから該当データを取得し,変数に代入
    elsif search == "backward_match"#後方一致
      @book = Book.where("title LIKE?","%#{word}")#完全一致以外の検索方法は、#{word}の前後(もしくは両方に)、__%__を追記することで定義
    elsif search == "partial_match"#部分一致
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
end

#検索方法分岐-解答-
  #def self.search_for(content, method)
    #if method == 'perfect'
      #Book.where(title: content)
    #elsif method == 'forward'
      #Book.where('title LIKE ?', content+'%')
    #elsif method == 'backward'
      #Book.where('title LIKE ?', '%'+content)
    #else
      #Book.where('title LIKE ?', '%'+content+'%')
    #end
  #end