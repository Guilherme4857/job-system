class CompanySocialWeb < ApplicationRecord
  belongs_to :company

  validates :address_web, presence: true
  validates :address_web, uniqueness: true
end
