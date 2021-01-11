class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  enum priority: { 低: 0, 中: 1, 高: 2 }

  # scope :search, -> (get_params) do
  #   name = get_params[:name]
  #   return if get_params.blank?
  #   if name.present?
  #     name_like(name)
  #   end
  # end
  scope :deadline, -> { order(deadline: :desc) }
  scope :default, -> { order(created_at: :desc) }
end
