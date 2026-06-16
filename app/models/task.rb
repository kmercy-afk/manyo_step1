class Task < ApplicationRecord
  belongs_to :user

  enum priority: { low: 0, medium: 1, high: 2 }
  enum status: { not_started: 0, in_progress: 1, completed: 2 }

  validates :title, presence: true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  scope :latest, -> { order(created_at: :desc) }
  scope :deadline_sort, -> { order(deadline_on: :asc) }
  scope :priority_sort, -> { order(priority: :desc) }
  scope :search_title, ->(title) { where('title LIKE ?', "%#{title}%") }
  scope :search_status, ->(status) { where(status: status) }
end