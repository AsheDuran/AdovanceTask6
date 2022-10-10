class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  #has_many :favorited_users, through: :favorites, source: :user 過去1週間でいいねの多い順に投稿を表示
  has_many :book_comments, dependent: :destroy
  has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
  #上記のコードでも応用課題7aは可能
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日 応用課題7b
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日 応用課題7b
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #応用課題7b
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } #応用課題7b

  #scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
 # scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  #scope :created_2days, -> { where(created_at: 2.days.ago.all_day) } #課題8b
 # scope :created_3days, -> { where(created_at: 3.days.ago.all_day) } #課題8b
  #scope :created_4days, -> { where(created_at: 4.days.ago.all_day) } #課題8b
  #scope :created_5days, -> { where(created_at: 5.days.ago.all_day) } #課題8b
 # scope :created_6days, -> { where(created_at: 6.days.ago.all_day) } #課題8b

  #課題7bと8bは別々に定義してあった(8b解答より)

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
