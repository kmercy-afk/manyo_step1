class User < ApplicationRecord
  has_secure_password

  has_many :tasks, dependent: :destroy

  before_validation :downcase_email
  before_update :ensure_admin_remains
  before_destroy :ensure_admin_exists_after_destroy

  validates :name, presence: { message: 'Please enter your name' }
  validates :email,
            presence: { message: 'Please enter your e-mail address' },
            uniqueness: { case_sensitive: false, message: 'Your email address is already in use' }

  validates :password,
            presence: { message: 'Enter your password' },
            length: {
              minimum: 6,
              message: 'Please enter the password with at least 6 characters'
            },
            allow_nil: true

  validates :password_confirmation,
            confirmation: { message: 'Password (confirmation) and password input do not match' }

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def ensure_admin_remains
    return unless admin_changed?
    return unless admin_was == true && admin == false
    return if User.where(admin: true).where.not(id: id).exists?

    errors.add(:base, 'Cannot change privileges because there are zero administrators')
    throw(:abort)
  end

  def ensure_admin_exists_after_destroy
    return unless admin?
    return if User.where(admin: true).where.not(id: id).exists?

    errors.add(:base, 'Cannot delete because there are zero administrators')
    throw(:abort)
  end
end