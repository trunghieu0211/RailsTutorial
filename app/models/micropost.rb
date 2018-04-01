class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_micropost, ->{order created_at: :desc}
  scope :load_feed, ->id{where "user_id = ?", id}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content.max_length}
end
