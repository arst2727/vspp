class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true, length: { maximum: 30 }
  # マイリスト機能
  has_many :lists, dependent: :destroy
  # 楽曲のレビュー
  has_many :musical_piece_comments, dependent: :destroy
  # DM機能
  has_many :messages, dependent: :destroy
  has_many :member_rooms, dependent: :destroy
  has_many :rooms, through: :member_rooms
  # ActiveStorageを利用したプロフィール画像用
  has_one_attached :profile_image
  # いいね機能
  has_many :favorites, dependent: :destroy
  # 通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # ##########フォローフォロワー機能Start###########
  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  def follow(member_id)
    relationships.create(followed_id: member_id)
  end

  def unfollow(member_id)
    relationships.find_by(followed_id: member_id).destroy
  end

  def following?(member)
    followings.include?(member)
  end

  def followed?(member)
    followers.include?(member)
  end
  # ##########フォローフォロワー機能End###########

  # ##########ニックネーム検索機能Start###########
  scope :search, -> (search_params) do
    return if search_params.blank?

    nickname_like(search_params[:nickname])
  end
  scope :nickname_like, -> (nickname) { where('nickname LIKE ?', "%#{nickname}%") if nickname.present? }
  # ##########ニックネーム検索機能End###########

  # プロフィール画像更新バリデーション
  validate :validate_profile_image

  def validate_profile_image
    return unless profile_image.attached?
    if profile_image.blob.byte_size > 4.megabytes
      profile_image.purge
      errors.add(:プロフィール画像, 'ファイルのサイズが大きすぎます。4MB未満にしてください。')
    elsif !image?
      profile_image.purge
      errors.add(:プロフィール画像, 'はjpg, jpeg, gif, pngのファイル以外には対応しておりません')
    end
  end

  def image?
    %w(image/jpg image/jpeg image/gif image/png).include?(profile_image.blob.content_type)
  end
end
