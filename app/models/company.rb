class Company < ApplicationRecord
  has_many :company_employees
  has_many :employees, through: :company_employees
  has_many :company_social_webs
  has_one :company_address
  has_one_attached :picture
  accepts_nested_attributes_for :company_address 
end
