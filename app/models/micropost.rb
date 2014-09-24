class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :likes


  #default_scope -> { order('microposts.created_at DESC') }
  scope :with_ratings, ->() { joins('LEFT JOIN likes ON (likes.micropost_id=microposts.id)').select('microposts.*, AVG(likes.hinne) AS rate, COUNT(likes.id) AS likes_count').group('microposts.id') }
  scope :last_created, ->() { order('microposts.created_at DESC') }

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("microposts.user_id IN (#{followed_user_ids}) OR microposts.user_id = :user_id",
          user_id: user.id)
  end

  def self.search(search)
    where("content like ?", "%#{search}%")
  end
end
