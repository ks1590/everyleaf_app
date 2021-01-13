class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  enum priority: { 低: 0, 中: 1, 高: 2 }

  scope :search, -> (get_params) { 
    return if get_params.blank?

    title = get_params[:title]
    status = get_params[:status]

    if title_keyword(title).blank?
      status(status)
    elsif status(status).blank?
      title_keyword(title)
    else
      title_keyword(title).status(status)
    end    
  }
  scope :title_keyword, -> (title) { title.blank? ? "" : where('title LIKE ?', "%#{title}%") }
  scope :status, -> (status) { status == "未選択" ? "" : where(status: status) }
  scope :default, -> { order(created_at: :desc) }
  scope :deadline, -> { order(deadline: :desc) }
  scope :priority, -> { order(priority: :desc) }
end
