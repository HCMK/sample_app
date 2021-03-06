class Micropost < ApplicationRecord
  belongs_to :user
  default_scope ->{order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content_max}
  validate  :picture_size

  private

  def picture_size
    return unless picture.size > Settings.file_size.megabytes
    errors.add :picture, t("pic_size")
  end
end
