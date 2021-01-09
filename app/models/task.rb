class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  enum priority: { 低: 0, 中: 1, 高: 2 }
end
