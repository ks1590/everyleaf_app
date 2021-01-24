class User < ApplicationRecord
  validates :name, presence: true, length:{ maximum: 30 }
  validates :email, presence: true, length:{ maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_many :tasks, dependent: :destroy

  before_destroy :destroy_one_admin_present
  before_update :update_one_admin_present

  private
  def destroy_one_admin_present
    throw(:abort) if User.where(admin: true).count <= 1 && self.admin == true
  end

  def update_one_admin_present
    if User.where(admin: true).size == 1 && self.admin == false
      errors.add(:admin,"は最低１人必要です")
      throw(:abort)
    end
  end
end
