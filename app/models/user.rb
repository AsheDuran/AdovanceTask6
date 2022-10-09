class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :group_users, dependent: :destroy#グループ化
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy#フォロー機能で追記
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy#フォロー機能で追記

  has_many :followings, through: :relationships, source: :followed#フォロー機能で追記
  has_many :followers, through: :reverse_of_relationships, source: :follower#フォロー機能で追記

  has_many :user_rooms, dependent: :destroy#チャット機能で追記
  has_many :chats, dependent: :destroy#チャット機能で追記

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction,length: {maximum:50}


  #プロフ画像初期設定
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  #フォロー,フォロワーの実装
  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  #検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")#nameは検索対象であるusersテーブル内のカラム名.適宜、適したカラム名を指定
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end

#検索方法分岐-解答パターン
  #def self.search_for(content, method)
    #if method == 'perfect'
      #User.where(name: content)
    #elsif method == 'forward'
      #User.where('name LIKE ?', content + '%')
    #elsif method == 'backward'
      #User.where('name LIKE ?', '%' + content)
    #else
      #User.where('name LIKE ?', '%' + content + '%')
    #end
  #end