class Task < ApplicationRecord
  validates :title, presence: { message: :blank_title }
  validates :content, presence: { message: :blank_content }
end