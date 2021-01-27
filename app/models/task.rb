class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  validate :check_past_date

  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  enum priority: { 低: 0, 中: 1, 高: 2 }

  def check_past_date
    errors.add(:deadline, 'に過去日が入力されています。') if deadline < Date.today - 1
  end

  scope :search, -> (search_params) do
    title = search_params[:title]
    status = search_params[:status]
    label = search_params[:label_id]
    return if search_params.blank?
    title_keyword(title).check_status(status).check_label(label)
  end

  scope :title_keyword, -> (title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :check_status, -> status { where(status: status) if status.present? }
  scope :default, -> { order(created_at: :desc) }
  scope :deadline, -> { order(deadline: :desc) }
  scope :priority, -> { order(priority: :desc) }
  scope :check_label, -> label_id { joins(:labels).where(labels: { id: label_id }) if label_id.present? }
end
