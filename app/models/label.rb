class Label < ApplicationRecord
  belongs_to :user, optional: true

  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings

  validates :name, presence: { message: "Please enter a name" }
end