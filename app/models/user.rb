class User < ApplicationRecord
  #Relationships
  has_many :bank_accounts

  # Validations
  validates :name, presence: true
  validates :name, exclusion: { in: %w(admin super_admin) }
  validates :email, presence: true
  validates :email, uniqueness: true
  validate :name_should_not_be_email


  private
  def name_should_not_be_email
    if name == email
      errors.add(:name, "should not be exactly like email")
    end
  end
end
