class Task < ApplicationRecord
  belongs_to :user, optional: true

  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  validates :title, presence: true
  validates :content, presence: true
end