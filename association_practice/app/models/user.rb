class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets
  has_many :favorites
  has_many :favorite_tweets, through: :favorites, source: :tweet
  has_many :post_comments


  #==========自分がフォローしているユーザーとの関連==========
  has_many :active_relationships, class_name:"Relationshhip", foreign_key: :following_id
    #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。
    #なので親はfollowing_id(フォローする側)
  has_many :followings, through: :active_relationships, source: :follower
    #中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを
    #「followings」と定義
  #==========================================================


  #==========自分がフォローされるユーザーとの関連===========
  has_many :passive_relationships, class_name:"Realtionship", foreign_key: :followed_id
    #フォローされる側のUserから見て、フォローしてくるUserを(中間テーブルを介して)集める。
    #なので親はfollower_id(フォローされる側)
  has_many :followers, through: :passive_relationships, source: :following
    #中間テーブルを介して「following」モデルのUser(フォローする側)を集めることを
    #「followers」と定義
  #=========================================================


  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)が、
    #フォローされているユーザー(つまりpassive)の中から、
    #引数に渡されたユーザー(自分)がいるかどうかを調べる
  end

end
