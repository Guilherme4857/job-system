class CompanyAddress < ApplicationRecord
  belongs_to :company

  validates :public_place, :district, 
            :city, :zip_code,
            presence: true
end
