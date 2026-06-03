class Task < ApplicationRecord
  validates :title, presence: { message: I18n.t('errors.title_blank') }
  validates :content, presence: { message: I18n.t('errors.content_blank') }
end